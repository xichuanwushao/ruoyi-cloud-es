package com.ruoyi.news.service;

import java.util.List;
import com.ruoyi.news.domain.ChuArticle;

/**
 * 文章资讯Service接口
 * 
 * @author  xiaowu
 * @date 2022-10-18
 */
public interface IChuArticleService 
{
    /**
     * 查询文章资讯
     * 
     * @param id 文章资讯主键
     * @return 文章资讯
     */
    public ChuArticle selectChuArticleById(String id);

    /**
     * 查询文章资讯列表
     * 
     * @param chuArticle 文章资讯
     * @return 文章资讯集合
     */
    public List<ChuArticle> selectChuArticleList(ChuArticle chuArticle);

    /**
     * 新增文章资讯
     * 
     * @param chuArticle 文章资讯
     * @return 结果
     */
    public int insertChuArticle(ChuArticle chuArticle);

    /**
     * 修改文章资讯
     * 
     * @param chuArticle 文章资讯
     * @return 结果
     */
    public int updateChuArticle(ChuArticle chuArticle);

    /**
     * 批量删除文章资讯
     * 
     * @param ids 需要删除的文章资讯主键集合
     * @return 结果
     */
    public int deleteChuArticleByIds(String[] ids);

    /**
     * 删除文章资讯信息
     * 
     * @param id 文章资讯主键
     * @return 结果
     */
    public int deleteChuArticleById(String id);
}
