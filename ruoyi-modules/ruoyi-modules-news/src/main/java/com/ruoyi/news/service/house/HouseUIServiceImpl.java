package com.ruoyi.news.service.house;


import com.google.common.collect.Maps;
import com.ruoyi.news.domain.House;
import com.ruoyi.news.domain.HouseDetail;
import com.ruoyi.news.domain.dto.HouseDTO;
import com.ruoyi.news.domain.dto.HouseDetailDTO;
import com.ruoyi.news.domain.form.*;
import com.ruoyi.news.service.IHouseService;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.ServiceResult;
import com.ruoyi.news.service.search.ISearchService;
import com.ruoyi.news.util.base.HouseSubscribeStatus;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class HouseUIServiceImpl implements IHouseUIService {
    @Autowired
    private IHouseService houseService;

    @Autowired
    private ISearchService searchService;

    @Override
    public ServiceResult<HouseDTO> save(HouseForm houseForm) {
        return null;
    }

    @Override
    public ServiceResult update(HouseForm houseForm) {
        return null;
    }

    @Override
    public ServiceMultiResult<HouseDTO> adminQuery(DatatableSearch searchBody) {
        return null;
    }

    @Override
    public ServiceResult<HouseDTO> findCompleteOne(Long id) {
        return null;
    }

    @Override
    public ServiceResult removePhoto(Long id) {
        return null;
    }

    @Override
    public ServiceResult updateCover(Long coverId, Long targetId) {
        return null;
    }

    @Override
    public ServiceResult addTag(Long houseId, String tag) {
        return null;
    }

    @Override
    public ServiceResult removeTag(Long houseId, String tag) {
        return null;
    }

    @Override
    public ServiceResult updateStatus(Long id, int value) {
        return null;
    }

    @Override
    public ServiceMultiResult<HouseDTO> query(RentSearch rentSearch) {
        if (rentSearch.getKeywords() != null && !rentSearch.getKeywords().isEmpty()) {
            ServiceMultiResult<Long> serviceResult = searchService.query(rentSearch);
            if (serviceResult.getTotal() == 0) {
                return new ServiceMultiResult<>(0, new ArrayList<>());
            }

//            return new ServiceMultiResult<>(serviceResult.getTotal(), wrapperHouseResult(serviceResult.getResult()));
        }
        return simpleQuery(rentSearch);

    }


    private ServiceMultiResult<HouseDTO> simpleQuery(RentSearch rentSearch) {
        House house1 = new House();
        house1.setCityEnName(rentSearch.getCityEnName());
        List<House> houses = houseService.selectHouseList(house1);
        List<HouseDTO> houseDTOS = new ArrayList<>();
//        List<Long> houseIds = new ArrayList<>();
//        Map<Long, HouseDTO> idToHouseMap = Maps.newHashMap();
        houses.forEach(house -> {

            HouseDTO houseDTO = new HouseDTO();
            BeanUtils.copyProperties(house, houseDTO);
            houseDTO.setCover( house.getCover());

            HouseDetailDTO detailDTO = new HouseDetailDTO();

            House house2 = houseService.selectHouseById(house.getId());

            if(house2.getHouseDetailList()!=null){
                HouseDetail houseDetail = house2.getHouseDetailList().get(0);
                BeanUtils.copyProperties(houseDetail, detailDTO);
                houseDTO.setHouseDetail(detailDTO);
            }

            houseDTOS.add(houseDTO);
//            houseIds.add(house.getId());
//            idToHouseMap.put(house.getId(), houseDTO);
        });

        return new ServiceMultiResult<>(houses.size(), houseDTOS);
    }



    @Override
    public ServiceMultiResult<HouseDTO> wholeMapQuery(MapSearch mapSearch) {
        return null;
    }

    @Override
    public ServiceMultiResult<HouseDTO> boundMapQuery(MapSearch mapSearch) {
        return null;
    }

    @Override
    public ServiceResult addSubscribeOrder(Long houseId) {
        return null;
    }

    @Override
    public ServiceMultiResult<Pair<HouseDTO, HouseSubscribeDTO>> querySubscribeList(HouseSubscribeStatus of, int start, int size) {
        return null;
    }

    @Override
    public ServiceResult subscribe(Long houseId, Date orderTime, String telephone, String desc) {
        return null;
    }

    @Override
    public ServiceResult cancelSubscribe(Long houseId) {
        return null;
    }

    @Override
    public ServiceMultiResult<Pair<HouseDTO, HouseSubscribeDTO>> findSubscribeList(int start, int size) {
        return null;
    }

    @Override
    public ServiceResult finishSubscribe(Long houseId) {
        return null;
    }
}
