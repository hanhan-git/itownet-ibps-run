<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.dao.impl;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.impl;
</#if>

import org.springframework.stereotype.Repository;

import com.${scAlias}.${scPlatform}.base.db.ddd.dao.MyBatisDaoImpl;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>

/**
 * ${model.tabComment} Dao接口的实现类
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
@Repository
public class ${class}DaoImpl extends MyBatisDaoImpl<String, ${class}Po> implements ${class}Dao{

    @Override
    public String getNamespace() {
        return ${class}Po.class.getName();
    }
	<#if sub?exists && sub>
	public void deleteByMainId(String mainId) {
		deleteByKey("deleteByMainId", b().a("mainId", mainId).p());		
	}
	</#if>
}
