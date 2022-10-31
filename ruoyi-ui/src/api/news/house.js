import request from '@/utils/request'

// 查询房屋信息列表
export function listHouse(query) {
  return request({
    url: '/news/house/list',
    method: 'get',
    params: query
  })
}

// 查询房屋信息详细
export function getHouse(id) {
  return request({
    url: '/news/house/' + id,
    method: 'get'
  })
}

// 新增房屋信息
export function addHouse(data) {
  return request({
    url: '/news/house',
    method: 'post',
    data: data
  })
}

// 修改房屋信息
export function updateHouse(data) {
  return request({
    url: '/news/house',
    method: 'put',
    data: data
  })
}

// 删除房屋信息
export function delHouse(id) {
  return request({
    url: '/news/house/' + id,
    method: 'delete'
  })
}
