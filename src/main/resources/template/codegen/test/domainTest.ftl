<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.domain;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.domain;
</#if>

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.repository.${class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.${module}.repository.${class}Repository;
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>
import com.${cAlias}.${cPlatform}.${sys}.${baseClass}BaseTest;

/**
 * ${model.tabComment} 领域对象实体单元测试类
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
public class ${class}Test extends ${baseClass}BaseTest{
	 
	@Resource
	private ${class}Repository ${classVar}Repository;
	
	@Test
	@Rollback(true)
	public void create(){				
		${class} ${classVar} = ${classVar}Repository.newInstance();
		
		${class}Po ${classVar}Po=new ${class}Po();
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
		
		${classVar}.setData(${classVar}Po);
		
		List<String> ids = new ArrayList<String>();
		
		${classVar}.create();	
		ids.add(${classVar}.getId());
						
		${class} ${classVar}2 = ${classVar}Repository.newInstance();
		${classVar}Po.setId(idGenerator.getId());
		${classVar}2.setData(${classVar}Po);
		
		${classVar}2.create();
		ids.add(${classVar}2.getId());
		
		List<${class}Po> ${classVar}PoList = ${classVar}Repository.findByIds(ids);
		Assert.assertTrue(${classVar}PoList.size()>=2);
		
		List<${class}Po>${classVar}1 = ${classVar}Repository.findAll();
		Assert.assertTrue(${classVar}1.size()>=2);

	}
}
