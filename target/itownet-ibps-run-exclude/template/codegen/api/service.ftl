<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.api;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.api;
</#if>

import java.util.List;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lc.ibps.cloud.entity.APIPageList;
import com.lc.ibps.cloud.entity.APIRequest;
import com.lc.ibps.cloud.entity.APIResult;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
</#if>



/**
 * ${comment} 接口
 *
 *<pre> 
 * 构建组：ibps-provider-${classVar}-api
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
@Validated
@RequestMapping(value = "/${classVar}")
@RestController
public interface I${class}Service {

	<#if model.variables.struType='tree'>
	/**
	 * 
	 * 【${comment}】树数据
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/findTreeData", method = RequestMethod.POST)
	public APIResult<List<${class}Po>> findTreeData(
			@RequestBody(required = true) APIRequest request);
	<#else>
	/**
	 * 
	 * 【${comment}】列表(分页条件查询)数据
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/query", method = RequestMethod.POST)
	public APIResult<APIPageList<${class}Po>> query(
			@RequestBody(required = true) APIRequest request);
	</#if>
	
	/**
	 * 
	 * 根据id查询【${comment}】
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/get", method = { RequestMethod.GET })
	public APIResult<${class}Po> get(
//			@NotBlank(message = "{com.${cAlias}.${cPlatform}.${sys}.provider.${class}Provider.id}") 
			@RequestParam(name = "id", required = true) String id);
	
	/**
	 * 
	 * 批量删除【${comment}】记录
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/remove", method = { RequestMethod.POST })
	public APIResult<Void> remove(
//			@NotEmpty(message = "{com.${cAlias}.${cPlatform}.${sys}.provider.${class}Provider.ids}")
			@RequestParam(name = "ids", required = true) String[] ids);
	
	/**
	 * 
	 * 保存【${comment}】记录
	 *
	 * @param ${classVar}Po
	 * @return
	 */
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public APIResult<Void> save(
//			@NotEmpty(message = "{com.${cAlias}.${cPlatform}.${sys}.provider.${class}Provider.ids}")
			@RequestParam(name = "${classVar}Po", required = true) ${class}Po ${classVar}Po);
}
