package com.${cAlias}.${cPlatform}.${sys};

import javax.annotation.Resource;

import org.springframework.test.context.ContextConfiguration;

import com.${scAlias}.${scPlatform}.base.framework.test.BaseTestCase;
import com.${scAlias}.${scPlatform}.api.base.id.IdGenerator;

/**
 * 测试基类。</br>
 * 模块其下的测试类均继承该子类
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
@ContextConfiguration({"classpath:conf/${sys}-test.xml"})
public class ${baseClass}BaseTest extends BaseTestCase{
	
	@Resource
    protected IdGenerator idGenerator;
}
