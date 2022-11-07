package com.ruoyi.news.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.news.domain.SupportAddress;
import com.ruoyi.news.service.ISupportAddressService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 行政区域名称Controller
 * 
 * @author wuxiao
 * @date 2022-11-07
 */
@RestController
@RequestMapping("/supportaddress")
public class SupportAddressController extends BaseController
{
    @Autowired
    private ISupportAddressService supportAddressService;

    /**
     * 查询行政区域名称列表
     */
    @RequiresPermissions("news:supportaddress:list")
    @GetMapping("/list")
    public TableDataInfo list(SupportAddress supportAddress)
    {
        startPage();
        List<SupportAddress> list = supportAddressService.selectSupportAddressList(supportAddress);
        return getDataTable(list);
    }

    /**
     * 导出行政区域名称列表
     */
    @RequiresPermissions("news:supportaddress:export")
    @Log(title = "行政区域名称", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SupportAddress supportAddress)
    {
        List<SupportAddress> list = supportAddressService.selectSupportAddressList(supportAddress);
        ExcelUtil<SupportAddress> util = new ExcelUtil<SupportAddress>(SupportAddress.class);
        util.exportExcel(response, list, "行政区域名称数据");
    }

    /**
     * 获取行政区域名称详细信息
     */
    @RequiresPermissions("news:supportaddress:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(supportAddressService.selectSupportAddressById(id));
    }

    /**
     * 新增行政区域名称
     */
    @RequiresPermissions("news:supportaddress:add")
    @Log(title = "行政区域名称", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SupportAddress supportAddress)
    {
        return toAjax(supportAddressService.insertSupportAddress(supportAddress));
    }

    /**
     * 修改行政区域名称
     */
    @RequiresPermissions("news:supportaddress:edit")
    @Log(title = "行政区域名称", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SupportAddress supportAddress)
    {
        return toAjax(supportAddressService.updateSupportAddress(supportAddress));
    }

    /**
     * 删除行政区域名称
     */
    @RequiresPermissions("news:supportaddress:remove")
    @Log(title = "行政区域名称", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(supportAddressService.deleteSupportAddressByIds(ids));
    }
}
