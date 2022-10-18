package com.ruoyi.news.mapper;

import java.util.List;
import com.ruoyi.news.domain.ChuArticle;

/**
 * 文章资讯Mapper接口
 * 
 * @author  xiaowu
 * @date 2022-10-18
 */
public interface ChuArticleMapper 
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
     * 删除文章资讯
     * 
     * @param id 文章资讯主键
     * @return 结果
     */
    public int deleteChuArticleById(String id);

    /**
     * 批量删除文章资讯
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteChuArticleByIds(String[] ids);
}
