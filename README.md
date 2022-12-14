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
* 点击链接加入群聊【ruoyi-cloud-es】：https://jq.qq.com/?_wv=1027&k=lV5NGYNM

## 启动说明

需要对以下模块进行启动 启动顺序随意

* RuoYiAuthApplication
* RuoYiSystemApplication
* RuoYiGatewayApplication
* RuoYiNewsApplication( 租房模块 )
* RuoYiFileApplication( 文件服务 )

### 友情链接

* 感谢若依大佬开源的微服务项目:https://gitee.com/y_project/RuoYi-Cloud
* 感谢蜗牛不会飞大佬开源的找房项目:https://gitee.com/myxw/ElasticSearch_House
* 感谢老汉大佬开源的easy-es:https://gitee.com/dromara/easy-es

### 插件版本

* RuoYi-Cloud 3.5.0
* Nacos 2.0.2
* Node.js 14.0.0
* npm 6.14.4
* elasticsearch 7.14.1

## 环境安装

### 1.1 安装docker

```
    yum install -y yum-utils

  # 阿里云地址（国内地址，相对更快）
  yum-config-manager \
      --add-repo \
      http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

  yum install docker-ce docker-ce-cli containerd.io


  docker version # 查看Docker版本信息

  systemctl status docker		# 查看 docker 服务状态

  systemctl start docker		# 启动 docker 服务:
  systemctl stop docker		# 停止 docker 服务:
  systemctl status docker		# 查看 docker 服务状态
  systemctl restart docker	# 重启 docker 服务

  vim /etc/docker/daemon.json
  # 添加如下内容，可以自己替换。默认地址是我的创建的
  {
    "registry-mirrors": ["https://mr63yffu.mirror.aliyuncs.com"]
  }

  systemctl daemon-reload
  systemctl restart docker	# 重启 docker 服务
```



### 1.2 安装docker-compose

	  curl -L https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	
	  # 将可执行权限应用于该二进制文件
	  sudo chmod +x /usr/local/bin/docker-compose
	
	  docker-compose --version

------

### 1.3 安装es

#### 执行命令

```
mkdir -p /data/docker_data/es-kabana
mkdir -p /data/docker_data/es-kabana/es/config
touch    /data/docker_data/es-kabana/docker-compose.yml
touch    /data/docker_data/es-kabana/es/config/elasticsearch.yml
vim      /data/docker_data/es-kabana/docker-compose.yml
vim      /data/docker_data/es-kabana/es/config/elasticsearch.yml
cd /data/docker_data/es-kabana
docker-compose up -d 开启es
docker-compose down 关闭es
```

#### docker-compose.yml内容如下：

	version: '3'
	
	# 网桥es -> 方便相互通讯
	networks:
	  es:
	
	services:
	  elasticsearch:
	    image: registry.cn-hangzhou.aliyuncs.com/zhengqing/elasticsearch:7.14.1      # 原镜像`elasticsearch:7.14.1`
	    container_name: elasticsearch             # 容器名为'elasticsearch'
	    restart: unless-stopped                           # 指定容器退出后的重启策略为始终重启，但是不考虑在Docker守护进程启动时就已经停止了的容器
	    volumes:                                  # 数据卷挂载路径设置,将本机目录映射到容器目录
	      - "./es/data:/usr/share/elasticsearch/data"
	      - "./es/logs:/usr/share/elasticsearch/logs"
	      - "./es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml"
	      - "./es/plugins/:/usr/share/elasticsearch/plugins"
	    environment:                              # 设置环境变量,相当于docker run命令中的-e
	      TZ: Asia/Shanghai
	      LANG: en_US.UTF-8
	      discovery.type: single-node
	      ES_JAVA_OPTS: "-Xmx512m -Xms512m"
	      ELASTIC_PASSWORD: "123456" # elastic账号密码
	    ports:
	      - "9202:9200"
	      - "9302:9300"
	    networks:
	      - es
	
	  kibana:
	    image: registry.cn-hangzhou.aliyuncs.com/zhengqing/kibana:7.14.1       # 原镜像`kibana:7.14.1`
	    container_name: kibana
	    restart: unless-stopped
	    volumes:
	      - ./kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml
	      - ./kibana/logs:/usr/share/kibana/logs
	    environment:
	      TZ: Asia/Shanghai    # 更改容器时区为 CST（默认为UTC）
	      LANG: en_US.UTF-8
	    ports:
	      - "5601:5601"
	    depends_on:
	      - elasticsearch
	    links:
	      - elasticsearch
	    networks:
	      - es
	  elasticsearch-head:
	    image: wallbase/elasticsearch-head:6-alpine
	    container_name: elasticsearch-head
	    restart: unless-stopped
	    environment:
	      TZ: 'Asia/Shanghai'
	    ports:
	      - '9100:9100'
	    networks:
	      - es

