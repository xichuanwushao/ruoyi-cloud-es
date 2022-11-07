package com.ruoyi.news.service.house;


import com.ruoyi.news.domain.SupportAddress;
import com.ruoyi.news.domain.dto.SubwayDTO;
import com.ruoyi.news.domain.dto.SubwayStationDTO;
import com.ruoyi.news.domain.dto.SupportAddressDTO;
import com.ruoyi.news.mapper.SupportAddressMapper;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.ServiceResult;
import com.ruoyi.news.service.search.BaiduMapLocation;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AddressServiceImpl implements IAddressService {

    @Autowired
    private SupportAddressMapper supportAddressRepository;



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
        if (cityName == null) {
            return new ServiceMultiResult<>(0, null);
        }

        List<SupportAddressDTO> result = new ArrayList<>();

        SupportAddress supportAddressQu = new SupportAddress();
        supportAddressQu.setBelongTo(cityName);
        supportAddressQu.setLevel(SupportAddress.Level.REGION
                .getValue());
        List<SupportAddress> regions = supportAddressRepository.selectSupportAddressList(supportAddressQu);

//        List<SupportAddress> regions = supportAddressRepository.findAllByLevelAndBelongTo(SupportAddress.Level.REGION
//                .getValue(), cityName);
        for (SupportAddress region : regions) {
//            result.add(modelMapper.map(region, SupportAddressDTO.class));
            SupportAddressDTO supportAddressDTO = new SupportAddressDTO();
            BeanUtils.copyProperties(region, supportAddressDTO);
            result.add(supportAddressDTO);
        }
        return new ServiceMultiResult<>(regions.size(), result);
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
        if (cityEnName == null) {
            return ServiceResult.notFound();
        }
        SupportAddress supportAddressQu = new SupportAddress();
        supportAddressQu.setEnName(cityEnName);
        supportAddressQu.setLevel(SupportAddress.Level.CITY.getValue());
        SupportAddress supportAddress = supportAddressRepository.selectSupportAddressList(supportAddressQu).get(0);

//      SupportAddress supportAddress = supportAddressRepository.findByEnNameAndLevel(cityEnName, SupportAddress.Level.CITY.getValue());
        if (supportAddress == null) {
            return ServiceResult.notFound();
        }

//        SupportAddressDTO addressDTO = modelMapper.map(supportAddress, SupportAddressDTO.class);

        SupportAddressDTO addressDTO = new SupportAddressDTO();
        BeanUtils.copyProperties(supportAddress, addressDTO);
        return ServiceResult.of(addressDTO);
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
