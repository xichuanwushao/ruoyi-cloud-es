<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="文章标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入文章标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章所属分类id" prop="categoryId">
        <el-select v-model="queryParams.categoryId" placeholder="请选择文章所属分类id" clearable>
          <el-option
            v-for="dict in dict.type.chu_article_category"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="文章类型，1：图文" prop="articleType">
        <el-select v-model="queryParams.articleType" placeholder="请选择文章类型，1：图文" clearable>
          <el-option
            v-for="dict in dict.type.chu_article_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="文章封面图，article_type=1 的时候展示" prop="articleCover">
        <el-input
          v-model="queryParams.articleCover"
          placeholder="请输入文章封面图，article_type=1 的时候展示"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否是预约定时发布的文章，1：预约" prop="isAppoint">
        <el-input
          v-model="queryParams.isAppoint"
          placeholder="请输入是否是预约定时发布的文章，1：预约"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章状态，1：审核中" prop="articleStatus">
        <el-select v-model="queryParams.articleStatus" placeholder="请选择文章状态，1：审核中" clearable>
          <el-option
            v-for="dict in dict.type.chu_article_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="发布者用户id" prop="publishUserId">
        <el-input
          v-model="queryParams.publishUserId"
          placeholder="请输入发布者用户id"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章发布时间">
        <el-date-picker
          v-model="daterangePublishTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="用户累计点击阅读数" prop="readCounts">
        <el-input
          v-model="queryParams.readCounts"
          placeholder="请输入用户累计点击阅读数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒" prop="commentCounts">
        <el-input
          v-model="queryParams.commentCounts"
          placeholder="请输入文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="mongo图片id" prop="mongoFileId">
        <el-input
          v-model="queryParams.mongoFileId"
          placeholder="请输入mongo图片id"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="逻辑删除状态，非物理删除，1：删除，0：未删除" prop="isDelete">
        <el-input
          v-model="queryParams.isDelete"
          placeholder="请输入逻辑删除状态，非物理删除，1：删除，0：未删除"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章的创建时间">
        <el-date-picker
          v-model="daterangeCreateTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="文章的修改时间">
        <el-date-picker
          v-model="daterangeUpdateTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
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
          v-hasPermi="['news:article:add']"
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
          v-hasPermi="['news:article:edit']"
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
          v-hasPermi="['news:article:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['news:article:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="文章标题" align="center" prop="title" />
      <el-table-column label="文章内容，长度不超过9999，需要在前后端判断" align="center" prop="content" />
      <el-table-column label="文章所属分类id" align="center" prop="categoryId">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.chu_article_category" :value="scope.row.categoryId"/>
        </template>
      </el-table-column>
      <el-table-column label="文章类型，1：图文" align="center" prop="articleType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.chu_article_type" :value="scope.row.articleType"/>
        </template>
      </el-table-column>
      <el-table-column label="文章封面图，article_type=1 的时候展示" align="center" prop="articleCover" />
      <el-table-column label="是否是预约定时发布的文章，1：预约" align="center" prop="isAppoint">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.chu_is_appoint" :value="scope.row.isAppoint"/>
        </template>
      </el-table-column>
      <el-table-column label="文章状态，1：审核中" align="center" prop="articleStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.chu_article_status" :value="scope.row.articleStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="发布者用户id" align="center" prop="publishUserId" />
      <el-table-column label="文章发布时间" align="center" prop="publishTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="用户累计点击阅读数" align="center" prop="readCounts" />
      <el-table-column label="文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒" align="center" prop="commentCounts" />
      <el-table-column label="mongo图片id" align="center" prop="mongoFileId" />
      <el-table-column label="逻辑删除状态，非物理删除，1：删除，0：未删除" align="center" prop="isDelete" />
      <el-table-column label="文章的创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="文章的修改时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['news:article:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['news:article:remove']"
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

    <!-- 添加或修改文章资讯对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="文章标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入文章标题" />
        </el-form-item>
        <el-form-item label="文章内容，长度不超过9999，需要在前后端判断">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="文章所属分类id" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择文章所属分类id">
            <el-option
              v-for="dict in dict.type.chu_article_category"
              :key="dict.value"
              :label="dict.label"
:value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="文章类型，1：图文" prop="articleType">
          <el-select v-model="form.articleType" placeholder="请选择文章类型，1：图文">
            <el-option
              v-for="dict in dict.type.chu_article_type"
              :key="dict.value"
              :label="dict.label"
:value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="文章封面图，article_type=1 的时候展示" prop="articleCover">
          <el-input v-model="form.articleCover" placeholder="请输入文章封面图，article_type=1 的时候展示" />
        </el-form-item>
        <el-form-item label="是否是预约定时发布的文章，1：预约" prop="isAppoint">
          <el-input v-model="form.isAppoint" placeholder="请输入是否是预约定时发布的文章，1：预约" />
        </el-form-item>
        <el-form-item label="文章状态，1：审核中">
          <el-radio-group v-model="form.articleStatus">
            <el-radio
              v-for="dict in dict.type.chu_article_status"
              :key="dict.value"
:label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="发布者用户id" prop="publishUserId">
          <el-input v-model="form.publishUserId" placeholder="请输入发布者用户id" />
        </el-form-item>
        <el-form-item label="文章发布时间" prop="publishTime">
          <el-date-picker clearable
            v-model="form.publishTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择文章发布时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="用户累计点击阅读数" prop="readCounts">
          <el-input v-model="form.readCounts" placeholder="请输入用户累计点击阅读数" />
        </el-form-item>
        <el-form-item label="文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒" prop="commentCounts">
          <el-input v-model="form.commentCounts" placeholder="请输入文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒" />
        </el-form-item>
        <el-form-item label="mongo图片id" prop="mongoFileId">
          <el-input v-model="form.mongoFileId" placeholder="请输入mongo图片id" />
        </el-form-item>
        <el-form-item label="逻辑删除状态，非物理删除，1：删除，0：未删除" prop="isDelete">
          <el-input v-model="form.isDelete" placeholder="请输入逻辑删除状态，非物理删除，1：删除，0：未删除" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listArticle, getArticle, delArticle, addArticle, updateArticle } from "@/api/news/article";

