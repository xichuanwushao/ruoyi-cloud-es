package com.ruoyi.news.high;

import cn.easyes.core.conditions.LambdaEsQueryWrapper;
import com.ruoyi.news.RuoYiNewsApplicationTest;
import com.ruoyi.news.domain.model.Document;
import com.ruoyi.news.mapper.es.DocumentMapper;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author : wuxiao
 * @date : 15:26 2022/10/20
 */
public class HighTest extends RuoYiNewsApplicationTest {

    @Resource
    private DocumentMapper documentMapper;


    @Test
    public void testHighlight() {
        LambdaEsQueryWrapper<Document> wrapper = new LambdaEsQueryWrapper<>();
        String keyword = "测试";
        wrapper.match(Document::getContent, keyword);
        List<Document> documents = documentMapper.selectList(wrapper);
        System.out.println(documents);
    }
}
