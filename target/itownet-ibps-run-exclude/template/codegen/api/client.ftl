<#if isBaseModule = 'true'>
package com.${cAlias}.${cPlatform}.${sys}.client;
<#else>
package com.${cAlias}.${cPlatform}.${sys}.${module}.client;
</#if>

import org.springframework.cloud.openfeign.FeignClient;

import com.lc.ibps.cloud.client.provider.ProviderConstants;
import com.lc.ibps.org.api.I${class}Service;

/**
 * ${comment} 接口
 *
 * <pre> 
 * 构建组：ibps-provider-${classVar}-client
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
 * </pre>
 */
@FeignClient(name = ProviderConstants.ProviderId.${providerId})
public interface I${class}ServiceClient extends I${class}Service{

}
