<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
<!--      <el-form-item label="价格" prop="price">-->
<!--        <el-input-->
<!--          v-model="queryParams.price"-->
<!--          placeholder="请输入价格"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="面积" prop="area">-->
<!--        <el-input-->
<!--          v-model="queryParams.area"-->
<!--          placeholder="请输入面积"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="卧室数量" prop="room">-->
<!--        <el-input-->
<!--          v-model="queryParams.room"-->
<!--          placeholder="请输入卧室数量"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="楼层" prop="floor">-->
<!--        <el-input-->
<!--          v-model="queryParams.floor"-->
<!--          placeholder="请输入楼层"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="总楼层" prop="totalFloor">-->
<!--        <el-input-->
<!--          v-model="queryParams.totalFloor"-->
<!--          placeholder="请输入总楼层"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="被看次数" prop="watchTimes">-->
<!--        <el-input-->
<!--          v-model="queryParams.watchTimes"-->
<!--          placeholder="请输入被看次数"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
      <el-form-item label="建立年限">
        <el-date-picker
          v-model="daterangeBuildYear"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="房屋状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择房屋状态 0-未审核 1-审核通过 2-已出租 3-逻辑删除" clearable>
          <el-option
            v-for="dict in dict.type.house_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
<!--      <el-form-item label="最近数据更新时间">-->
<!--        <el-date-picker-->
<!--          v-model="daterangeLastUpdateTime"-->
<!--          style="width: 240px"-->
<!--          value-format="yyyy-MM-dd"-->
<!--          type="daterange"-->
<!--          range-separator="-"-->
<!--          start-placeholder="开始日期"-->
<!--          end-placeholder="结束日期"-->
<!--        ></el-date-picker>-->
<!--      </el-form-item>-->
      <el-form-item label="城市" prop="cityEnName">
        <el-select v-model="queryParams.cityEnName" placeholder="请选择城市" clearable>
          <el-option
            v-for="dict in dict.type.city_en_name"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="地区" prop="regionEnName">
        <el-select v-model="queryParams.regionEnName" placeholder="请选择地区" clearable>
          <el-option
            v-for="dict in dict.type.region_en_name"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
<!--      <el-form-item label="封面" prop="cover">-->
<!--        <el-input-->
<!--          v-model="queryParams.cover"-->
<!--          placeholder="请输入封面"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
      <el-form-item label="房屋朝向" prop="direction">
        <el-select v-model="queryParams.direction" placeholder="请选择房屋朝向" clearable>
          <el-option
            v-for="dict in dict.type.direction"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
