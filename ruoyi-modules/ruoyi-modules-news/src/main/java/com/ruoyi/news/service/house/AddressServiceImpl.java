package com.ruoyi.news.service.house;


import com.ruoyi.news.domain.dto.SubwayDTO;
import com.ruoyi.news.domain.dto.SubwayStationDTO;
import com.ruoyi.news.domain.dto.SupportAddressDTO;
import com.ruoyi.news.domain.entity.SupportAddress;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.ServiceResult;
import com.ruoyi.news.service.search.BaiduMapLocation;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AddressServiceImpl implements IAddressService {

    @Override
    public ServiceMultiResult<SupportAddressDTO> findAllCities() {
        return null;
    }

    @Override
    public Map<SupportAddress.Level, SupportAddressDTO> findCityAndRegion(String cityEnName, String regionEnName) {
        return null;
    }

    @Override
    public ServiceMultiResult findAllRegionsByCityName(String cityName) {
        return null;
    }

    @Override
    public List<SubwayDTO> findAllSubwayByCity(String cityEnName) {
        return null;
    }

    @Override
    public List<SubwayStationDTO> findAllStationBySubway(Long subwayId) {
        return null;
    }

    @Override
    public ServiceResult<SubwayDTO> findSubway(Long subwayId) {
        return null;
    }

    @Override
    public ServiceResult<SubwayStationDTO> findSubwayStation(Long stationId) {
        return null;
    }

    @Override
    public ServiceResult<SupportAddressDTO> findCity(String cityEnName) {
        return null;
    }

    @Override
    public ServiceResult<BaiduMapLocation> getBaiduMapLocation(String city, String address) {
        return null;
    }

    @Override
    public ServiceResult lbsUpload(BaiduMapLocation location, String title, String address, long houseId, int price, int area) {
        return null;
    }

    @Override
    public ServiceResult removeLbs(Long houseId) {
        return null;
    }
}
