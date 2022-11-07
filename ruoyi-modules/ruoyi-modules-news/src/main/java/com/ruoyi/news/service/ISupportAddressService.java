package com.ruoyi.news.service;

import java.util.List;
import com.ruoyi.news.domain.SupportAddress;

/**
 * 行政区域名称Service接口
 * 
 * @author wuxiao
 * @date 2022-11-07
 */
public interface ISupportAddressService 
{
    /**
     * 查询行政区域名称
     * 
     * @param id 行政区域名称主键
     * @return 行政区域名称
     */
    public SupportAddress selectSupportAddressById(Long id);

    /**
     * 查询行政区域名称列表
     * 
     * @param supportAddress 行政区域名称
     * @return 行政区域名称集合
     */
    public List<SupportAddress> selectSupportAddressList(SupportAddress supportAddress);

    /**
     * 新增行政区域名称
     * 
     * @param supportAddress 行政区域名称
     * @return 结果
     */
    public int insertSupportAddress(SupportAddress supportAddress);

    /**
     * 修改行政区域名称
     * 
     * @param supportAddress 行政区域名称
     * @return 结果
     */
    public int updateSupportAddress(SupportAddress supportAddress);

    /**
     * 批量删除行政区域名称
     * 
     * @param ids 需要删除的行政区域名称主键集合
     * @return 结果
     */
    public int deleteSupportAddressByIds(Long[] ids);

    /**
     * 删除行政区域名称信息
     * 
     * @param id 行政区域名称主键
     * @return 结果
     */
    public int deleteSupportAddressById(Long id);
}
