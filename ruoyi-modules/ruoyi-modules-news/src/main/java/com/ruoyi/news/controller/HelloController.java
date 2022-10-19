package com.ruoyi.news.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.news.domain.Stu;
import org.elasticsearch.action.index.IndexRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class HelloController {

    @Autowired
    private ElasticsearchTemplate esTemplate;

    @RequestMapping("hello")
    public Object hello() {
        return AjaxResult.success();
    }

    @GetMapping("createIndex")
    public Object createIndex() {
        esTemplate.createIndex(Stu.class);
        return AjaxResult.success();
    }

    @GetMapping("deleteIndex")
    public Object deleteIndex() {
        esTemplate.deleteIndex(Stu.class);
        return AjaxResult.success();
    }

    @GetMapping("addDoc")
    public Object addDoc(String id) {
        Stu stu = new Stu();
        stu.setStuId(Long.parseLong(id));
        stu.setAge(18);
        stu.setName("imooc");
        stu.setMoney(100.2f);
        stu.setDesc("慕课网学习的学生");

        IndexQuery query = new IndexQueryBuilder()
                .withObject(stu)
                .build();

        esTemplate.index(query);
        return AjaxResult.success();
    }

    @GetMapping("updateDoc")
    public Object updateDoc(String id,String desc) {

        Map<String, Object> updateMap = new HashMap<>();
        updateMap.put("desc", desc);
        updateMap.put("age", 22);

        IndexRequest ir = new IndexRequest();
        ir.source(updateMap);

        UpdateQuery uq = new UpdateQueryBuilder()
                .withClass(Stu.class)
                .withId(id)
                .withIndexRequest(ir)
                .build();

        esTemplate.update(uq);
        return AjaxResult.success();
    }

    @GetMapping("getDoc")
    public Object getDoc(String id) {

        GetQuery getQuery = new GetQuery();
        getQuery.setId(id);
        Stu stu = esTemplate.queryForObject(getQuery, Stu.class);
        return AjaxResult.success(stu);
    }

    @GetMapping("deleteDoc")
    public Object deleteDoc(String id) {
        esTemplate.delete(Stu.class, id);
        return AjaxResult.success();
    }
}
