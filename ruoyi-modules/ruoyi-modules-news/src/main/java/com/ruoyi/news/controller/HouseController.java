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
import com.ruoyi.news.domain.House;
import com.ruoyi.news.service.IHouseService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 房屋信息Controller
 * 
 * @author wuxiao
 * @date 2022-10-31
 */
@RestController
@RequestMapping("/house")
public class HouseController extends BaseController
{
    @Autowired
    private IHouseService houseService;

    /**
     * 查询房屋信息列表
     */
    @RequiresPermissions("news:house:list")
    @GetMapping("/list")
    public TableDataInfo list(House house)
    {
        startPage();
        List<House> list = houseService.selectHouseList(house);
        return getDataTable(list);
    }

    /**
     * 导出房屋信息列表
     */
    @RequiresPermissions("news:house:export")
    @Log(title = "房屋信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, House house)
    {
        List<House> list = houseService.selectHouseList(house);
        ExcelUtil<House> util = new ExcelUtil<House>(House.class);
        util.exportExcel(response, list, "房屋信息数据");
    }

    /**
     * 获取房屋信息详细信息
     */
    @RequiresPermissions("news:house:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(houseService.selectHouseById(id));
    }

    /**
     * 新增房屋信息
     */
    @RequiresPermissions("news:house:add")
    @Log(title = "房屋信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody House house)
    {
        return toAjax(houseService.insertHouse(house));
    }

    /**
     * 修改房屋信息
     */
    @RequiresPermissions("news:house:edit")
    @Log(title = "房屋信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody House house)
    {
        return toAjax(houseService.updateHouse(house));
    }

    /**
     * 删除房屋信息
     */
    @RequiresPermissions("news:house:remove")
    @Log(title = "房屋信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(houseService.deleteHouseByIds(ids));
    }
}
