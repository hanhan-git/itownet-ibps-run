<#assign foreignKey=convertUnderLine(model.foreignKey)>

<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.dao.impl;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.impl;
</#if>

<#if sub?exists && sub>
import java.util.List;
</#if>

import org.springframework.stereotype.Repository;

import com.${scAlias}.${scPlatform}.base.db.ddd.dao.MyBatisQueryDaoImpl;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>

/**
 *${model.tabComment} 查询Dao的实现类
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
public class ${class}QueryDaoImpl extends MyBatisQueryDaoImpl<String, ${class}Po> implements ${class}QueryDao{

    @Override
    public String getNamespace() {
        return ${class}Po.class.getName();
    }
    <#if sub?exists && sub>
	public List<${class}Po> findByMainId(String mainId) {
		return findByKey("findByMainId", b().a("mainId", mainId).p());
	}
	</#if>
}
