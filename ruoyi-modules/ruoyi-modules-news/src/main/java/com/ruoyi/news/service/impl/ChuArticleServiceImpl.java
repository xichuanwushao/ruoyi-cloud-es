package com.ruoyi.news.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.news.util.UuidUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.news.mapper.ChuArticleMapper;
import com.ruoyi.news.domain.ChuArticle;
import com.ruoyi.news.service.IChuArticleService;

/**
 * 文章资讯Service业务层处理
 * 
 * @author  xiaowu
 * @date 2022-10-18
 */
@Service
public class ChuArticleServiceImpl implements IChuArticleService 
{
    @Autowired
    private ChuArticleMapper chuArticleMapper;

    /**
     * 查询文章资讯
     * 
     * @param id 文章资讯主键
     * @return 文章资讯
     */
    @Override
    public ChuArticle selectChuArticleById(String id)
    {
        return chuArticleMapper.selectChuArticleById(id);
    }

    /**
     * 查询文章资讯列表
     * 
     * @param chuArticle 文章资讯
     * @return 文章资讯
     */
    @Override
    public List<ChuArticle> selectChuArticleList(ChuArticle chuArticle)
    {
        return chuArticleMapper.selectChuArticleList(chuArticle);
    }

    /**
     * 新增文章资讯
     * 
     * @param chuArticle 文章资讯
     * @return 结果
     */
    @Override
    public int insertChuArticle(ChuArticle chuArticle)
    {
        chuArticle.setId(UuidUtil.getShortUuid());
        chuArticle.setCreateTime(DateUtils.getNowDate());
        return chuArticleMapper.insertChuArticle(chuArticle);
    }

    /**
     * 修改文章资讯
     * 
     * @param chuArticle 文章资讯
     * @return 结果
     */
    @Override
    public int updateChuArticle(ChuArticle chuArticle)
    {
        chuArticle.setUpdateTime(DateUtils.getNowDate());
        return chuArticleMapper.updateChuArticle(chuArticle);
    }

    /**
     * 批量删除文章资讯
     * 
     * @param ids 需要删除的文章资讯主键
     * @return 结果
     */
    @Override
    public int deleteChuArticleByIds(String[] ids)
    {
        return chuArticleMapper.deleteChuArticleByIds(ids);
    }

    /**
     * 删除文章资讯信息
     * 
     * @param id 文章资讯主键
     * @return 结果
     */
    @Override
    public int deleteChuArticleById(String id)
    {
        return chuArticleMapper.deleteChuArticleById(id);
    }
}
