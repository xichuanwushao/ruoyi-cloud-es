package com.ruoyi.news.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 文章资讯对象 chu_article
 * 
 * @author  xiaowu
 * @date 2022-10-18
 */
public class ChuArticle extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private String id;

    /** 文章标题 */
    @Excel(name = "文章标题")
    private String title;

    /** 文章内容，长度不超过9999，需要在前后端判断 */
    @Excel(name = "文章内容，长度不超过9999，需要在前后端判断")
    private String content;

    /** 文章所属分类id */
    @Excel(name = "文章所属分类id")
    private Integer categoryId;

    /** 文章类型，1：图文（1张封面），2：纯文字 */
    @Excel(name = "文章类型，1：图文", readConverterExp = "1=张封面")
    private Integer articleType;

    /** 文章封面图，article_type=1 的时候展示 */
    @Excel(name = "文章封面图，article_type=1 的时候展示")
    private String articleCover;

    /** 是否是预约定时发布的文章，1：预约（定时）发布，0：即时发布    在预约时间到点的时候，把1改为0，则发布 */
    @Excel(name = "是否是预约定时发布的文章，1：预约", readConverterExp = "定=时")
    private Integer isAppoint;

    /** 文章状态，1：审核中（用户已提交），2：机审结束，等待人工审核，3：审核通过（已发布），4：审核未通过；5：文章撤回（已发布的情况下才能撤回和删除） */
    @Excel(name = "文章状态，1：审核中", readConverterExp = "用=户已提交")
    private Integer articleStatus;

    /** 发布者用户id */
    @Excel(name = "发布者用户id")
    private String publishUserId;

    /** 文章发布时间（也是预约发布的时间） */
    @Excel(name = "文章发布时间", readConverterExp = "也=是预约发布的时间")
    private Date publishTime;

    /** 用户累计点击阅读数（喜欢数）（点赞） - 放redis */
    @Excel(name = "用户累计点击阅读数", readConverterExp = "喜=欢数")
    private Long readCounts;

    /** 文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒 */
    @Excel(name = "文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒")
    private Long commentCounts;

    /** mongo图片id */
    @Excel(name = "mongo图片id")
    private String mongoFileId;

    /** 逻辑删除状态，非物理删除，1：删除，0：未删除 */
    @Excel(name = "逻辑删除状态，非物理删除，1：删除，0：未删除")
    private Integer isDelete;

    public void setId(String id) 
    {
        this.id = id;
    }

    public String getId() 
    {
        return id;
    }
    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }
    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }
    public void setCategoryId(Integer categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Integer getCategoryId() 
    {
        return categoryId;
    }
    public void setArticleType(Integer articleType) 
    {
        this.articleType = articleType;
    }

    public Integer getArticleType() 
    {
        return articleType;
    }
    public void setArticleCover(String articleCover) 
    {
        this.articleCover = articleCover;
    }

    public String getArticleCover() 
    {
        return articleCover;
    }
    public void setIsAppoint(Integer isAppoint) 
    {
        this.isAppoint = isAppoint;
    }

    public Integer getIsAppoint() 
    {
        return isAppoint;
    }
    public void setArticleStatus(Integer articleStatus) 
    {
        this.articleStatus = articleStatus;
    }

    public Integer getArticleStatus() 
    {
        return articleStatus;
    }
    public void setPublishUserId(String publishUserId) 
    {
        this.publishUserId = publishUserId;
    }

    public String getPublishUserId() 
    {
        return publishUserId;
    }
    public void setPublishTime(Date publishTime) 
    {
        this.publishTime = publishTime;
    }

    public Date getPublishTime() 
    {
        return publishTime;
    }
    public void setReadCounts(Long readCounts) 
    {
        this.readCounts = readCounts;
    }

    public Long getReadCounts() 
    {
        return readCounts;
    }
    public void setCommentCounts(Long commentCounts) 
    {
        this.commentCounts = commentCounts;
    }

    public Long getCommentCounts() 
    {
        return commentCounts;
    }
    public void setMongoFileId(String mongoFileId) 
    {
        this.mongoFileId = mongoFileId;
    }

    public String getMongoFileId() 
    {
        return mongoFileId;
    }
    public void setIsDelete(Integer isDelete) 
    {
        this.isDelete = isDelete;
    }

    public Integer getIsDelete() 
    {
        return isDelete;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("title", getTitle())
            .append("content", getContent())
            .append("categoryId", getCategoryId())
            .append("articleType", getArticleType())
            .append("articleCover", getArticleCover())
            .append("isAppoint", getIsAppoint())
            .append("articleStatus", getArticleStatus())
            .append("publishUserId", getPublishUserId())
            .append("publishTime", getPublishTime())
            .append("readCounts", getReadCounts())
            .append("commentCounts", getCommentCounts())
            .append("mongoFileId", getMongoFileId())
            .append("isDelete", getIsDelete())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
