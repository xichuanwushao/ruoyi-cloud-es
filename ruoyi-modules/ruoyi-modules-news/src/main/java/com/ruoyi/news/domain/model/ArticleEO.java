package com.ruoyi.news.domain.model;

import cn.easyes.annotation.HighLight;

import java.util.Date;

public class ArticleEO {
    private String id;
    /**
     * 需要被高亮的字段
     */
    @HighLight(mappingField = "highlightTitle" )
    private String title;

    private Integer categoryId;

    private Integer articleType;

    private String articleCover;

    private String publishUserId;

    private Date publishTime;

    /**
     * 高亮返回值被映射的字段
     */
    private String highlightTitle;

    public String getHighlightTitle() {
        return highlightTitle;
    }

    public void setHighlightTitle(String highlightTitle) {
        this.highlightTitle = highlightTitle;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getArticleType() {
        return articleType;
    }

    public void setArticleType(Integer articleType) {
        this.articleType = articleType;
    }

    public String getArticleCover() {
        return articleCover;
    }

    public void setArticleCover(String articleCover) {
        this.articleCover = articleCover;
    }

    public String getPublishUserId() {
        return publishUserId;
    }

    public void setPublishUserId(String publishUserId) {
        this.publishUserId = publishUserId;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    @Override
    public String toString() {
        return "ArticleEO{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", categoryId=" + categoryId +
                ", articleType=" + articleType +
                ", articleCover='" + articleCover + '\'' +
                ", publishUserId='" + publishUserId + '\'' +
                ", publishTime=" + publishTime +
                '}';
    }
}