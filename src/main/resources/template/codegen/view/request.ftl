import request from '@/utils/request'
const ${class?upper_case}_URL = '/${gatewayMapping}/v3'

<#if model.variables.struType='tree'>
/**
 * 查询树信息
 * @param {*} params
 */
export function getTreeData(params) {
  return request({
    url: ${class?upper_case}_URL + '/${classVar}/findTreeData',
    params: params
  })
}
<#else>
/**
 * 查询列表数据
 * @param {*} params
 */
export function queryPageList(data) {
  return request({
    url: ${class?upper_case}_URL + '/${classVar}/query',
    method: 'post',
    data: data
  })
}
</#if>
/**
 * 删除数据
 * @param {*} params
 */
export function remove(params) {
  return request({
    url: ${class?upper_case}_URL + '/${classVar}/remove',
    method: 'post',
    params: params
  })
}
/**
 * 保存数据
 * @param {*} params
 */
export function save(params) {
  return request({
    url: ${class?upper_case}_URL + '/${classVar}/save',
    method: 'post',
    data: params
  })
}

/**
 * 获取数据
 * @param {*} params
 */
export function get(params) {
  return request({
    url: ${class?upper_case}_URL + '/${classVar}/get',
    method: 'get',
    params: params
  })
}

