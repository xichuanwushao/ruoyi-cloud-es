package com.ruoyi.news.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.core.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.news.domain.HouseDetail;
import com.ruoyi.news.mapper.HouseMapper;
import com.ruoyi.news.domain.House;
import com.ruoyi.news.service.IHouseService;

/**
 * 房屋信息Service业务层处理
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
@Service
public class HouseServiceImpl implements IHouseService 
{
    @Autowired
    private HouseMapper houseMapper;

    /**
     * 查询房屋信息
     * 
     * @param id 房屋信息主键
     * @return 房屋信息
     */
    @Override
    public House selectHouseById(Long id)
    {
        return houseMapper.selectHouseById(id);
    }

    /**
     * 查询房屋信息列表
     * 
     * @param house 房屋信息
     * @return 房屋信息
     */
    @Override
    public List<House> selectHouseList(House house)
    {
        return houseMapper.selectHouseList(house);
    }

    /**
     * 新增房屋信息
     * 
     * @param house 房屋信息
     * @return 结果
     */
    @Transactional
    @Override
    public int insertHouse(House house)
    {
        house.setCreateTime(DateUtils.getNowDate());
        int rows = houseMapper.insertHouse(house);
        insertHouseDetail(house);
        return rows;
    }

    /**
     * 修改房屋信息
     * 
     * @param house 房屋信息
     * @return 结果
     */
    @Transactional
    @Override
    public int updateHouse(House house)
    {
        houseMapper.deleteHouseDetailByHouseId(house.getId());
        insertHouseDetail(house);
        return houseMapper.updateHouse(house);
    }

    /**
     * 批量删除房屋信息
     * 
     * @param ids 需要删除的房屋信息主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteHouseByIds(Long[] ids)
    {
        houseMapper.deleteHouseDetailByHouseIds(ids);
        return houseMapper.deleteHouseByIds(ids);
    }

    /**
     * 删除房屋信息信息
     * 
     * @param id 房屋信息主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteHouseById(Long id)
    {
        houseMapper.deleteHouseDetailByHouseId(id);
        return houseMapper.deleteHouseById(id);
    }

    /**
     * 新增交通出行信息
     * 
     * @param house 房屋信息对象
     */
    public void insertHouseDetail(House house)
    {
        List<HouseDetail> houseDetailList = house.getHouseDetailList();
        Long id = house.getId();
        if (StringUtils.isNotNull(houseDetailList))
        {
            List<HouseDetail> list = new ArrayList<HouseDetail>();
            for (HouseDetail houseDetail : houseDetailList)
            {
                houseDetail.setHouseId(id);
                list.add(houseDetail);
            }
            if (list.size() > 0)
            {
                houseMapper.batchHouseDetail(list);
            }
        }
    }
}
