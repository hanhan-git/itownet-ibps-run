<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.entity;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity;
</#if>

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
import java.util.ArrayList;
</#if>
import com.${scAlias}.${scPlatform}.base.core.util.JacksonUtil;
import io.swagger.annotations.ApiModel;

/**
 * ${model.tabComment} 实体对象
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
public class ${class}Po extends ${class}Tbl{
	<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
	private boolean delBeforeSave = true;
	public boolean isDelBeforeSave() {
		return delBeforeSave;
	}
	public void setDelBeforeSave(boolean delBeforeSave) {
		this.delBeforeSave = delBeforeSave;
	}	
	<#list model.subTableList as subTable>
	
	<#if subTable.relation = 'one2one'>
	private ${subTable.variables.class}Po ${subTable.variables.classVar} = null;
	public ${subTable.variables.class}Po get${subTable.variables.class}() {
		return ${subTable.variables.classVar};
	}
	public void set${subTable.variables.class}(${subTable.variables.class}Po ${subTable.variables.classVar}) {
		this.${subTable.variables.classVar} = ${subTable.variables.classVar};
	}
	<#else>
	private List<${subTable.variables.class}Po> ${subTable.variables.classVar}PoList = new ArrayList<${subTable.variables.class}Po>();
	public List<${subTable.variables.class}Po> get${subTable.variables.class}PoList() {
		return ${subTable.variables.classVar}PoList;
	}
	public void set${subTable.variables.class}PoList(List<${subTable.variables.class}Po> ${subTable.variables.classVar}PoList) {
		this.${subTable.variables.classVar}PoList = ${subTable.variables.classVar}PoList;
	}
	</#if>
	</#list>
	</#if>

	public static ${class}Po fromJsonString(String data){
		if(JacksonUtil.isNotJsonObject(data)){
			return null;
		}
		return JacksonUtil.getDTO(data, ${class}Po.class);
	}
	
	public static List<${class}Po> fromJsonArrayString(String listData){
		if(JacksonUtil.isNotJsonArray(listData)){
			return Collections.emptyList();
		}
		return JacksonUtil.getDTOList(listData, ${class}Po.class);
	}
}