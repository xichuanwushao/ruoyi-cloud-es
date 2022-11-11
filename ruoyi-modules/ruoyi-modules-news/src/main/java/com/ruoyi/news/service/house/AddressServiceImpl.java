package com.ruoyi.news.service.house;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.news.domain.SupportAddress;
import com.ruoyi.news.domain.dto.SubwayDTO;
import com.ruoyi.news.domain.dto.SubwayStationDTO;
import com.ruoyi.news.domain.dto.SupportAddressDTO;
import com.ruoyi.news.mapper.SupportAddressMapper;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.ServiceResult;
import com.ruoyi.news.service.search.BaiduMapLocation;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AddressServiceImpl implements IAddressService {

    private static final String BAIDU_MAP_GEOCONV_API = "https://api.map.baidu.com/geocoding/v3/?";//地理位置服务转码api 用于将文字描述地址转换为具体的经纬度

    private static final String BAIDU_MAP_KEY = "FICpNXF7uzerZRLMFTdvQRfMzoWNGS2f";

    private static final Logger logger = LoggerFactory.getLogger(IAddressService.class);

    @Autowired
    private SupportAddressMapper supportAddressRepository;

    @Autowired
    private ObjectMapper objectMapper;



    @Override
    public ServiceMultiResult<SupportAddressDTO> findAllCities() {
        return null;
    }

    @Override
    public Map<SupportAddress.Level, SupportAddressDTO> findCityAndRegion(String cityEnName, String regionEnName) {
        Map<SupportAddress.Level, SupportAddressDTO> result = new HashMap<>();

//        SupportAddress city = supportAddressRepository.findByEnNameAndLevel(cityEnName, SupportAddress.Level.CITY
//                .getValue());
//        SupportAddress region = supportAddressRepository.findByEnNameAndBelongTo(regionEnName, city.getEnName());

        SupportAddress supportAddressQu2 = new SupportAddress();
        supportAddressQu2.setEnName(cityEnName);
        supportAddressQu2.setLevel(SupportAddress.Level.CITY.getValue());
        SupportAddress city = supportAddressRepository.selectSupportAddressList(supportAddressQu2).get(0);


        SupportAddress supportAddressQu1 = new SupportAddress();
        supportAddressQu1.setBelongTo(city.getEnName());
        supportAddressQu1.setEnName(regionEnName);
        supportAddressQu1.setLevel(SupportAddress.Level.REGION
                .getValue());
        SupportAddress region = supportAddressRepository.selectSupportAddressList(supportAddressQu1).get(0);

        SupportAddressDTO cityAddressDTO = new SupportAddressDTO();
        BeanUtils.copyProperties(city, cityAddressDTO);
        cityAddressDTO.setBaiduMapLatitude(city.getBaiduMapLat());
        cityAddressDTO.setBaiduMapLongitude(city.getBaiduMapLng());


        SupportAddressDTO regionAddressDTO = new SupportAddressDTO();
        BeanUtils.copyProperties(region, regionAddressDTO);
        regionAddressDTO.setBaiduMapLatitude(region.getBaiduMapLat());
        regionAddressDTO.setBaiduMapLongitude(region.getBaiduMapLng());

//        result.put(SupportAddress.Level.CITY, modelMapper.map(city, SupportAddressDTO.class));
//        result.put(SupportAddress.Level.REGION, modelMapper.map(region, SupportAddressDTO.class));
        result.put(SupportAddress.Level.CITY, cityAddressDTO);
        result.put(SupportAddress.Level.REGION, regionAddressDTO);
        return result;
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
            supportAddressDTO.setBaiduMapLatitude(region.getBaiduMapLat());
            supportAddressDTO.setBaiduMapLongitude(region.getBaiduMapLng());
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
        addressDTO.setBaiduMapLatitude(supportAddress.getBaiduMapLat());
        addressDTO.setBaiduMapLongitude(supportAddress.getBaiduMapLng());
        return ServiceResult.of(addressDTO);
    }

    @Override
    public ServiceResult<BaiduMapLocation> getBaiduMapLocation(String city, String address) {
        String encodeAddress;
        String encodeCity;

        try {
            encodeAddress = URLEncoder.encode(address, "UTF-8");
            encodeCity = URLEncoder.encode(city, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            logger.error("Error to encode house address", e);
            return new ServiceResult<BaiduMapLocation>(false, "Error to encode hosue address");
        }

        HttpClient httpClient = HttpClients.createDefault();
        StringBuilder sb = new StringBuilder(BAIDU_MAP_GEOCONV_API);
        sb.append("address=").append(encodeAddress).append("&")
                .append("city=").append(encodeCity).append("&")
                .append("output=json&")
                .append("ak=").append(BAIDU_MAP_KEY);

        HttpGet get = new HttpGet(sb.toString());
        try {
            HttpResponse response = httpClient.execute(get);
            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                return new ServiceResult<BaiduMapLocation>(false, "Can not get baidu map location");
            }

            String result = EntityUtils.toString(response.getEntity(), "UTF-8");
            JsonNode jsonNode = objectMapper.readTree(result);
            int status = jsonNode.get("status").asInt();
            if (status != 0) {
                return new ServiceResult<BaiduMapLocation>(false, "Error to get map location for status: " + status);
            }
            {
                BaiduMapLocation location = new BaiduMapLocation();
                JsonNode jsonLocation = jsonNode.get("result").get("location");
                location.setLongitude(jsonLocation.get("lng").asDouble());
                location.setLatitude(jsonLocation.get("lat").asDouble());
                return ServiceResult.of(location);
            }

        } catch (IOException e) {
            logger.error("Error to fetch baidumap api", e);
            return new ServiceResult<BaiduMapLocation>(false, "Error to fetch baidumap api");
        }
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
