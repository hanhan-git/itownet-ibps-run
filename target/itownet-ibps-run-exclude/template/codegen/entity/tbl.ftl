<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.entity;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity;
</#if>

import java.util.Date;
<#if subtables?exists && subtables?size!=0>
import java.util.ArrayList;
import java.util.List;
</#if>

import com.${scAlias}.${scPlatform}.base.framework.persistence.entity.AbstractPo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * ${model.tabComment} 表对象
 * 
 *<pre> 
 <#if vars.company?exists>
 * 开发公司：${vars.company}
 </#if>
 <#if vars.developer?exists>
 * 开发人员：${vars.developer}
 </#if>
 <#if vars.email?exists>
 * 邮箱地址：${vars.email}
 </#if>
 * 创建时间：${date?string("yyyy-MM-dd HH:mm:ss")}
 *</pre>
 */
@SuppressWarnings("serial")
@ApiModel(value = "${model.tabComment}对象")
public class ${class}Tbl extends AbstractPo<String>{
	<#list model.columnList as col>
	<#if (col.colName!="createTime" && col.colName!="updateTime" && col.colName!="createBy" && col.colName!="updateBy")>
	<#if (col.colType=="java.util.Date") ||(col.colType=="Date")>
	<#if (col.paramsMap.datefmt?exists)>
	@com.fasterxml.jackson.annotation.JsonFormat(pattern = "${col.paramsMap.datefmt}")
	<#else>
	@com.fasterxml.jackson.annotation.JsonFormat(pattern = com.lc.ibps.base.core.constants.StringPool.DATE_FORMAT_DATETIME)
	</#if>
	</#if>
	@ApiModelProperty(value = "${col.comment}")
	protected ${col.colType}  ${col.colName}; 		/*${col.comment}*/
	</#if>
	</#list>

<#if (model.pkModel??) && (pkModel.colName!="id")>
	@Override
	public void setId(String ${pkModel.colName}) {
		this.${pkModel.colName} = ${pkModel.colName};
	}
	@Override
	public String getId() {
		return ${pkModel.colName};
	}	
</#if>
<#list model.columnList as col>
	<#if (col.colName!="createTime" && col.colName!="updateTime" && col.colName!="createBy" && col.colName!="updateBy")>
	public void set${col.colName?cap_first}(${col.colType} ${col.colName}) 
	{
		this.${col.colName} = ${col.colName};
	}
	/**
	 * 返回 ${col.comment}
	 * @return
	 */
	public ${col.colType} get${col.colName?cap_first}() 
	{
		return this.${col.colName};
	}
	</#if>
</#list>
	
}