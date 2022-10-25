package com.ruoyi.news.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

import cn.easyes.core.biz.PageInfo;
import cn.easyes.core.conditions.LambdaEsQueryWrapper;
import com.ruoyi.common.core.web.page.PageDomain;
import com.ruoyi.common.core.web.page.TableSupport;
import com.ruoyi.news.domain.model.ArticleEO;
import com.ruoyi.news.domain.model.Document;
import com.ruoyi.news.mapper.es.ArticleEOMapper;
import com.ruoyi.news.util.enums.ArticleCoverType;
import com.ruoyi.news.util.result.ResponseStatusEnum;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.news.domain.ChuArticle;
import com.ruoyi.news.service.IChuArticleService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 文章资讯Controller
 * 
 * @author  xiaowu
 * @date 2022-10-18
 */
@RestController
@RequestMapping("/article")
public class ChuArticleController extends BaseController
{
    @Autowired
    private IChuArticleService chuArticleService;


    @Autowired
    private ArticleEOMapper articleEOMapper;

    /**
     * 查询文章资讯列表
     */
    @RequiresPermissions("news:article:list")
    @GetMapping("/list")
    public TableDataInfo list(ChuArticle chuArticle)
    {
        startPage();
        List<ChuArticle> list = chuArticleService.selectChuArticleList(chuArticle);
        return getDataTable(list);
    }



    /**
     * 查询文章资讯列表
     */
    @RequiresPermissions("news:article:list")
    @GetMapping("/es/list")
    public TableDataInfo eslist(ChuArticle chuArticle)
    {
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        LambdaEsQueryWrapper<ArticleEO> wrapper = new LambdaEsQueryWrapper<>();
        if(chuArticle.getTitle()!=null){
            wrapper.match(ArticleEO::getTitle, chuArticle.getTitle());
        }
        List<ArticleEO> articleEOList = articleEOMapper.selectList(wrapper);
//        PageInfo<ArticleEO> documentPageInfo = articleEOMapper.pageQuery(wrapper,pageNum,pageSize);
//        List<ArticleEO> list = documentPageInfo.getList();
        return getDataTable(articleEOList);
    }

    /**
     * 导出文章资讯列表
     */
    @RequiresPermissions("news:article:export")
    @Log(title = "文章资讯", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChuArticle chuArticle)
    {
        List<ChuArticle> list = chuArticleService.selectChuArticleList(chuArticle);
        ExcelUtil<ChuArticle> util = new ExcelUtil<ChuArticle>(ChuArticle.class);
        util.exportExcel(response, list, "文章资讯数据");
    }

    /**
     * 获取文章资讯详细信息
     */
    @RequiresPermissions("news:article:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return AjaxResult.success(chuArticleService.selectChuArticleById(id));
    }

    /**
     * 新增文章资讯
     */
    @RequiresPermissions("news:article:add")
    @Log(title = "文章资讯", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChuArticle chuArticle)
    {
        return toAjax(chuArticleService.insertChuArticle(chuArticle));
    }

    /**
     * 修改文章资讯
     */
    @RequiresPermissions("news:article:edit")
    @Log(title = "文章资讯", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChuArticle chuArticle)
    {
        return toAjax(chuArticleService.updateChuArticle(chuArticle));
    }

    /**
     * 删除文章资讯
     */
    @RequiresPermissions("news:article:remove")
    @Log(title = "文章资讯", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(chuArticleService.deleteChuArticleByIds(ids));
    }
}
