<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.domain;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.domain;
</#if>

<#if sub?exists && sub>
import java.util.List;
</#if>

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

import com.${scAlias}.${scPlatform}.base.core.util.BeanUtils;
<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
import com.${scAlias}.${scPlatform}.base.core.util.string.StringUtil;
</#if>
import com.${scAlias}.${scPlatform}.base.core.util.AppUtil;
import com.${scAlias}.${scPlatform}.base.framework.domain.AbstractDomain;
import com.${scAlias}.${scPlatform}.base.framework.persistence.dao.IDao;
import com.${scAlias}.${scPlatform}.base.framework.persistence.dao.IQueryDao;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.repository.${class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
<#list model.subTableList as subTable>
import com.${cAlias}.${cPlatform}.${sys}.repository.${subTable.variables.class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${subTable.variables.class}Po;
</#list>
</#if>
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.repository.${class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
<#list model.subTableList as subTable>
import com.${cAlias}.${cPlatform}.${sys}.${module}.repository.${subTable.variables.class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${subTable.variables.class}Po;
</#list>
</#if>
</#if>

/**
 * ${model.tabComment} 领域对象实体
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
@Service
@Transactional
@Scope("prototype")
public class ${class} extends AbstractDomain<String, ${class}Po>{
	
	@Resource
	private ${class}Dao ${classVar}Dao;
	@Resource
	private ${class}QueryDao ${classVar}QueryDao;
	@Resource
	private ${class}Repository ${classVar}Repository;

	<#if isGenSub = 'true' && hasSub?exists && hasSub==true>
	<#list model.subTableList as subTable>
	@Resource
	private ${subTable.variables.class}Repository ${subTable.variables.classVar}Repository;
	</#list>
	</#if>

	protected void init(){
		//
	}
	
	@Override
	protected IQueryDao<String, ${class}Po> getInternalQueryDao() {
		return ${classVar}QueryDao;
	}
	
	@Override
	protected IDao<String, ${class}Po> getInternalDao() {
		return ${classVar}Dao;
	}
	
	@Override
	public String getInternalCacheName() {
		return "${classVar}";
	}
	
	<#if isGenSub = 'true' && hasSub?exists && hasSub==true> 
	/**
	 * 主从表一并保存 
	 * void
	 * @exception 
	 * @since  1.0.0
	 */
	public void saveCascade(){
		save();
		if(getData().isDelBeforeSave()){
			<#list model.subTableList as subTable>
			${subTable.variables.class} ${subTable.variables.classVar} = ${subTable.variables.classVar}Repository.newInstance();
			<#assign fromKey=getFromKeyName(subTable,model)>
			<#if fromKey?exists && fromKey != null && fromKey != ''>
			${subTable.variables.classVar}.deleteByMainId(getData().get${fromKey?cap_first}());
			<#else>
			${subTable.variables.classVar}.deleteByMainId(getId());
			</#if>
			</#list>
		}
		
		<#list model.subTableList as subTable>
		${subTable.variables.class} ${subTable.variables.classVar} = ${subTable.variables.classVar}Repository.newInstance();
		<#if subTable.relation = 'one2one'>
		${subTable.variables.class}Po ${subTable.variables.classVar}Po = getData().get${subTable.variables.class}();
		if(BeanUtils.isNotEmpty(${subTable.variables.classVar}Po)){
			//设置外键
			<#assign foreignKey=getFkName(subTable)>
			<#assign fromKey=getFromKeyName(subTable,model)>
			<#if fromKey?exists && fromKey != null && fromKey != ''>
			${subTable.variables.classVar}Po.set${foreignKey?cap_first}(getData().get${fromKey?cap_first}());
			<#else>
			${subTable.variables.classVar}Po.set${foreignKey?cap_first}(getId());
			</#if>
			${subTable.variables.classVar}.save(${subTable.variables.classVar}Po);
		}
		<#else>
		if(BeanUtils.isNotEmpty(getData().get${subTable.variables.class}PoList())){
			for(${subTable.variables.class}Po ${subTable.variables.classVar}Po:getData().get${subTable.variables.class}PoList()){
				//设置外键
				<#assign foreignKey=getFkName(subTable)>
				<#assign fromKey=getFromKeyName(subTable,model)>
				<#if fromKey?exists && fromKey != null && fromKey != ''>
				${subTable.variables.classVar}Po.set${foreignKey?cap_first}(getData().get${fromKey?cap_first}());
				<#else>
				${subTable.variables.classVar}Po.set${foreignKey?cap_first}(getId());
				</#if>
				${subTable.variables.classVar}.save(${subTable.variables.classVar}Po);
			}
		}
		</#if>
		</#list>
	}	
	
	/**
	 * 主从表一并删除 
	 * void
	 * @exception 
	 * @since  1.0.0
	 */
	public void deleteByIdsCascade(String[] ids){
		for(String id : ids){
			${class}Po po = ${classVar}Repository.get(id);
			<#list model.subTableList as subTable>
			<#assign fromKey=getFromKeyName(subTable,model)>
			${subTable.variables.class} ${subTable.variables.classVar} = ${subTable.variables.classVar}Repository.newInstance();
			<#if fromKey?exists && fromKey != null && fromKey != ''>
			if(BeanUtils.isNotEmpty(po) && BeanUtils.isNotEmpty(po.get${fromKey?cap_first}())){
				${subTable.variables.classVar}.deleteByMainId(po.get${fromKey?cap_first}());
			}	
			<#else>
			${subTable.variables.classVar}.deleteByMainId(id);
			</#if>
			</#list>
		}
		deleteByIds(ids);
	}
	</#if>
	
	<#if sub?exists && sub>
	public void deleteByMainId(String mainId) {
		List<${class}Po> list = ${classVar}Repository.findByMainId(mainId);
		for (${class}Po po : list) {
			delete(po.getId());
		}
	}
	</#if>
	
}
