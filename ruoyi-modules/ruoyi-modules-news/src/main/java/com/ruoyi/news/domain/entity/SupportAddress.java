package com.ruoyi.news.domain.entity;



public class SupportAddress {
    private Long id;

    // 上一级行政单位
    private String belongTo;

    private String enName;

    private String cnName;

    private String level;

    private double baiduMapLongitude;

    private double baiduMapLatitude;

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

        public static Level of(String value) {
            for (Level level : Level.values()) {
                if (level.getValue().equals(value)) {
                    return level;
                }
            }

            throw new IllegalArgumentException();
        }
    }


    public Long getId() {
        return id;
    }


    public void setId(Long id) {
        this.id = id;
    }


    public String getBelongTo() {
        return belongTo;
    }


    public void setBelongTo(String belongTo) {
        this.belongTo = belongTo;
    }


    public String getEnName() {
        return enName;
    }


    public void setEnName(String enName) {
        this.enName = enName;
    }


    public String getCnName() {
        return cnName;
    }


    public void setCnName(String cnName) {
        this.cnName = cnName;
    }


    public String getLevel() {
        return level;
    }


    public void setLevel(String level) {
        this.level = level;
    }


    public double getBaiduMapLongitude() {
        return baiduMapLongitude;
    }


    public void setBaiduMapLongitude(double baiduMapLongitude) {
        this.baiduMapLongitude = baiduMapLongitude;
    }


    public double getBaiduMapLatitude() {
        return baiduMapLatitude;
    }


    public void setBaiduMapLatitude(double baiduMapLatitude) {
        this.baiduMapLatitude = baiduMapLatitude;
    }


}
