package com.ruoyi.news.service.impl;

import java.util.Arrays;
import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.news.domain.model.HouseIndexTemplate;
import com.ruoyi.news.mapper.es.HouseIndexTemplateMapper;
import org.springframework.beans.BeanUtils;
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

    @Autowired
    private HouseIndexTemplateMapper houseIndexTemplateMapper;
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
        house.setAdminId(SecurityUtils.getUserId());
        house.setCreateTime(DateUtils.getNowDate());
        int rows = houseMapper.insertHouse(house);
        insertHouseDetail(house);



        //同时将数据新增到es中
        HouseIndexTemplate houseIndexTemplate = new HouseIndexTemplate();
        BeanUtils.copyProperties(house, houseIndexTemplate);
        houseIndexTemplate.setHouseId(house.getId());
        houseIndexTemplate.setId(house.getId());

        List<HouseDetail> houseDetailList = house.getHouseDetailList();
        Long id = house.getId();
        if (StringUtils.isNotNull(houseDetailList))
        {
            if(houseDetailList.size()>0) {
                HouseDetail houseDetail = houseDetailList.get(0);//house与housedetail一对一关系
                BeanUtils.copyProperties(houseDetail, houseIndexTemplate);
            }
            int success = houseIndexTemplateMapper.insert(houseIndexTemplate);
        }
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

        //同时将数据新增到es中
        HouseIndexTemplate houseIndexTemplate = new HouseIndexTemplate();
        BeanUtils.copyProperties(house, houseIndexTemplate);
        houseIndexTemplate.setHouseId(house.getId());
        houseIndexTemplate.setId(house.getId());




        List<HouseDetail> houseDetailList = house.getHouseDetailList();
        Long id = house.getId();
        if (StringUtils.isNotNull(houseDetailList))
        {
            if(houseDetailList.size()>0) {
                HouseDetail houseDetail = houseDetailList.get(0);//house与housedetail一对一关系
                BeanUtils.copyProperties(houseDetail, houseIndexTemplate);
            }

            HouseIndexTemplate houseIndexTemplateQu = houseIndexTemplateMapper.selectById(house.getId());
            if(houseIndexTemplateQu==null){
                int success = houseIndexTemplateMapper.insert(houseIndexTemplate);
            }else {
                int success = houseIndexTemplateMapper.updateById(houseIndexTemplate);
            }
        }
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
        //同时删除es中的数据
        List<Long> idList = Arrays.asList(ids);
        int count = houseIndexTemplateMapper.deleteBatchIds(idList);

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
