
## 平台简介
*基于RuoYi-cloud3.5.0 + elasticsearch7.14.1的搜索引擎演示项目,使用2个经典案例(百度地图找房+文章内容搜索),演示es常用的功能及代码原生写法和简化写法(easy-es)~

记得右上角点个 star 持续关注更新哟~~
* <img src="https://image-1304556315.cos.ap-beijing.myqcloud.com/star.png"/>
## 内置功能
后台页面
* 1.  房源信息：支持后台添加,修改,删除,编辑房源信息
前台页面
* 1.  聚合统计：统计每个区域每个小区房源个数。
* 2.  搜索提示(search-as-you-type)：根据输入文字动态弹出提示内容。
* 3.  地图找房：使用百度地图显示房源信息,地图拖拽和缩放变更房源数据。

## 在线体验
* (前台页面) http://49.232.18.37:9205
* (后台管理) http://49.232.18.37:9092
* 测试账号
* 流程管理账号：admin / admin123(可以绘制流程,测试流程请使用测试账号)
## 页面功能展示
<table>
    <tr>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_map_01.png"/></td>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_map_02.png"/></td>
    </tr>
    <tr>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_map_03.png"/></td>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_map_04.png"/></td>
    </tr>
    <tr>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_shou_01.png"/></td>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_shou_02.png"/></td>
    </tr>
    <tr>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_shou_03.png"/></td>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9205_shou_04.png"/></td>
    </tr>
    <tr>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9092_house_01.png"/></td>
        <td><img src="https://es7-1304556315.cos.ap-nanjing.myqcloud.com/9092_house_02.png"/></td>
    </tr>
</table>

## QQ交流群
* QQ交流群：612475165(加群请先star项目 不然验证不通过 备注格式：gitee用户名)
* <img src="https://image-1304556315.cos.ap-beijing.myqcloud.com/star.png"/>
## 启动说明
需要对以下模块进行启动 启动顺序随意
* RuoYiAuthApplication
* RuoYiSystemApplication
* RuoYiGatewayApplication
* RuoYiNewsApplication( 租房模块 )
* RuoYiFileApplication( 文件服务 )
#### 友情链接
* 感谢若依大佬开源的微服务项目:https://gitee.com/y_project/RuoYi-Cloud
* 感谢蜗牛不会飞大佬开源的找房项目:https://gitee.com/myxw/ElasticSearch_House
* 感谢老汉大佬开源的easy-es:https://gitee.com/dromara/easy-es
#### 插件版本
* RuoYi-Cloud 3.5.0
* Nacos 2.0.2
* Node.js 14.0.0
* npm 6.14.4
* elasticsearch 7.14.1