package com.ruoyi.news.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 房屋信息对象 house
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
public class House extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** house唯一标识 */
    private Long id;

    /** 标题 */
    @Excel(name = "标题")
    private String title;

    /** 价格 */
    @Excel(name = "价格")
    private Long price;

    /** 面积 */
    @Excel(name = "面积")
    private Long area;

    /** 卧室数量 */
    @Excel(name = "卧室数量")
    private Long room;

    /** 楼层 */
    @Excel(name = "楼层")
    private Long floor;

    /** 总楼层 */
    @Excel(name = "总楼层")
    private Long totalFloor;

    /** 被看次数 */
    @Excel(name = "被看次数")
    private Long watchTimes;

    /** 建立年限 */
    @Excel(name = "建立年限")
    private Integer buildYear;

    /** 房屋状态 0-未审核 1-审核通过 2-已出租 3-逻辑删除 */
    @Excel(name = "房屋状态 0-未审核 1-审核通过 2-已出租 3-逻辑删除")
    private Integer status;

    /** 最近数据更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "最近数据更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastUpdateTime;

    /** 城市标记缩写 如 北京bj */
    @Excel(name = "城市标记缩写 如 北京bj")
    private String cityEnName;

    /** 地区英文简写 如昌平区 cpq */
    @Excel(name = "地区英文简写 如昌平区 cpq")
    private String regionEnName;

    /** 封面 */
    @Excel(name = "封面")
    private String cover;

    /** 房屋朝向 */
    @Excel(name = "房屋朝向")
    private Long direction;

    /** 距地铁距离 默认-1 附近无地铁 */
    @Excel(name = "距地铁距离 默认-1 附近无地铁")
    private Long distanceToSubway;

    /** 客厅数量 */
    @Excel(name = "客厅数量")
    private Long parlour;

    /** 所在小区 */
    @Excel(name = "所在小区")
    private String district;

    /** 所属管理员id */
    @Excel(name = "所属管理员id")
    private Long adminId;

    /** 浴室数量 */
    @Excel(name = "浴室数量")
    private Long bathroom;

    /** 街道 */
    @Excel(name = "街道")
    private String street;

    /** 房间图片 */
    @Excel(name = "房间图片")
    private String housePicture;

    /** 房间标签 */
    @Excel(name = "房间标签")
    private String houseTag;

    /** 交通出行信息 */
    private List<HouseDetail> houseDetailList;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
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
    public void setPrice(Long price) 
    {
        this.price = price;
    }

    public Long getPrice() 
    {
        return price;
    }
    public void setArea(Long area) 
    {
        this.area = area;
    }

    public Long getArea() 
    {
        return area;
    }
    public void setRoom(Long room) 
    {
        this.room = room;
    }

    public Long getRoom() 
    {
        return room;
    }
    public void setFloor(Long floor) 
    {
        this.floor = floor;
    }

    public Long getFloor() 
    {
        return floor;
    }
    public void setTotalFloor(Long totalFloor) 
    {
        this.totalFloor = totalFloor;
    }

    public Long getTotalFloor() 
    {
        return totalFloor;
    }
    public void setWatchTimes(Long watchTimes) 
    {
        this.watchTimes = watchTimes;
    }

    public Long getWatchTimes() 
    {
        return watchTimes;
    }
    public void setBuildYear(Integer buildYear) 
    {
        this.buildYear = buildYear;
    }

    public Integer getBuildYear() 
    {
        return buildYear;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }
    public void setLastUpdateTime(Date lastUpdateTime) 
    {
        this.lastUpdateTime = lastUpdateTime;
    }

    public Date getLastUpdateTime() 
    {
        return lastUpdateTime;
    }
    public void setCityEnName(String cityEnName) 
    {
        this.cityEnName = cityEnName;
    }

    public String getCityEnName() 
    {
        return cityEnName;
    }
    public void setRegionEnName(String regionEnName) 
    {
        this.regionEnName = regionEnName;
    }

    public String getRegionEnName() 
    {
        return regionEnName;
    }
    public void setCover(String cover) 
    {
        this.cover = cover;
    }

    public String getCover() 
    {
        return cover;
    }
    public void setDirection(Long direction) 
    {
        this.direction = direction;
    }

    public Long getDirection() 
    {
        return direction;
    }
    public void setDistanceToSubway(Long distanceToSubway) 
    {
        this.distanceToSubway = distanceToSubway;
    }

    public Long getDistanceToSubway() 
    {
        return distanceToSubway;
    }
    public void setParlour(Long parlour) 
    {
        this.parlour = parlour;
    }

    public Long getParlour() 
    {
        return parlour;
    }
    public void setDistrict(String district) 
    {
        this.district = district;
    }

    public String getDistrict() 
    {
        return district;
    }
    public void setAdminId(Long adminId) 
    {
        this.adminId = adminId;
    }

    public Long getAdminId() 
    {
        return adminId;
    }
    public void setBathroom(Long bathroom) 
    {
        this.bathroom = bathroom;
    }

    public Long getBathroom() 
    {
        return bathroom;
    }
    public void setStreet(String street) 
    {
        this.street = street;
    }

    public String getStreet() 
    {
        return street;
    }
    public void setHousePicture(String housePicture) 
    {
        this.housePicture = housePicture;
    }

    public String getHousePicture() 
    {
        return housePicture;
    }
    public void setHouseTag(String houseTag) 
    {
        this.houseTag = houseTag;
    }

    public String getHouseTag() 
    {
        return houseTag;
    }

    public List<HouseDetail> getHouseDetailList()
    {
        return houseDetailList;
    }

    public void setHouseDetailList(List<HouseDetail> houseDetailList)
    {
        this.houseDetailList = houseDetailList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("title", getTitle())
            .append("price", getPrice())
            .append("area", getArea())
            .append("room", getRoom())
            .append("floor", getFloor())
            .append("totalFloor", getTotalFloor())
            .append("watchTimes", getWatchTimes())
            .append("buildYear", getBuildYear())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("lastUpdateTime", getLastUpdateTime())
            .append("cityEnName", getCityEnName())
            .append("regionEnName", getRegionEnName())
            .append("cover", getCover())
            .append("direction", getDirection())
            .append("distanceToSubway", getDistanceToSubway())
            .append("parlour", getParlour())
            .append("district", getDistrict())
            .append("adminId", getAdminId())
            .append("bathroom", getBathroom())
            .append("street", getStreet())
            .append("housePicture", getHousePicture())
            .append("houseTag", getHouseTag())
            .append("houseDetailList", getHouseDetailList())
            .toString();
    }
}
