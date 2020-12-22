<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.repository;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.repository;
</#if>

<#if sub?exists && sub>
import java.util.List;
</#if>
import com.${scAlias}.${scPlatform}.base.framework.repository.IRepository;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>

/**
 * ${model.tabComment} 仓库接口
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
public interface ${class}Repository extends IRepository<String, ${class}Po,${class}>{
	 <#if sub?exists && sub>
	 /**
	 * 根据主表ID查询 ${model.tabComment} 列表
	 * @param mainId
	 * @return 
	 * List<${class}Po>
	 */
	public List<${class}Po> findByMainId(String mainId);
	</#if>

	<#if isGenSub = 'true' && hasSub?exists && hasSub==true> 
	/**
	 * 查询全部子表的数据，并设置到主表Po中 
	 * void
	 */
	public ${class}Po loadCascade(String id);
	</#if>
}
