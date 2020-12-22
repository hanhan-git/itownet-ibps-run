<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.dao;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao;
</#if>

import com.${scAlias}.${scPlatform}.base.framework.persistence.dao.IDao;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>

/**
 * ${model.tabComment} Dao接口
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
public interface ${class}Dao extends IDao<String, ${class}Po> {
	<#if sub?exists && sub>
	/**
	 * 根据主表id删除 ${model.tabComment} 记录
	 * @param mainId 
	 * void
	 */
	public void deleteByMainId(String mainId);
	</#if>
}
