import request from '@/utils/request'

// 查询文章资讯列表
export function listArticle(query) {
  return request({
    url: '/news/article/list',
    method: 'get',
    params: query
  })
}

// 查询文章资讯详细
export function getArticle(id) {
  return request({
    url: '/news/article/' + id,
    method: 'get'
  })
}

// 新增文章资讯
export function addArticle(data) {
  return request({
    url: '/news/article',
    method: 'post',
    data: data
  })
}

// 修改文章资讯
export function updateArticle(data) {
  return request({
    url: '/news/article',
    method: 'put',
    data: data
  })
}

// 删除文章资讯
export function delArticle(id) {
  return request({
    url: '/news/article/' + id,
    method: 'delete'
  })
}
