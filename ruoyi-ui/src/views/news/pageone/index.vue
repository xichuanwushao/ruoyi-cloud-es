<template>
  <div class="app-container">
    <!-- 文章列表 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="文章标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入文章标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
<!--    <el-row :gutter="10" class="mb8">-->
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--          type="primary"-->
<!--          plain-->
<!--          icon="el-icon-plus"-->
<!--          size="mini"-->
<!--          @click="handleAdd"-->
<!--          v-hasPermi="['news:article:add']"-->
<!--        >新增</el-button>-->
<!--      </el-col>-->
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--          type="success"-->
<!--          plain-->
<!--          icon="el-icon-edit"-->
<!--          size="mini"-->
<!--          :disabled="single"-->
<!--          @click="handleUpdate"-->
<!--          v-hasPermi="['news:article:edit']"-->
<!--        >修改</el-button>-->
<!--      </el-col>-->
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--          type="danger"-->
<!--          plain-->
<!--          icon="el-icon-delete"-->
<!--          size="mini"-->
<!--          :disabled="multiple"-->
<!--          @click="handleDelete"-->
<!--          v-hasPermi="['news:article:remove']"-->
<!--        >删除</el-button>-->
<!--      </el-col>-->
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--          type="warning"-->
<!--          plain-->
<!--          icon="el-icon-download"-->
<!--          size="mini"-->
<!--          @click="handleExport"-->
<!--          v-hasPermi="['news:article:export']"-->
<!--        >导出</el-button>-->
<!--      </el-col>-->
<!--      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>-->
<!--    </el-row>-->

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="文章标题" align="center"  width="180">
        <template slot-scope="scope">
          <div v-if="scope.row.highlightTitle==null">
            <span v-html="scope.row.title"></span>
          </div>
          <div v-else>
            <span v-html="scope.row.highlightTitle"></span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="文章的创建时间" align="center" prop="publishTime" />
      <el-table-column label="封面图" align="center" prop="articleCover" width="100">
        <template slot-scope="scope">
          <image-preview :src="scope.row.articleCover" :width="50" :height="50"/>
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
    <el-dialog :title="title" :visible.sync="open" width="1000px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="文章标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入文章标题" />
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
import { eslistArticle,listArticle, getArticle, delArticle, addArticle, updateArticle } from "@/api/news/article";

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
      eslistArticle(this.queryParams).then(response => {
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
