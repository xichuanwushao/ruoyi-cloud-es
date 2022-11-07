package com.ruoyi.news.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 行政区域名称对象 support_address
 * 
 * @author wuxiao
 * @date 2022-11-07
 */
public class SupportAddress extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 上一级行政单位名 */
    @Excel(name = "上一级行政单位名")
    private String belongTo;

    /** 行政单位英文名缩写 */
    @Excel(name = "行政单位英文名缩写")
    private String enName;

    /** 行政单位中文名 */
    @Excel(name = "行政单位中文名")
    private String cnName;

    /** 行政级别 市-city 地区-region */
    @Excel(name = "行政级别 市-city 地区-region")
    private String level;

    /** 百度地图经度 */
    @Excel(name = "百度地图经度")
    private Double baiduMapLng;

    /** 百度地图纬度 */
    @Excel(name = "百度地图纬度")
    private Double baiduMapLat;

    /**
     * 行政级别定义
     */
    public enum Level {
        CITY("city"),
        REGION("region");

        private String value;

        Level(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }

        public static com.ruoyi.news.domain.entity.SupportAddress.Level of(String value) {
            for (com.ruoyi.news.domain.entity.SupportAddress.Level level : com.ruoyi.news.domain.entity.SupportAddress.Level.values()) {
                if (level.getValue().equals(value)) {
                    return level;
                }
            }

            throw new IllegalArgumentException();
        }
    }

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setBelongTo(String belongTo) 
    {
        this.belongTo = belongTo;
    }

    public String getBelongTo() 
    {
        return belongTo;
    }
    public void setEnName(String enName) 
    {
        this.enName = enName;
    }

    public String getEnName() 
    {
        return enName;
    }
    public void setCnName(String cnName) 
    {
        this.cnName = cnName;
    }

    public String getCnName() 
    {
        return cnName;
    }
    public void setLevel(String level) 
    {
        this.level = level;
    }

    public String getLevel() 
    {
        return level;
    }
    public void setBaiduMapLng(Double baiduMapLng) 
    {
        this.baiduMapLng = baiduMapLng;
    }

    public Double getBaiduMapLng() 
    {
        return baiduMapLng;
    }
    public void setBaiduMapLat(Double baiduMapLat) 
    {
        this.baiduMapLat = baiduMapLat;
    }

    public Double getBaiduMapLat() 
    {
        return baiduMapLat;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("belongTo", getBelongTo())
            .append("enName", getEnName())
            .append("cnName", getCnName())
            .append("level", getLevel())
            .append("baiduMapLng", getBaiduMapLng())
            .append("baiduMapLat", getBaiduMapLat())
            .toString();
    }
}
