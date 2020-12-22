<#-- 获取配置文件变量，使用include包含到各模板中，include之前必须import函数模板（function.ftl） -->
<#-- common -->
<#assign class=model.variables.class>
<#assign classVar=model.variables.classVar>
<#assign sys=model.variables.sys>
<#assign scAlias=vars.scAlias>
<#assign scPlatform=vars.scPlatform>
<#assign cAlias=vars.cAlias>
<#assign cPlatform=vars.cPlatform>
<#assign app=model.variables.app>
<#assign module=model.variables.module>
<#assign comment=model.tabComment>
<#assign sub=model.sub>
<#assign subTableList=model.subTableList>
<#assign hasSub=model.hasSub>
<#assign pkModel=model.pkModel>
<#assign pk=getPk(model) >
<#assign pkVar=getPkVar(model) >
<#assign uniqueVar=getPkVar(model) >
<#assign pkType=getPkType(model)>
<#assign isBaseModule=model.variables.isBaseModule>
<#assign isGenSub=model.variables.isGenSub>
<#assign dsAlias=model.variables.dsAlias>
<#assign layer=model.layerTemplate>
<#assign gatewayMapping=model.variables.gatewayMapping>

<#-- db -->
<#assign po=class + "Po">
<#assign tableName=model.tableName>
<#assign boId=model.boId>

<#if isBaseModule = 'true'>
<#assign namespace="com."+cAlias+"."+cPlatform+"."+sys + ".persistence.entity." +po>
<#else>
<#assign namespace="com."+cAlias+"."+cPlatform+"."+sys+"." +  module + ".persistence.entity." +po>
</#if>
<#assign colList=model.columnList><#-- 含PK列 -->
<#assign commonList=model.commonList><#-- 不含PK列 -->

<#-- test -->
<#assign baseClass=model.variables.baseClass>
<#assign poVar=classVar + "Po">
