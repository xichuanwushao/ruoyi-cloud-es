package com.ruoyi.news.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.news.mapper.SupportAddressMapper;
import com.ruoyi.news.domain.SupportAddress;
import com.ruoyi.news.service.ISupportAddressService;

/**
 * 行政区域名称Service业务层处理
 * 
 * @author wuxiao
 * @date 2022-11-07
 */
@Service
public class SupportAddressServiceImpl implements ISupportAddressService 
{
    @Autowired
    private SupportAddressMapper supportAddressMapper;

    /**
     * 查询行政区域名称
     * 
     * @param id 行政区域名称主键
     * @return 行政区域名称
     */
    @Override
    public SupportAddress selectSupportAddressById(Long id)
    {
        return supportAddressMapper.selectSupportAddressById(id);
    }

    /**
     * 查询行政区域名称列表
     * 
     * @param supportAddress 行政区域名称
     * @return 行政区域名称
     */
    @Override
    public List<SupportAddress> selectSupportAddressList(SupportAddress supportAddress)
    {
        return supportAddressMapper.selectSupportAddressList(supportAddress);
    }

    /**
     * 新增行政区域名称
     * 
     * @param supportAddress 行政区域名称
     * @return 结果
     */
    @Override
    public int insertSupportAddress(SupportAddress supportAddress)
    {
        return supportAddressMapper.insertSupportAddress(supportAddress);
    }

    /**
     * 修改行政区域名称
     * 
     * @param supportAddress 行政区域名称
     * @return 结果
     */
    @Override
    public int updateSupportAddress(SupportAddress supportAddress)
    {
        return supportAddressMapper.updateSupportAddress(supportAddress);
    }

    /**
     * 批量删除行政区域名称
     * 
     * @param ids 需要删除的行政区域名称主键
     * @return 结果
     */
    @Override
    public int deleteSupportAddressByIds(Long[] ids)
    {
        return supportAddressMapper.deleteSupportAddressByIds(ids);
    }

    /**
     * 删除行政区域名称信息
     * 
     * @param id 行政区域名称主键
     * @return 结果
     */
    @Override
    public int deleteSupportAddressById(Long id)
    {
        return supportAddressMapper.deleteSupportAddressById(id);
    }
}