#### elasticsearch.yml内容如下：

```
cluster.name: "docker-cluster"
network.host: 0.0.0.0
http.port: 9200
# 开启es跨域
http.cors.enabled: true
http.cors.allow-origin: "*"
http.cors.allow-headers: Authorization,Content-Type
# 开启安全控制
#xpack.security.enabled: true
#xpack.security.transport.ssl.enabled: true
```

### 1.4安装中文分词

先去github下载分词包[elasticsearch-analysis-ik-7.14.1.zip](https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.14.1/elasticsearch-analysis-ik-7.14.1.zip)

然后解压到该目录下/data/docker_data/es-kabana/es/plugins/analysis-ik-7.14.1

## 启动说明

## 一.启动前数据准备,创建es索引

### 1.1 创建文章内容索引article

请求方式：PUT

请求地址：http://127.0.0.1:9202/article

请求内容：

	{
	  "settings": {
	    "number_of_replicas": 0
	  },
	  "mappings": {
	    "dynamic": false,
	    "properties": {
	        "publishTime": {
	          "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis",
	          "type": "date"
	        },
	        "articleCover": {
	          "type": "keyword"
	        },
	        "articleType": {
	          "type": "integer"
	        },
	        "publishUserId": {
	          "type": "keyword"
	        },
	        "title": {
	          "analyzer": "ik_smart",
	          "type": "text"
	        },
	        "categoryId": {
	          "type": "integer"
	        }
	      }
	  }
	}

参数说明：

	number_of_replicas": 0  <!-- 副本数设置为0 -->


正确返回：

```
{
    "acknowledged": true,
    "shards_acknowledged": true,
    "index": "article"
}
```

------

### 1.2 创建地图找房索引article

请求方式：PUT

请求地址：http://127.0.0.1:9202/xunwu

请求内容：

	{
	  "settings": {
	    "number_of_replicas": 0
	  },
	  "mappings": {
	    "dynamic": false,
	    "properties": {
	      "id": {
	        "type": "long"
	      },
	      "houseId": {
	        "type": "long"
	      },
	      "title": {
	        "type": "text",
	        "analyzer": "ik_smart",
	        "search_analyzer": "ik_smart"
	      },
	      "price": {
	        "type": "integer"
	      },
	      "area": {
	        "type": "integer"
	      },
	      "createTime": {
	        "type": "date",
	        "format": "strict_date_optional_time||epoch_millis"
	      },
	      "lastUpdateTime": {
	        "type": "date",
	        "format": "strict_date_optional_time||epoch_millis"
	      },
	      "cityEnName": {
	        "type": "keyword"
	      },
	      "regionEnName": {
	        "type": "keyword"
	      },
	      "direction": {
	        "type": "integer"
	      },
	      "distanceToSubway": {
	        "type": "integer"
	      },
	      "subwayLineName": {
	        "type": "keyword"
	      },
	      "subwayStationName": {
	        "type": "keyword"
	      },
	      "tags": {
	        "type": "text"
	      },
	      "street": {
	        "type": "keyword"
	      },
	      "district": {
	        "type": "keyword"
	      },
	      "description": {
	        "type": "text",
	        "analyzer": "ik_smart",
	        "search_analyzer": "ik_smart"
	      },
	      "layoutDesc" : {
	        "type": "text",
	        "analyzer": "ik_smart",
	        "search_analyzer": "ik_smart"
	      },
	      "traffic": {
	        "type": "text",
	        "analyzer": "ik_smart",
	        "search_analyzer": "ik_smart"
	      },
	      "roundService": {
	        "type": "text",
	        "analyzer": "ik_smart",
	        "search_analyzer": "ik_smart"
	      },
	      "rentWay": {
	        "type": "integer"
	      },
	      "suggest": {
	        "type": "completion"
	      },
	      "location": {
	        "type": "geo_point"
	      }
	    }
	  }
	}

参数说明：

	number_of_replicas": 0  <!-- 副本数设置为0 -->


正确返回：

```
{
    "acknowledged": true,
    "shards_acknowledged": true,
    "index": "xunwu"
}
```

------

### 1.3 删除索引  (此步不需要执行)

请求方式：DELETE

请求地址：http://127.0.0.1:9202/article


正确返回：

```
{
    "acknowledged": true
}
```

------

### 1.4 将租房数据从mysql中同步到es（访问该接口即可）

请求方式：GET

请求地址：http://127.0.0.1:9205/rent/houseDataToEs

正确返回：

```
{
    "code": 200,
    "message": "OK",
    "data": "success",
    "more": false
}
```

------

### 