export default {
  name: "Article",
  dicts: ['chu_article_category', 'chu_article_type', 'chu_article_status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 文章资讯表格数据
      articleList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 逻辑删除状态，非物理删除，1：删除，0：未删除时间范围
      daterangePublishTime: [],
      // 逻辑删除状态，非物理删除，1：删除，0：未删除时间范围
      daterangeCreateTime: [],
      // 逻辑删除状态，非物理删除，1：删除，0：未删除时间范围
      daterangeUpdateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: null,
        content: null,
        categoryId: null,
        articleType: null,
        articleCover: null,
        isAppoint: null,
        articleStatus: null,
        publishUserId: null,
        publishTime: null,
        readCounts: null,
        commentCounts: null,
        mongoFileId: null,
        isDelete: null,
        createTime: null,
        updateTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        title: [
          { required: true, message: "文章标题不能为空", trigger: "blur" }
        ],
        content: [
          { required: true, message: "文章内容，长度不超过9999，需要在前后端判断不能为空", trigger: "blur" }
        ],
        categoryId: [
          { required: true, message: "文章所属分类id不能为空", trigger: "change" }
        ],
        articleType: [
          { required: true, message: "文章类型，1：图文不能为空", trigger: "change" }
        ],
        isAppoint: [
          { required: true, message: "是否是预约定时发布的文章，1：预约不能为空", trigger: "blur" }
        ],
        articleStatus: [
          { required: true, message: "文章状态，1：审核中不能为空", trigger: "blur" }
        ],
        publishUserId: [
          { required: true, message: "发布者用户id不能为空", trigger: "blur" }
        ],
        publishTime: [
          { required: true, message: "文章发布时间不能为空", trigger: "blur" }
        ],
        readCounts: [
          { required: true, message: "用户累计点击阅读数不能为空", trigger: "blur" }
        ],
        commentCounts: [
          { required: true, message: "文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒不能为空", trigger: "blur" }
        ],
        isDelete: [
          { required: true, message: "逻辑删除状态，非物理删除，1：删除，0：未删除不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "文章的创建时间不能为空", trigger: "blur" }
        ],
        updateTime: [
          { required: true, message: "文章的修改时间不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询文章资讯列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangePublishTime && '' != this.daterangePublishTime) {
        this.queryParams.params["beginPublishTime"] = this.daterangePublishTime[0];
        this.queryParams.params["endPublishTime"] = this.daterangePublishTime[1];
      }
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0];
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1];
      }
      if (null != this.daterangeUpdateTime && '' != this.daterangeUpdateTime) {
        this.queryParams.params["beginUpdateTime"] = this.daterangeUpdateTime[0];
        this.queryParams.params["endUpdateTime"] = this.daterangeUpdateTime[1];
      }
      listArticle(this.queryParams).then(response => {
        this.articleList = response.rows;
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
        content: null,
        categoryId: null,
        articleType: null,
        articleCover: null,
        isAppoint: null,
        articleStatus: 0,
        publishUserId: null,
        publishTime: null,
        readCounts: null,
        commentCounts: null,
        mongoFileId: null,
        isDelete: null,
        createTime: null,
        updateTime: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangePublishTime = [];
      this.daterangeCreateTime = [];
      this.daterangeUpdateTime = [];
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
      this.title = "添加文章资讯";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getArticle(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改文章资讯";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateArticle(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addArticle(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除文章资讯编号为"' + ids + '"的数据项？').then(function() {
        return delArticle(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('news/article/export', {
        ...this.queryParams
      }, `article_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
