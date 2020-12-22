<#--获取查询数据类型-->
<#function getDataType colType start>
<#if (colType=="Long") > <#return "L">
<#elseif (colType=="Integer")><#return "N">
<#elseif (colType=="Double"&& start=="2")><#return "DB">
<#elseif (colType=="Double" && start=="1")><#return "DBL">
<#elseif (colType=="Double" && start=="0")><#return "DBG">
<#elseif (colType=="Short")><#return "SN">
<#elseif (colType=="Date" && start=="1")><#return "DL">
<#elseif (colType=="Date" && start=="0")><#return "DG">
<#else><#return "SL"></#if>
</#function>

<#---
********************************************
list 转string
********************************************
-->
<#function listToString object>
 <#if object??>
        <#if object?is_enumerable>
            <#local json = '['>
            <#list object as item>
                <#if item?is_number >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '${item}'>
                <#elseif item?is_string>
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '"${item?html!""?js_string}"'>
                <#elseif item?is_boolean  >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '${item?string("true", "false")}'>
                <#elseif item?is_enumerable && !(item?is_method) >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + listToString(item)>
                <#elseif item?is_hash>
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + listToString(item)>
                </#if>
            </#list>
            <#return json + ']'>
        <#elseif object?is_hash>
            <#local json = "{">
            <#assign keys = object?keys>
            <#list keys as key>
                <#if object[key]?? && !(object[key]?is_method) && key != "class">
                    <#if object[key]?is_number>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': ${object[key]}">
                    <#elseif object[key]?is_string>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': '${object[key]?html!''?js_string}'">
                    <#elseif object[key]?is_boolean >
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': ${object[key]?string('true', 'false')}">

                    <#elseif object[key]?is_enumerable >
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + '"${key}":'+ listToString(object[key])>

                    <#elseif object[key]?is_hash>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}':"+ listToString(object[key])>
                    </#if>
                </#if>
            </#list>
            <#return json +"}">
        </#if>
    <#else>
        <#return "[]">
    </#if>
</#function>

<#--将字符串 user_id 转换为 类似userId-->
<#function convertUnderLine field>
<#assign rtn><#list field?split("_") as x><#if (x_index==0)><#if x?length==1>${x?upper_case}<#else>${x?lower_case}</#if><#else>${x?lower_case?cap_first}</#if></#list></#assign>
 <#return rtn>
</#function>

<#--将字符串 user_id 转换为 类似userId-->
<#function getFkName model>
<#assign rtn><#assign fk=model.foreignKey><#list model.columnList as col><#if (fk==col.columnName)>${col.colName}</#if></#list></#assign>
 <#return rtn>
</#function>

<#--将字符串 user_id 转换为 类似userId-->
<#function getFromKeyName model pmodel>
<#assign rtn><#assign fromKey=model.fromKey><#list pmodel.columnList as col><#if (fromKey==col.columnName)>${col.colName}</#if></#list></#assign>
 <#return rtn>
</#function>

<#function getPk model>
<#assign rtn><#if (model.pkModel??) >${model.pkModel.columnName}<#else>"id"</#if></#assign>
 <#return rtn>
</#function>

<#--获取主键类型-->
<#function getPkType model>
<#list model.columnList as col>
<#if col.isPK>
<#if (col.colType=="Integer")><#assign rtn>"Long"</#assign><#return rtn>
<#else><#assign pkType=col.colType ></#if>
</#if>
</#list>
<#assign rtn>${pkType}</#assign>
<#return rtn>
</#function>

<#--获取外键类型 没有则返回Long-->
<#function getFkType model>
<#assign fk=model.foreignKey>
<#list model.columnList as col>
<#if (col.columnName?lower_case)==(fk?lower_case)>
	<#if (col.colType=="Integer")><#assign rtn>Long</#assign><#return rtn><#else><#assign rtn>${col.colType}</#assign><#return rtn></#if>
</#if>
</#list>
<#assign rtn>Long</#assign><#return rtn>
</#function>

<#function getPkVar model>
<#assign pkModel=model.pkModel>
<#assign rtn><#if (model.pkModel??) >${model.pkModel.colName}<#else>"id"</#if></#assign>
 <#return rtn>
</#function>

<#function getJdbcType dataType>
<#assign dbtype=dataType?lower_case>
<#assign rtn>
<#if  dbtype?ends_with("int") || (dbtype=="double") || (dbtype=="float") || (dbtype=="decimal") || dbtype?ends_with("number")||dbtype?starts_with("numeric") >
NUMERIC
<#elseif (dbtype?index_of("char")>-1)  >
VARCHAR
<#elseif (dbtype=="date") || (dbtype?index_of("timestamp")>-1)  || (dbtype=="datetime") >
TIMESTAMP
<#elseif (dbtype?ends_with("text") || dbtype?ends_with("clob")) >
CLOB
<#elseif (dbtype?ends_with("blob")) >
BLOB
</#if></#assign>
 <#return rtn?trim>
</#function>

<#function getJdbcType2 dataType>
<#assign dbtype=dataType?lower_case>
<#assign rtn>
<#if  dbtype?ends_with("int") || (dbtype=="double") || (dbtype=="float") || (dbtype=="decimal") || dbtype?ends_with("number")||dbtype?starts_with("numeric") >
NUMERIC
<#elseif (dbtype?index_of("char")>-1)  >
VARCHAR
<#--<#elseif (dbtype=="date")>DATE-->
<#elseif (dbtype?index_of("timestamp")>-1)  || (dbtype=="datetime") || (dbtype=="date")>
TIMESTAMP
<#elseif (dbtype?ends_with("text") || dbtype?ends_with("clob") || dbtype?ends_with("blob")) >
BLOB
</#if></#assign>
 <#return rtn?trim>
</#function>
