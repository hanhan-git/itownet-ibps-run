<#assign pkVar=pkModel.colName >
package com.${cAlias}.${cPlatform}.${sys}.${module}.provider;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.lc.ibps.api.base.constants.StateEnum;
import com.lc.ibps.api.base.query.QueryFilter;
import com.lc.ibps.base.core.util.BeanUtils;
import com.lc.ibps.cloud.entity.APIPageList;
import com.lc.ibps.cloud.entity.APIRequest;
import com.lc.ibps.cloud.entity.APIResult;
import com.lc.ibps.cloud.provider.GenericProvider;
<#if isBaseModule = 'true'>
import com.${cAlias}.${cPlatform}.${sys}.api.I${class}Service;
import com.${cAlias}.${cPlatform}.${sys}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.persistence.entity.${class}Po;
import com.${cAlias}.${cPlatform}.${sys}.repository.${class}Repository;
<#else>
import com.${cAlias}.${cPlatform}.${sys}.${module}.api.I${class}Service;
import com.${cAlias}.${cPlatform}.${sys}.${module}.domain.${class};
import com.${cAlias}.${cPlatform}.${sys}.${module}.persistence.entity.${class}Po;
import com.${cAlias}.${cPlatform}.${sys}.${module}.repository.${class}Repository;
</#if>

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.Extension;
import io.swagger.annotations.ExtensionProperty;

/**
 * ${comment} 服务类
 * <pre>
 * 构建组：ibps-provider-${classVar}
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
@Api(tags = "${comment}管理", value = "${comment}数据")
@Service
public class ${class}Provider extends GenericProvider implements I${class}Service{

	@Resource
	private ${class}Repository ${classVar}Repository;

	<#if model.variables.struType='tree'>
	/**
	 * 获取结构数据
	 * @param request
	 * @return
	 */
	@ApiOperation(value = "${comment}树数据", notes = "${comment}树数据")
	@Override
	public APIResult<List<${class}Po>> findTreeData(
			@ApiParam(name = "request", value = "传入查询请求json字符串", required = true) 
			@RequestBody(required = true) APIRequest request) {
		APIResult<List<${class}Po>> result = new APIResult<>();
		try {
			List<${class}Po> ${classVar}List = ${classVar}Repository.findAll();
			if(BeanUtils.isEmpty(${classVar}List)){
				${classVar}List=new ArrayList<${class}Po>();
			}
			/*构建${comment}根节点*/
			${class}Po ${classVar}=new ${class}Po();
			${classVar}.set${convertUnderLine(model.variables.idKey)?cap_first}("0");
			${classVar}.set${convertUnderLine(model.variables.key)?cap_first}("${comment}");
			${classVar}List.add(${classVar});
			
			result.setData(${classVar}List);
		} catch (Exception e) {
			setExceptionResult(result, StateEnum.ERROR.getCode(), StateEnum.ERROR.getText(), e);
		}
		return result;
	}
	<#else>
	@ApiOperation(value = "${comment}列表(分页条件查询)数据", notes = "${comment}列表(分页条件查询)数据")
	@Override
	public APIResult<APIPageList<${class}Po>> query(
			@ApiParam(name = "request", value = "传入查询请求json字符串", required = true) 
			@RequestBody(required = true) APIRequest request) {
		APIResult<APIPageList<${class}Po>> result = new APIResult<>();
		try {
			QueryFilter queryFilter = getQueryFilter(request);
			List<${class}Po> data = ${classVar}Repository.query(queryFilter);
			APIPageList<${class}Po> apiPageData = getAPIPageList(data);
			result.setData(apiPageData);
		} catch (Exception e) {
			// TODO ERROR => other error message
			setExceptionResult(result, StateEnum.ERROR.getCode(), StateEnum.ERROR.getText(), e);
		}
		return result;
	}
	</#if>

	@ApiOperation(value = "根据${pkVar}查询${comment}", notes = "根据${pkVar}查询${comment}")
	@Override
	public APIResult<${class}Po> get(
			@ApiParam(name = "${pkVar}", value = "查询id", required = true) 
			@RequestParam(name = "${pkVar}", required = true) String ${pkVar}) {
		APIResult<${class}Po> result = new APIResult<>();
		try {
			${class}Po ${classVar}Po = ${classVar}Repository.get(${pkVar});
			result.setData(${classVar}Po);
		} catch (Exception e) {
			setExceptionResult(result, StateEnum.ERROR.getCode(), StateEnum.ERROR.getText(), e);
		}
		return result;
	}
	
	@ApiOperation(value = "保存", notes = "保存${comment}信息", 
			extensions = {
					@Extension(properties = {
							@ExtensionProperty(name = "submitCtrl", value = StringPool.Y)
					})
			})
	@Override
	public APIResult<Void> save(
			@ApiParam(name = "${classVar}Po", value = "${comment}对象", required = true)  
			@RequestBody(required = true) ${class}Po ${classVar}Po) {
		APIResult<Void> result = new APIResult<Void>();
		try {
			logger.info(" com.${cAlias}.${cPlatform}.${sys}.provider.${class}Provider.save()--->${classVar}Po: {}", ${classVar}Po.toString());
			${class} ${classVar} = ${classVar}Repository.newInstance(${classVar}Po);
			${classVar}.save();
			result.setMessage("保存${comment}成功");
		} catch (Exception e) {
			setExceptionResult(result, StateEnum.ERROR.getCode(), StateEnum.ERROR.getText(), e);
		}
		return result;
	}

	@ApiOperation(value = "删除", notes = "删除${comment}", 
			extensions = {
					@Extension(properties = {
							@ExtensionProperty(name = "submitCtrl", value = StringPool.Y)
					})
			})
	@Override
	public APIResult<Void> remove(
			@ApiParam(name = "ids", value = "${comment}ID数组", required = true)  
			@RequestParam(name = "ids", required = true) String[] ids) {
		APIResult<Void> result = new APIResult<Void>();
		try {
			${class} domain = ${classVar}Repository.newInstance();
			domain.deleteByIds(ids);
			result.setMessage("删除${comment}成功");
		} catch (Exception e) {
			setExceptionResult(result, StateEnum.ERROR.getCode(), StateEnum.ERROR.getText(), e);
		}
		return result;
	}
	
}
