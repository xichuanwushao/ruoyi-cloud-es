package com.ruoyi.news.mapper;

import java.util.List;
import com.ruoyi.news.domain.House;
import com.ruoyi.news.domain.HouseDetail;

/**
 * 房屋信息Mapper接口
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
public interface HouseMapper 
{
    /**
     * 查询房屋信息
     * 
     * @param id 房屋信息主键
     * @return 房屋信息
     */
    public House selectHouseById(Long id);

    /**
     * 查询房屋信息列表
     * 
     * @param house 房屋信息
     * @return 房屋信息集合
     */
    public List<House> selectHouseList(House house);

    /**
     * 新增房屋信息
     * 
     * @param house 房屋信息
     * @return 结果
     */
    public int insertHouse(House house);

    /**
     * 修改房屋信息
     * 
     * @param house 房屋信息
     * @return 结果
     */
    public int updateHouse(House house);

    /**
     * 删除房屋信息
     * 
     * @param id 房屋信息主键
     * @return 结果
     */
    public int deleteHouseById(Long id);

    /**
     * 批量删除房屋信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHouseByIds(Long[] ids);

    /**
     * 批量删除交通出行
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHouseDetailByHouseIds(Long[] ids);
    
    /**
     * 批量新增交通出行
     * 
     * @param houseDetailList 交通出行列表
     * @return 结果
     */
    public int batchHouseDetail(List<HouseDetail> houseDetailList);
    

    /**
     * 通过房屋信息主键删除交通出行信息
     * 
     * @param id 房屋信息ID
     * @return 结果
     */
    public int deleteHouseDetailByHouseId(Long id);
}
