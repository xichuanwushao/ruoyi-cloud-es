package com.ruoyi.news.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 交通出行对象 house_detail
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
public class HouseDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Long id;

    /** 详细描述 */
    @Excel(name = "详细描述")
    private String description;

    /** 户型介绍 */
    @Excel(name = "户型介绍")
    private String layoutDesc;

    /** 交通出行 */
    @Excel(name = "交通出行")
    private String traffic;

    /** 周边配套 */
    @Excel(name = "周边配套")
    private String roundService;

    /** 租赁方式 */
    @Excel(name = "租赁方式")
    private Integer rentWay;

    /** 详细地址  */
    @Excel(name = "详细地址 ")
    private String address;

    /** 附近地铁线id */
    @Excel(name = "附近地铁线id")
    private Long subwayLineId;

    /** 附近地铁线名称 */
    @Excel(name = "附近地铁线名称")
    private String subwayLineName;

    /** 地铁站id */
    @Excel(name = "地铁站id")
    private Long subwayStationId;

    /** 地铁站名 */
    @Excel(name = "地铁站名")
    private String subwayStationName;

    /** 对应house的id */
    @Excel(name = "对应house的id")
    private Long houseId;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }
    public void setLayoutDesc(String layoutDesc) 
    {
        this.layoutDesc = layoutDesc;
    }

    public String getLayoutDesc() 
    {
        return layoutDesc;
    }
    public void setTraffic(String traffic) 
    {
        this.traffic = traffic;
    }

    public String getTraffic() 
    {
        return traffic;
    }
    public void setRoundService(String roundService) 
    {
        this.roundService = roundService;
    }

    public String getRoundService() 
    {
        return roundService;
    }
    public void setRentWay(Integer rentWay) 
    {
        this.rentWay = rentWay;
    }

    public Integer getRentWay() 
    {
        return rentWay;
    }
    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }
    public void setSubwayLineId(Long subwayLineId) 
    {
        this.subwayLineId = subwayLineId;
    }

    public Long getSubwayLineId() 
    {
        return subwayLineId;
    }
    public void setSubwayLineName(String subwayLineName) 
    {
        this.subwayLineName = subwayLineName;
    }

    public String getSubwayLineName() 
    {
        return subwayLineName;
    }
    public void setSubwayStationId(Long subwayStationId) 
    {
        this.subwayStationId = subwayStationId;
    }

    public Long getSubwayStationId() 
    {
        return subwayStationId;
    }
    public void setSubwayStationName(String subwayStationName) 
    {
        this.subwayStationName = subwayStationName;
    }

    public String getSubwayStationName() 
    {
        return subwayStationName;
    }
    public void setHouseId(Long houseId) 
    {
        this.houseId = houseId;
    }

    public Long getHouseId() 
    {
        return houseId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("description", getDescription())
            .append("layoutDesc", getLayoutDesc())
            .append("traffic", getTraffic())
            .append("roundService", getRoundService())
            .append("rentWay", getRentWay())
            .append("address", getAddress())
            .append("subwayLineId", getSubwayLineId())
            .append("subwayLineName", getSubwayLineName())
            .append("subwayStationId", getSubwayStationId())
            .append("subwayStationName", getSubwayStationName())
            .append("houseId", getHouseId())
            .toString();
    }
}
