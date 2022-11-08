package com.ruoyi.news.house.search;

import com.ruoyi.news.RuoYiNewsApplicationTest;
import com.ruoyi.news.domain.form.RentSearch;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.search.ISearchService;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class SearchServiceTests extends RuoYiNewsApplicationTest {

    @Autowired
    private ISearchService searchService;

    @Test
    public void testIndex() {
        Long targetHouseId = 16L;
        searchService.index(targetHouseId);
//        boolean success = searchService.index(targetHouseId);
//        Assert.assertTrue(success);
        for(int i = 15; i <= 27; i++){
            searchService.index((long)i);
        }
    }

    @Test
    public void testRemove() {
        Long targetHouseId = 15L;

        searchService.remove(targetHouseId);
    }

    @Test
    public void testQuery() {
        RentSearch rentSearch = new RentSearch();
        rentSearch.setCityEnName("bj");
        rentSearch.setStart(0);
        rentSearch.setSize(10);
        rentSearch.setKeywords("国贸");
        ServiceMultiResult<Long> serviceResult = searchService.query(rentSearch);
        System.out.println(serviceResult.getResult());
        Assert.assertTrue(serviceResult.getTotal() > 0);
    }
}