<!--      <el-form-item label="距地铁距离 默认-1 附近无地铁" prop="distanceToSubway">-->
<!--        <el-input-->
<!--          v-model="queryParams.distanceToSubway"-->
<!--          placeholder="请输入距地铁距离 默认-1 附近无地铁"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="客厅数量" prop="parlour">-->
<!--        <el-input-->
<!--          v-model="queryParams.parlour"-->
<!--          placeholder="请输入客厅数量"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="所在小区" prop="district">-->
<!--        <el-input-->
<!--          v-model="queryParams.district"-->
<!--          placeholder="请输入所在小区"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="所属管理员id" prop="adminId">-->
<!--        <el-input-->
<!--          v-model="queryParams.adminId"-->
<!--          placeholder="请输入所属管理员id"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="浴室数量" prop="bathroom">-->
<!--        <el-input-->
<!--          v-model="queryParams.bathroom"-->
<!--          placeholder="请输入浴室数量"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
<!--      <el-form-item label="街道" prop="street">-->
<!--        <el-input-->
<!--          v-model="queryParams.street"-->
<!--          placeholder="请输入街道"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
      <el-form-item label="房间标签" prop="houseTag">
        <el-select v-model="queryParams.houseTag" placeholder="请选择房间标签" clearable>
          <el-option
            v-for="dict in dict.type.house_tag"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['news:house:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['news:house:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['news:house:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['news:house:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="houseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
<!--      <el-table-column label="house唯一标识" align="center" prop="id" />-->
      <el-table-column
        type="index"
        label="序号"
        width="50"
        :index="(i) => (queryParams.pageNum - 1) * queryParams.pageSize + i + 1"
      />
      <el-table-column label="标题" align="center" prop="title" />
      <el-table-column label="价格" align="center" prop="price" />
      <el-table-column label="面积" align="center" prop="area" />
<!--      <el-table-column label="卧室数量" align="center" prop="room" />-->
<!--      <el-table-column label="楼层" align="center" prop="floor" />-->
<!--      <el-table-column label="总楼层" align="center" prop="totalFloor" />-->
      <el-table-column label="被看次数" align="center" prop="watchTimes" />
      <el-table-column label="建立年限" align="center" prop="buildYear" />
<!--      <el-table-column label="建立年限" align="center" prop="buildYear" width="180">-->
<!--        <template slot-scope="scope">-->
<!--          <span>{{ parseTime(scope.row.buildYear, '{y}-{m}-{d}') }}</span>-->
<!--        </template>-->
<!--      </el-table-column>-->
      <el-table-column label="房屋状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.house_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="lastUpdateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.lastUpdateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="城市" align="center" prop="cityEnName">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.city_en_name" :value="scope.row.cityEnName"/>
        </template>
      </el-table-column>
      <el-table-column label="地区" align="center" prop="regionEnName">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.region_en_name" :value="scope.row.regionEnName"/>
        </template>
      </el-table-column>
      <el-table-column label="封面" align="center" prop="cover" />
      <el-table-column label="房屋朝向" align="center" prop="direction">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.direction" :value="scope.row.direction"/>
        </template>
      </el-table-column>
<!--      <el-table-column label="地铁距离" align="center" prop="distanceToSubway" />-->
<!--      <el-table-column label="客厅数量" align="center" prop="parlour" />-->
      <el-table-column label="所在小区" align="center" prop="district" />
<!--      <el-table-column label="所属管理员id" align="center" prop="adminId" />-->
<!--      <el-table-column label="浴室数量" align="center" prop="bathroom" />-->
      <el-table-column label="街道" align="center" prop="street" />
<!--      <el-table-column label="房间图片" align="center" prop="housePicture" width="100">-->
<!--        <template slot-scope="scope">-->
<!--          <image-preview :src="scope.row.housePicture" :width="50" :height="50"/>-->
<!--        </template>-->
<!--      </el-table-column>-->
<!--      <el-table-column label="房间标签" align="center" prop="houseTag">-->
<!--        <template slot-scope="scope">-->
<!--          <dict-tag :options="dict.type.house_tag" :value="scope.row.houseTag"/>-->
<!--        </template>-->
<!--      </el-table-column>-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['news:house:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['news:house:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改房屋信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input v-model="form.price" placeholder="请输入价格" />
        </el-form-item>
        <el-form-item label="面积" prop="area">
          <el-input v-model="form.area" placeholder="请输入面积" />
        </el-form-item>
        <el-form-item label="卧室数量" prop="room">
          <el-input v-model="form.room" placeholder="请输入卧室数量" />
        </el-form-item>
        <el-form-item label="楼层" prop="floor">
          <el-input v-model="form.floor" placeholder="请输入楼层" />
        </el-form-item>
        <el-form-item label="总楼层" prop="totalFloor">
          <el-input v-model="form.totalFloor" placeholder="请输入总楼层" />
        </el-form-item>
        <el-form-item label="被看次数" prop="watchTimes">
          <el-input v-model="form.watchTimes" placeholder="请输入被看次数" />
        </el-form-item>
        <el-form-item label="建立年限" prop="buildYear">
          <el-input v-model="form.buildYear" placeholder="请输入建立年限" />
        </el-form-item>
<!--        <el-form-item label="建立年限" prop="buildYear">-->
<!--          <el-date-picker clearable-->
<!--            v-model="form.buildYear"-->
<!--            type="date"-->
<!--            value-format="yyyy-MM-dd"-->
<!--            placeholder="请选择建立年限">-->
<!--          </el-date-picker>-->
<!--        </el-form-item>-->
        <el-form-item label="房屋状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择房屋状态">
            <el-option
              v-for="dict in dict.type.house_status"
              :key="dict.value"
              :label="dict.label"
:value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="更新时间" prop="lastUpdateTime">
          <el-date-picker clearable
            v-model="form.lastUpdateTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择更新时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="城市" prop="cityEnName">
          <el-select v-model="form.cityEnName" placeholder="请选择城市">
            <el-option
              v-for="dict in dict.type.city_en_name"
              :key="dict.value"
              :label="dict.label"
:value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="地区" prop="regionEnName">
          <el-select v-model="form.regionEnName" placeholder="请选择地区">
            <el-option
              v-for="dict in dict.type.region_en_name"
              :key="dict.value"
              :label="dict.label"
:value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="封面" prop="cover">
          <el-input v-model="form.cover" placeholder="请输入封面" />
        </el-form-item>
        <el-form-item label="房屋朝向" prop="direction">
          <el-select v-model="form.direction" placeholder="请选择房屋朝向">
            <el-option
              v-for="dict in dict.type.direction"
              :key="dict.value"
              :label="dict.label"
:value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="地铁距离" prop="distanceToSubway">
          <el-input v-model="form.distanceToSubway" placeholder="请输入地铁距离" />
        </el-form-item>
        <el-form-item label="客厅数量" prop="parlour">
          <el-input v-model="form.parlour" placeholder="请输入客厅数量" />
        </el-form-item>
        <el-form-item label="所在小区" prop="district">
          <el-input v-model="form.district" placeholder="请输入所在小区" />
        </el-form-item>
<!--        <el-form-item label="管理员" prop="adminId">-->
<!--          <el-input v-model="form.adminId" placeholder="请输入管理员" />-->
<!--        </el-form-item>-->
        <el-form-item label="浴室数量" prop="bathroom">
          <el-input v-model="form.bathroom" placeholder="请输入浴室数量" />
        </el-form-item>
        <el-form-item label="街道" prop="street">
          <el-input v-model="form.street" placeholder="请输入街道" />
        </el-form-item>
        <el-form-item label="房间图片">
          <image-upload v-model="form.housePicture"/>
        </el-form-item>
        <el-form-item label="房间标签" prop="houseTag">
          <el-select v-model="form.houseTag" placeholder="请选择房间标签">
            <el-option
              v-for="dict in dict.type.house_tag"
              :key="dict.value"
              :label="dict.label"
:value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-divider content-position="center">交通出行信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddHouseDetail">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteHouseDetail">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="houseDetailList" :row-class-name="rowHouseDetailIndex" @selection-change="handleHouseDetailSelectionChange" ref="houseDetail">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="详细描述" prop="description" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.description" placeholder="请输入详细描述" />
            </template>
          </el-table-column>
          <el-table-column label="户型介绍" prop="layoutDesc" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.layoutDesc" placeholder="请输入户型介绍" />
            </template>
          </el-table-column>
          <el-table-column label="交通出行" prop="traffic" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.traffic" placeholder="请输入交通出行" />
            </template>
          </el-table-column>
          <el-table-column label="周边配套" prop="roundService" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.roundService" placeholder="请输入周边配套" />
            </template>
          </el-table-column>
          <el-table-column label="租赁方式" prop="rentWay" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.rentWay" placeholder="请选择租赁方式">
                <el-option
                  v-for="dict in dict.type.rent_way"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="详细地址 " prop="address" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.address" placeholder="请输入详细地址 " />
            </template>
          </el-table-column>
          <el-table-column label="附近地铁线id" prop="subwayLineId" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.subwayLineId" placeholder="请选择附近地铁线id">
                <el-option
                  v-for="dict in dict.type.subway_line_id"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="附近地铁线名称" prop="subwayLineName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.subwayLineName" placeholder="请输入附近地铁线名称" />
            </template>
          </el-table-column>
          <el-table-column label="地铁站id" prop="subwayStationId" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.subwayStationId" placeholder="请选择地铁站id">
                <el-option
                  v-for="dict in dict.type.subway_station_id"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="地铁站名" prop="subwayStationName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.subwayStationName" placeholder="请输入地铁站名" />
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listHouse, getHouse, delHouse, addHouse, updateHouse } from "@/api/news/house";

export default {
  name: "House",
  dicts: ['house_status', 'rent_way', 'region_en_name', 'direction', 'city_en_name', 'house_tag', 'subway_line_id', 'subway_station_id'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedHouseDetail: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 房屋信息表格数据
      houseList: [],
      // 交通出行表格数据
      houseDetailList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 对应house的id时间范围
      daterangeBuildYear: [],
      // 对应house的id时间范围
      daterangeCreateTime: [],
      // 对应house的id时间范围
      daterangeLastUpdateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: null,
        price: null,
        area: null,
        room: null,
        floor: null,
        totalFloor: null,
        watchTimes: null,
        buildYear: null,
        status: null,
        lastUpdateTime: null,
        cityEnName: null,
        regionEnName: null,
        cover: null,
        direction: null,
        distanceToSubway: null,
        parlour: null,
        district: null,
        adminId: null,
        bathroom: null,
        street: null,
        housePicture: null,
        houseTag: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        title: [
          { required: true, message: "标题不能为空", trigger: "blur" }
        ],
        price: [
          { required: true, message: "价格不能为空", trigger: "blur" }
        ],
        area: [
          { required: true, message: "面积不能为空", trigger: "blur" }
        ],
        room: [
          { required: true, message: "卧室数量不能为空", trigger: "blur" }
        ],
        floor: [
          { required: true, message: "楼层不能为空", trigger: "blur" }
        ],
        totalFloor: [
          { required: true, message: "总楼层不能为空", trigger: "blur" }
        ],
        buildYear: [
          { required: true, message: "建立年限不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "房屋状态 0-未审核 1-审核通过 2-已出租 3-逻辑删除不能为空", trigger: "change" }
        ],
        createTime: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
        lastUpdateTime: [
          { required: true, message: "最近数据更新时间不能为空", trigger: "blur" }
        ],
        cityEnName: [
          { required: true, message: "城市标记缩写 如 北京bj不能为空", trigger: "change" }
        ],
        regionEnName: [
          { required: true, message: "地区英文简写 如昌平区 cpq不能为空", trigger: "change" }
        ],
        direction: [
          { required: true, message: "房屋朝向不能为空", trigger: "change" }
        ],
        distanceToSubway: [
          { required: true, message: "距地铁距离 默认-1 附近无地铁不能为空", trigger: "blur" }
        ],
        parlour: [
          { required: true, message: "客厅数量不能为空", trigger: "blur" }
        ],
        district: [
          { required: true, message: "所在小区不能为空", trigger: "blur" }
        ],
        adminId: [
          { required: true, message: "所属管理员id不能为空", trigger: "blur" }
        ],
        bathroom: [
          { required: true, message: "浴室数量不能为空", trigger: "blur" }
        ],
        street: [
          { required: true, message: "街道不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询房屋信息列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeBuildYear && '' != this.daterangeBuildYear) {
        this.queryParams.params["beginBuildYear"] = this.daterangeBuildYear[0];
        this.queryParams.params["endBuildYear"] = this.daterangeBuildYear[1];
      }
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0];
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1];
      }
      if (null != this.daterangeLastUpdateTime && '' != this.daterangeLastUpdateTime) {
        this.queryParams.params["beginLastUpdateTime"] = this.daterangeLastUpdateTime[0];
        this.queryParams.params["endLastUpdateTime"] = this.daterangeLastUpdateTime[1];
      }
      listHouse(this.queryParams).then(response => {
        this.houseList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        title: null,
        price: null,
        area: null,
        room: null,
        floor: null,
        totalFloor: null,
        watchTimes: null,
        buildYear: null,
        status: null,
        createTime: null,
        lastUpdateTime: null,
        cityEnName: null,
        regionEnName: null,
        cover: null,
        direction: null,
        distanceToSubway: null,
        parlour: null,
        district: null,
        adminId: null,
        bathroom: null,
        street: null,
        housePicture: null,
        houseTag: null
      };
      this.houseDetailList = [];
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangeBuildYear = [];
      this.daterangeCreateTime = [];
      this.daterangeLastUpdateTime = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加房屋信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getHouse(id).then(response => {
        this.form = response.data;
        this.houseDetailList = response.data.houseDetailList;
        this.open = true;
        this.title = "修改房屋信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.houseDetailList = this.houseDetailList;
          if (this.form.id != null) {
            updateHouse(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addHouse(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除房屋信息编号为"' + ids + '"的数据项？').then(function() {
        return delHouse(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
	/** 交通出行序号 */
    rowHouseDetailIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 交通出行添加按钮操作 */
    handleAddHouseDetail() {
      let obj = {};
      obj.description = "";
      obj.layoutDesc = "";
      obj.traffic = "";
      obj.roundService = "";
      obj.rentWay = "";
      obj.address = "";
      obj.subwayLineId = "";
      obj.subwayLineName = "";
      obj.subwayStationId = "";
      obj.subwayStationName = "";
      this.houseDetailList.push(obj);
    },
    /** 交通出行删除按钮操作 */
    handleDeleteHouseDetail() {
      if (this.checkedHouseDetail.length == 0) {
        this.$modal.msgError("请先选择要删除的交通出行数据");
      } else {
        const houseDetailList = this.houseDetailList;
        const checkedHouseDetail = this.checkedHouseDetail;
        this.houseDetailList = houseDetailList.filter(function(item) {
          return checkedHouseDetail.indexOf(item.index) == -1
        });
      }
    },
    /** 复选框选中数据 */
    handleHouseDetailSelectionChange(selection) {
      this.checkedHouseDetail = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('news/house/export', {
        ...this.queryParams
      }, `house_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
