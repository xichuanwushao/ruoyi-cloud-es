package com.ruoyi.news.mapper;

import java.util.List;
import com.ruoyi.news.domain.SupportAddress;

/**
 * 行政区域名称Mapper接口
 * 
 * @author wuxiao
 * @date 2022-11-07
 */
public interface SupportAddressMapper 
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
     * 删除行政区域名称
     * 
     * @param id 行政区域名称主键
     * @return 结果
     */
    public int deleteSupportAddressById(Long id);

    /**
     * 批量删除行政区域名称
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSupportAddressByIds(Long[] ids);
}
