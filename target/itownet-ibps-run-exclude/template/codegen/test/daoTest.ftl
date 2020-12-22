<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.persistence.dao;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao;
</#if>

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${po};
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}Dao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.dao.${class}QueryDao;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${po};
</#if>
import com.${cAlias}.${cPlatform}.${sys}.${baseClass}BaseTest;

/**
 * ${model.tabComment} dao单元测试类
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
public class ${class}DaoTest extends ${baseClass}BaseTest{

	@Resource
	private ${class}Dao ${classVar}Dao;
	
	@Resource
	private ${class}QueryDao ${classVar}QueryDao;
		
	@Test
	@Rollback(true)
	public void testCrud(){
		${po} ${poVar}=new ${po}();
		<#list model.columnList as col>
			<#assign columnName=convertUnderLine(col.columnName)>
		<#if col.isPK>
		${poVar}.setId(idGenerator.getId());
		<#else>
		<#if col.isNotNull>
		<#if col.colType="java.util.Date">
		${poVar}.set${col.colName?cap_first}(new Date());
		<#elseif col.colType="Float">
		Integer randId=new Double(100000*Math.random()).intValue();
		${poVar}.set${col.colName?cap_first}(Float.parseFloat(randId+""));
		<#elseif col.colType="Short">
		${poVar}.set${col.colName?cap_first}(new Short("1"));
		<#elseif col.colType="Integer">
		Integer randId=new Double(100000*Math.random()).intValue();
		${poVar}.set${col.colName?cap_first}(randId);
		<#elseif col.colType="Long">
		Integer randId=new Double(100000*Math.random()).intValue();
		${poVar}.set${col.colName?cap_first}(Long.parseLong(randId+""));
		<#elseif col.colType="String">
		Integer randId=new Double(100000*Math.random()).intValue();
		${poVar}.set${col.colName?cap_first}("${poVar}" + randId);
		</#if>
		</#if>
		</#if>
		</#list>
		
		//创建一实体
		${classVar}Dao.create(${poVar});
        Assert.assertNotNull(${poVar}.getId());
        logger.debug("${poVar}1:"+ ${poVar}.getId());
		//获取一实体
		${po} ${poVar}2=${classVar}QueryDao.get(${poVar}.getId());
		Assert.assertNotNull(${poVar}2);
		logger.debug("${poVar}2:" + ${poVar}2.toString());
		<#list model.columnList as col>
			<#assign columnName=convertUnderLine(col.columnName)>
			<#if !col.isPK>
		<#if col.isNotNull>
		<#if col.colType="java.util.Date">
		${poVar}2.set${col.colName?cap_first}(new Date());
		<#elseif col.colType="Float">
		Integer randId2=new Double(100000*Math.random()).intValue();
		${poVar}2.set${col.colName?cap_first}(Float.parseFloat(randId2+""));
		<#elseif col.colType="Short">
		${poVar}2.set${col.colName?cap_first}(new Short("1"));
		<#elseif col.colType="Integer">
		Integer randId2=new Double(100000*Math.random()).intValue();
		${poVar}2.set${col.colName?cap_first}(randId2);
		<#elseif col.colType="Long">
		Integer randId2=new Double(100000*Math.random()).intValue();
		${poVar}2.set${col.colName?cap_first}(Long.parseLong(randId2+""));
		<#elseif col.colType="String">
		Integer randId2=new Double(100000*Math.random()).intValue();
		${poVar}2.set${col.colName?cap_first}("${poVar}" + randId2);
		</#if>
		</#if>
			</#if>
		</#list>
		//更新一实体
		${classVar}Dao.update(${poVar}2);
		
		${po} ${poVar}3=${classVar}QueryDao.get(${poVar}.getId());
		Assert.assertNotNull(${poVar}3);
		logger.debug("${poVar}3:"+${poVar}3.toString());
		//删除一实体
		//${classVar}Dao.remove(${poVar}.getId());
	}
	
}
