package com.ruoyi.news;

import cn.easyes.core.conditions.LambdaEsQueryWrapper;
import com.ruoyi.news.domain.model.DocumentLow;
import com.ruoyi.news.mapper.es.DocumentLowMapper;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;

import javax.annotation.Resource;

/**
 * @author : wuxiao
 * @date : 15:26 2022/10/20
 */
public class TestCreatIndex extends RuoYiNewsApplicationTest {

    @Resource
    private DocumentLowMapper documentMapper;

    @Test
    public void testInsert() {
        // 测试插入数据
        DocumentLow document = new DocumentLow();
        document.setTitle("老汉");
        document.setContent("推*技术过硬");
        int successCount = documentMapper.insert(document);
        System.out.println(successCount);
    }

    @Test
    public void testSelect() {
        // 测试查询
        String title = "老汉";
        LambdaEsQueryWrapper<DocumentLow> wrapper = new LambdaEsQueryWrapper<>();
        wrapper.eq(DocumentLow::getTitle,title);
        DocumentLow document = documentMapper.selectOne(wrapper);
        System.out.println(document);
    }


    @Test
    public void testUpdate() {
        // 测试更新 更新有两种情况 分别演示如下:
        // case1: 已知id, 根据id更新 (为了演示方便,此id是从上一步查询中复制过来的,实际业务可以自行查询)
        String id = "7MDJCYQBwa42pJMaporN";
        String title1 = "隔壁老刘";
        DocumentLow document1 = new DocumentLow();
        document1.setId(id);
        document1.setTitle(title1);
        document1.setContent("机器人审核");
        documentMapper.updateById(document1);

        // case2: id未知, 根据条件更新
//        LambdaEsUpdateWrapper<Document> wrapper = new LambdaEsUpdateWrapper<>();
//        wrapper.eq(Document::getTitle,title1);
//        Document document2 = new Document();
//        document2.setTitle("隔壁老李");
//        document2.setContent("推*技术过软");
//        documentMapper.update(document2,wrapper);

        // 关于case2 还有另一种省略实体的简单写法,这里不演示,后面章节有介绍,语法与MP一致
    }

    @Test
    public void testDeleteIndex() {
        // 测试删除索引
        // 指定要删除哪个索引
//        String indexName = DocumentLow.class.getSimpleName().toLowerCase();
//        System.out.println(indexName);
        boolean isOk = documentMapper.deleteIndex("document");
        Assertions.assertTrue(isOk);
    }
}
