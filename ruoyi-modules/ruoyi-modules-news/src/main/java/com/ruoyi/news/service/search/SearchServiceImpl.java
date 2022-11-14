package com.ruoyi.news.service.search;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.google.common.primitives.Longs;
import com.ruoyi.news.domain.House;
import com.ruoyi.news.domain.HouseDetail;
import com.ruoyi.news.domain.SupportAddress;
import com.ruoyi.news.domain.form.MapSearch;
import com.ruoyi.news.domain.form.RentSearch;
import com.ruoyi.news.domain.model.HouseIndexTemplate;
import com.ruoyi.news.domain.model.HouseSuggest;
import com.ruoyi.news.mapper.SupportAddressMapper;
import com.ruoyi.news.service.IHouseService;
import com.ruoyi.news.service.ServiceMultiResult;
import com.ruoyi.news.service.ServiceResult;
import com.ruoyi.news.service.house.IAddressService;
import com.ruoyi.news.util.base.HouseSort;
import com.ruoyi.news.util.base.RentValueBlock;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.action.update.UpdateResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.AnalyzeRequest;
import org.elasticsearch.client.indices.AnalyzeResponse;
import org.elasticsearch.common.geo.GeoPoint;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.index.reindex.BulkByScrollResponse;
import org.elasticsearch.index.reindex.DeleteByQueryRequest;
import org.elasticsearch.rest.RestStatus;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.elasticsearch.search.suggest.Suggest;
import org.elasticsearch.search.suggest.SuggestBuilder;
import org.elasticsearch.search.suggest.SuggestBuilders;
import org.elasticsearch.search.suggest.completion.CompletionSuggestion;
import org.elasticsearch.search.suggest.completion.CompletionSuggestionBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class SearchServiceImpl implements ISearchService {
    private static final Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);
    private static final String INDEX_NAME = "xunwu";

    private static final String INDEX_TYPE = "house";

    private static final String INDEX_TOPIC = "house_build";

    @Autowired
    private SupportAddressMapper supportAddressRepository;

    @Autowired
    private RestHighLevelClient esClient;

    @Autowired
    private IHouseService houseService;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private IAddressService addressService;

    @Override
    public void index(Long houseId) {
        HouseIndexMessage message = new HouseIndexMessage();
        message.setHouseId(houseId);
        try {
            createOrUpdateIndex(message);
        }catch (Exception e){

        }
    }



    private void createOrUpdateIndex(HouseIndexMessage message) throws IOException {
        Long houseId = message.getHouseId();
//        House house = houseRepository.findOne(houseId);
        House house = houseService.selectHouseById(houseId);
        if (house == null) {
            logger.error("Index house{} does not exist!", houseId);
            this.index(houseId, message.getRetry() + 1);
            return;
        }
        HouseIndexTemplate indexTemplate = new HouseIndexTemplate();
//        modelMapper.map(house, indexTemxplate);
        BeanUtils.copyProperties(house,indexTemplate);

//        HouseDetail detail = houseDetailRepository.findByHouseId(houseId);
        HouseDetail detail = house.getHouseDetailList().get(0);
        if (detail == null) {
            // TODO 异常情况
        }
//        modelMapper.map(detail, indexTemplate);
        BeanUtils.copyProperties(detail, indexTemplate);
        indexTemplate.setId(houseId);

        SupportAddress supportAddressQu1 = new SupportAddress();
        supportAddressQu1.setEnName(house.getCityEnName());
        supportAddressQu1.setLevel(SupportAddress.Level.CITY.getValue());
        SupportAddress city  = supportAddressRepository.selectSupportAddressList(supportAddressQu1).get(0);

        SupportAddress supportAddressQu2 = new SupportAddress();
        supportAddressQu2.setEnName(house.getRegionEnName());
        supportAddressQu2.setLevel(SupportAddress.Level.REGION
                .getValue());
        SupportAddress region = supportAddressRepository.selectSupportAddressList(supportAddressQu2).get(0);


//         SupportAddress city = supportAddressRepository.findByEnNameAndLevel(house.getCityEnName(), SupportAddress.Level.CITY.getValue());
//        SupportAddress region = supportAddressRepository.findByEnNameAndLevel(house.getRegionEnName(), SupportAddress.Level.REGION.getValue());
        String address = city.getCnName() + region.getCnName() + house.getStreet() + house.getDistrict() + detail.getAddress();

        ServiceResult<BaiduMapLocation> location = addressService.getBaiduMapLocation(city.getCnName(), address);
        if (!location.isSuccess()) {
            this.index(message.getHouseId(), message.getRetry() + 1);
            return;
        }


        indexTemplate.setLocation(location.getResult());

// TODO       List<HouseTag> tags = tagRepository.findAllByHouseId(houseId);
//        if (!CollectionUtils.isEmpty(tags)) {
//            List<String> tagStrings = new ArrayList<>();
//            tags.forEach(houseTag -> tagStrings.add(houseTag.getName()));//把list中对象某个字段取出来 加入到其他list
//            indexTemplate.setTags(tagStrings);
//        }
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .docValueField(INDEX_TYPE)
                .query(QueryBuilders.termQuery(HouseIndexKey.HOUSE_ID, houseId));
        SearchRequest searchRequest = new SearchRequest(INDEX_NAME);
        searchRequest.source(searchSourceBuilder);
        SearchResponse searchResponse = esClient.search(searchRequest, RequestOptions.DEFAULT);
        boolean success;
        SearchHit[] hits = searchResponse.getHits().getHits();
        long totalHit = searchResponse.getHits().getTotalHits().value;
        if (totalHit == 0) {
            success = create(indexTemplate);
        } else if (totalHit == 1) {
            String esId = searchResponse.getHits().getAt(0).getId();
            success = update(esId, indexTemplate);
        } else {
            success = deleteAndCreate(totalHit, indexTemplate);
        }
        ServiceResult serviceResult = ServiceResult.success();
//TODO        ServiceResult serviceResult = addressService.lbsUpload(location.getResult(), house.getStreet() + house.getDistrict(),
//                city.getCnName() + region.getCnName() + house.getStreet() + house.getDistrict(),
//                message.getHouseId(), house.getPrice(), house.getArea());

        if (!success || !serviceResult.isSuccess()) {
            this.index(message.getHouseId(), message.getRetry() + 1);
        } else {
            logger.debug("Index success with house " + houseId);
        }
//        if (success) {
//        	logger.debug("Index success with house " + houseId);
//		}
    }

    private boolean create(HouseIndexTemplate indexTemplate) {
        if (!updateSuggest(indexTemplate)) { //search-as-you-type自动补全
            return false;
        }

        try {
            IndexRequest source = new IndexRequest(INDEX_NAME).source(objectMapper.writeValueAsBytes(indexTemplate), XContentType.JSON);
            IndexResponse response = esClient.index(source, RequestOptions.DEFAULT);

            logger.debug("Create index with house: " + indexTemplate.getHouseId());
            return response.status() == RestStatus.CREATED;
        } catch (IOException e) {
            logger.error("Error to index house " + indexTemplate.getHouseId(), e);
            return false;
        }
    }
    private boolean update(String esId, HouseIndexTemplate indexTemplate) {
        if (!updateSuggest(indexTemplate)) {
            return false;
        }

        try {
            UpdateRequest request = new UpdateRequest().index(INDEX_NAME).doc(objectMapper.writeValueAsBytes(indexTemplate), XContentType.JSON).id(esId);
            UpdateResponse response = esClient.update(request, RequestOptions.DEFAULT);

            logger.debug("Update index with house: " + indexTemplate.getHouseId());
            return response.status() == RestStatus.OK;
        } catch (IOException e) {
            logger.error("Error to index house " + indexTemplate.getHouseId(), e);
            return false;
        }
    }

    private boolean deleteAndCreate(long totalHit, HouseIndexTemplate indexTemplate) throws IOException {
        DeleteByQueryRequest request = new DeleteByQueryRequest(INDEX_NAME).setQuery(QueryBuilders.termQuery(HouseIndexKey.HOUSE_ID, indexTemplate.getHouseId()));
        BulkByScrollResponse response = esClient.deleteByQuery(request, RequestOptions.DEFAULT);
        logger.debug("Delete by query for house: " + request);

        long deleted = response.getDeleted();
        if (deleted != totalHit) {
            logger.warn("Need delete {}, but {} was deleted!", totalHit, deleted);
            return false;
        } else {
            return create(indexTemplate);
        }
    }


    private void index(Long houseId, int retry) {}


    @Override
    public void remove(Long houseId) {

    }

    @Override
    public ServiceMultiResult<Long> query(RentSearch rentSearch) {
        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery()
                .filter(
                        QueryBuilders.termQuery(HouseIndexKey.CITY_EN_NAME, rentSearch.getCityEnName())
                );

        if (rentSearch.getRegionEnName() != null && !"*".equals(rentSearch.getRegionEnName())) {
            boolQuery.filter(
                    QueryBuilders.termQuery(HouseIndexKey.REGION_EN_NAME, rentSearch.getRegionEnName())
            );
        }

        RentValueBlock area = RentValueBlock.matchArea(rentSearch.getAreaBlock());
        if (!RentValueBlock.ALL.equals(area)) {
            RangeQueryBuilder rangeQueryBuilder = QueryBuilders.rangeQuery(HouseIndexKey.AREA);
            if (area.getMax() > 0) {
                rangeQueryBuilder.lte(area.getMax());
            }
            if (area.getMin() > 0) {
                rangeQueryBuilder.gte(area.getMin());
            }
            boolQuery.filter(rangeQueryBuilder);
        }

        RentValueBlock price = RentValueBlock.matchPrice(rentSearch.getPriceBlock());
        if (!RentValueBlock.ALL.equals(price)) {
            RangeQueryBuilder rangeQuery = QueryBuilders.rangeQuery(HouseIndexKey.PRICE);
            if (price.getMax() > 0) {
                rangeQuery.lte(price.getMax());
            }
            if (price.getMin() > 0) {
                rangeQuery.gte(price.getMin());
            }
            boolQuery.filter(rangeQuery);
        }

        if (rentSearch.getDirection() > 0) {
            boolQuery.filter(
                    QueryBuilders.termQuery(HouseIndexKey.DIRECTION, rentSearch.getDirection())
            );
        }

        if (rentSearch.getRentWay() > -1) {
            boolQuery.filter(
                    QueryBuilders.termQuery(HouseIndexKey.RENT_WAY, rentSearch.getRentWay())
            );
        }

//	        boolQuery.should(
//	                QueryBuilders.matchQuery(HouseIndexKey.TITLE, rentSearch.getKeywords())
//	                        .boost(2.0f) //设置查询字段的权重
//	        );

        if(rentSearch.getKeywords() != null) {
            boolQuery.must(
                    QueryBuilders.multiMatchQuery(rentSearch.getKeywords(),
                            HouseIndexKey.TITLE,
                            HouseIndexKey.TRAFFIC,
                            HouseIndexKey.DISTRICT,
                            HouseIndexKey.ROUND_SERVICE,
                            HouseIndexKey.SUBWAY_LINE_NAME,
                            HouseIndexKey.SUBWAY_STATION_NAME
                    ));
        }
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .query(boolQuery)
                .sort(HouseSort.getSortKey(rentSearch.getOrderBy()), SortOrder.fromString(rentSearch.getOrderDirection()))
                .from(rentSearch.getStart())
                .size(rentSearch.getSize())
                .fetchSource(HouseIndexKey.HOUSE_ID, null);//解决searchRequest数据集过大的问题 优化 这样响应就会更加快一些
        SearchRequest searchRequest = new SearchRequest(INDEX_NAME).source(searchSourceBuilder);

        logger.debug("searchSourceBuilder "+searchSourceBuilder.toString());
        logger.debug("searchRequest "+searchRequest.toString());

        SearchResponse response = null;
        try {
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            logger.error("查询es错误");
            return new ServiceMultiResult<>(0, null);
        }

        List<Long> houseIds = new ArrayList<>();
        if (response.status() != RestStatus.OK) {
            logger.warn("Search status is no ok for " + searchRequest);
            return new ServiceMultiResult<>(0, houseIds);
        }

        for (SearchHit hit : response.getHits()) {
            System.out.println(hit.getSourceAsMap());
            houseIds.add(Longs.tryParse(String.valueOf(hit.getSourceAsMap().get(HouseIndexKey.HOUSE_ID))));
        }

        return new ServiceMultiResult<>(response.getHits().getTotalHits().value, houseIds);

    }

    @Override
    public ServiceResult<List<String>> suggest(String prefix) {
        //提示多少个 默认5个 suggest要和索引字段名称对应起来
        CompletionSuggestionBuilder suggestion = SuggestBuilders.completionSuggestion("suggest").prefix(prefix).size(5);//提示5个

        SuggestBuilder suggestBuilder = new SuggestBuilder().addSuggestion("autocomplete", suggestion);//固定写法

        SearchRequest searchRequest = new SearchRequest(INDEX_NAME).source(new SearchSourceBuilder().suggest(suggestBuilder));
        SearchResponse response = null;
        try {
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            return new ServiceResult<>(false);
        }

        logger.debug(searchRequest.toString());

        Suggest suggest = response.getSuggest();
        if (suggest == null) {
            return ServiceResult.of(new ArrayList<>());
        }
        Suggest.Suggestion result = suggest.getSuggestion("autocomplete");

        int maxSuggest = 0;
        Set<String> suggestSet = new HashSet<>();//需要对结果进行过滤 因为有重复的提示词语

        for (Object term : result.getEntries()) {
            if (term instanceof CompletionSuggestion.Entry) {
                CompletionSuggestion.Entry item = (CompletionSuggestion.Entry) term;

                if (item.getOptions().isEmpty()) {//提示备选项为空
                    continue;
                }

                for (CompletionSuggestion.Entry.Option option : item.getOptions()) {//提示备选项不为空
                    String tip = option.getText().string();
                    if (suggestSet.contains(tip)) {
                        continue;
                    }
                    suggestSet.add(tip);
                    maxSuggest++;
                }
            }

            if (maxSuggest > 5) {
                break;
            }
        }
        List<String> suggests = Lists.newArrayList(suggestSet.toArray(new String[]{}));
        return ServiceResult.of(suggests);
    }

    private boolean updateSuggest(HouseIndexTemplate indexTemplate) {
        AnalyzeRequest analyzeRequest = AnalyzeRequest.withIndexAnalyzer(INDEX_NAME, "ik_smart", indexTemplate.getTitle(),
                indexTemplate.getLayoutDesc(), indexTemplate.getRoundService(),
                indexTemplate.getDescription(), indexTemplate.getSubwayLineName(),//自动补全其实就是去请求分词接口
                indexTemplate.getSubwayStationName());
        List<AnalyzeResponse.AnalyzeToken> tokens = null;

        try {
            AnalyzeResponse response = esClient.indices().analyze(analyzeRequest, RequestOptions.DEFAULT);//分词结果
            tokens = response.getTokens();//tokens就是每一个词语
        } catch (IOException e) {
            logger.error("updateSuggest错误", e);
            return false;
        }
        if (tokens == null) {
            logger.warn("Can not analyze token for house: " + indexTemplate.getHouseId());
            return false;
        }

        List<HouseSuggest> suggests = new ArrayList<>();
        for (AnalyzeResponse.AnalyzeToken token : tokens) {
            // 排序数字类型 & 小于2个字符的分词结果
            if ("<NUM>".equals(token.getType()) || token.getTerm().length() < 2) {
                continue;
            }

            HouseSuggest suggest = new HouseSuggest();
            suggest.setInput(token.getTerm());//这里默认一样的权重
            suggests.add(suggest);
        }

        // 定制化小区自动补全 对于一些keyword不需要分词的字如何去做呢
        HouseSuggest suggest = new HouseSuggest();
        suggest.setInput(indexTemplate.getDistrict());
        suggests.add(suggest);

        indexTemplate.setSuggest(suggests);
        return true;
    }


    @Override
    public ServiceResult<Long> aggregateDistrictHouse(String cityEnName, String regionEnName, String district) {
        return null;
    }

    @Override
    public ServiceMultiResult<HouseBucketDTO> mapAggregate(String cityEnName) {
        //首先查询城市数据 过滤城市
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .query(QueryBuilders.boolQuery().filter(QueryBuilders.termQuery(HouseIndexKey.CITY_EN_NAME, cityEnName)))
                //根据区域来聚合 使用AGG_REGION分组 REGION_EN_NAME字段聚合
                .aggregation(AggregationBuilders.terms(HouseIndexKey.AGG_REGION).field(HouseIndexKey.REGION_EN_NAME));
        SearchRequest searchRequest = new SearchRequest(INDEX_NAME).source(searchSourceBuilder);
        SearchResponse response = null;
        try {
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            return new ServiceMultiResult<>(0, null);
        }
        logger.debug(searchRequest.toString());

        //初始化一个结果集
        List<HouseBucketDTO> buckets = new ArrayList<>();
        if (response.status() != RestStatus.OK) {
            logger.warn("Aggregate status is not ok for " + searchRequest);
            return new ServiceMultiResult<>(0, buckets);
        }
        Terms terms = response.getAggregations().get(HouseIndexKey.AGG_REGION);
        for (Terms.Bucket bucket : terms.getBuckets()) {
            buckets.add(new HouseBucketDTO(bucket.getKeyAsString(), bucket.getDocCount()));
        }

        return new ServiceMultiResult<>(response.getHits().getTotalHits().value, buckets);
    }

    @Override
    public ServiceMultiResult<Long> mapQuery(String cityEnName, String orderBy, String orderDirection, int start, int size) {
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .query(QueryBuilders.boolQuery().filter(QueryBuilders.termQuery(HouseIndexKey.CITY_EN_NAME, cityEnName)))
                .sort(HouseSort.getSortKey(orderBy), SortOrder.fromString(orderDirection))
                .from(start)
                .size(size);
        SearchRequest searchRequest = new SearchRequest(INDEX_NAME).source(searchSourceBuilder);
        SearchResponse response = null;
        try {
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            return new ServiceMultiResult<Long>(0, null);
        }

        List<Long> houseIds = new ArrayList<>();
        if (response.status() != RestStatus.OK) {
            logger.warn("Search status is not ok for " + searchRequest);
            return new ServiceMultiResult<>(0, houseIds);
        }

        for (SearchHit hit : response.getHits()) {
            houseIds.add(Longs.tryParse(String.valueOf(hit.getSourceAsMap().get(HouseIndexKey.HOUSE_ID))));
        }
        return new ServiceMultiResult<Long>(response.getHits().getTotalHits().value, houseIds);
    }

    @Override
    public ServiceMultiResult<Long> mapQuery(MapSearch mapSearch) {
        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery()
                .filter(QueryBuilders.termQuery(HouseIndexKey.CITY_EN_NAME, mapSearch.getCityEnName()))
                .filter(
                        QueryBuilders.geoBoundingBoxQuery("location")
                                .setCorners(
                                        new GeoPoint(mapSearch.getLeftLatitude(), mapSearch.getLeftLongitude()),
                                        new GeoPoint(mapSearch.getRightLatitude(), mapSearch.getRightLongitude())
                                )
                );

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .query(boolQuery)
                .sort(HouseSort.getSortKey(mapSearch.getOrderBy()), SortOrder.fromString(mapSearch.getOrderDirection()))
                .from(mapSearch.getStart())
                .size(mapSearch.getSize());
        SearchRequest searchRequest = new SearchRequest(INDEX_NAME).source(searchSourceBuilder);
        SearchResponse response = null;
        try {
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            return new ServiceMultiResult<Long>(0, null);
        }

        List<Long> houseIds = new ArrayList<>();
        if (RestStatus.OK != response.status()) {
            logger.warn("Search status is not ok for " + searchRequest);
            return new ServiceMultiResult<>(0, houseIds);
        }

        for (SearchHit hit : response.getHits()) {
            houseIds.add(Longs.tryParse(String.valueOf(hit.getSourceAsMap().get(HouseIndexKey.HOUSE_ID))));
        }
        return new ServiceMultiResult<Long>(response.getHits().getTotalHits().value, houseIds);
    }
}
