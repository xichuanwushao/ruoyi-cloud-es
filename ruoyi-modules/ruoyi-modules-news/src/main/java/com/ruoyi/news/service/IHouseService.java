package com.ruoyi.news.service;

import java.util.List;
import com.ruoyi.news.domain.House;

/**
 * 房屋信息Service接口
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
public interface IHouseService 
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
     * 批量删除房屋信息
     * 
     * @param ids 需要删除的房屋信息主键集合
     * @return 结果
     */
    public int deleteHouseByIds(Long[] ids);

    /**
     * 删除房屋信息信息
     * 
     * @param id 房屋信息主键
     * @return 结果
     */
    public int deleteHouseById(Long id);
}
