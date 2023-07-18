<template>
  <div class="stu-detail">
    <Search @searchData="getSearchData" class="container_wrap"></Search>
    <div class="container_wrap">
      <div class="batchOption">
        <!-- <el-button icon="el-icon-plus" type="success" @click="newAdd($event)" v-show="this.$store.state.username === '管理员'"
          >成绩录入</el-button
        > -->
        <el-button
          icon="el-icon-delete"
          type="danger"
          @click="batchDelete($event)" v-show="this.$store.state.username === '管理员'"
          >删除选中</el-button
        >
        <el-button
          icon="el-icon-refresh"
          type="warning"
          @click="refresh($event)"
          >刷新成绩表</el-button
        >
      </div>

      <el-table
        :data="tableData"
        border
        class=""
        @selection-change="handleCurrentChange"
      >
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table-column prop="studentid" label="学号" width="100">
        </el-table-column>
        <el-table-column prop="name" label="姓名" width="80"> </el-table-column>
        <el-table-column prop="sex" label="性别" width="80" align="center">
        </el-table-column>
        <el-table-column prop="xueyuan" label="学院" width="180">
        </el-table-column>
        <el-table-column prop="classname" label="专业" width="150">
        </el-table-column>
        <el-table-column prop="subject" width="80" label="课程">
        </el-table-column>
        <el-table-column prop="class" width="80" label="学分">
        </el-table-column>
        <el-table-column prop="status" width="80" label="考试情况">
        </el-table-column>
        <el-table-column prop="grade" width="80" label="成绩">
        </el-table-column>
        
        <el-table-column label="操作" v-if="this.$store.state.username === '管理员'">
          <template slot-scope="scope">
            <el-button
              size="mini"
              icon="el-icon-edit"
              @click="handleEdit(scope.$index, scope.row)"
              >修改</el-button
            >
            <el-button
              size="mini"
              type="danger"
              icon="el-icon-delete"
              @click="handleDelete(scope.$index, scope.row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="pagination">
      <Pagination
        :pageCount="pagiDataAll"
        @cpnPageJumpTo="currentChange"
      ></Pagination>
    </div>

    <!-- 弹窗 -->
    <Dialog
      :dialogTableVisible="dialogTableVisible"
      :dialogRewardVisible="dialogRewardVisible"
      :dialogEditVisible="dialogEditVisible"
      :punishData="punishData"
      :stuBaseInfo1="stuBaseInfo"
    ></Dialog>
  </div>
</template>

<script>
import {
  // selectallstudent,
  selectallgrade,
  selectStuNameGra,
  selectStuidGra,
  //deleteStu,
  deleteStuGrade,
  selectStuCourseNameGra,
  selectStuSexGra,
} from "@/api/request";
import Search from "@/components/search/Search.vue";
import Pagination from "@/components/pagination";

import Dialog from "./Dialog.vue";
export default {
  name: "Studetail",
  components: {
    Search,
    Pagination,
    Dialog,
  },
  created() {
    // 获取第0页学生信息
    this.getStudentGra();
  },
  data() {
    return {
      tableData: [],
      pagiDataAll: 0,
      // 设置flg，stu表示数据来源当前页面，name表示来自子组件searchname
      currentpage: "stu",
      searchName: "",
      // 弹窗
      dialogTableVisible: { value: false },
      dialogRewardVisible: { value: false },
      dialogEditVisible: { value: false },
      // punishData
      punishData: {},
      // 当前行学生信息
      stuBaseInfo: {},
      // 选中的项
      selectedData: [],
    };
  },

  mounted() {
    // console.log(this.tableData);
  },
  computed: {
    getpagiDataAll() {
      return this.pagiDataAll;
    },
  },
  methods: {
    /**
     * 数据请求
     */
    // 2.请求搜索name
    getselectStuNameGra(name, page = 0) {
      selectStuNameGra(name, page).then((res) => {
        this.pagiDataAll = res.data.pageAll;
        console.log(res);
        let result = res.data.data;

        // 清空数组
        this.tableData.splice(0);
        this.tableData.push(...result);
      });
    },

    // 3.请求搜索id
    getselectStuidGra(stuid, page = 0) {
      selectStuidGra(stuid, page).then((res) => {
        this.pagiDataAll = res.data.pageAll;
        // console.log(res);
        let result = res.data.data;

        // 清空数组
        this.tableData.splice(0);
        this.tableData.push(...result);
      });
    },
    
    // 4.请求搜索课程名
    getselectStuCourseNameGra(name, page = 0) {
      selectStuCourseNameGra(name, page).then((res) => {
        this.pagiDataAll = res.data.pageAll;
        // console.log(res);
        let result = res.data.data;

        // 清空数组
        this.tableData.splice(0);
        this.tableData.push(...result);
      });
    },
    
    // 4.请求搜索性别
    getselectStuSexGra(name, page = 0) {
      selectStuSexGra(name, page).then((res) => {
        this.pagiDataAll = res.data.pageAll;
        // console.log(res);
        let result = res.data.data;

        // 清空数组
        this.tableData.splice(0);
        this.tableData.push(...result);
      });
    },

    // 5.获取学生成绩信息
    getStudentGra(page = 0) {
      // 请求
      selectallgrade(page).then((res) => {
        this.pagiDataAll = res.data.pageAll;
        // console.log(res);
        let result = res.data.data;

        // 过滤属性值为null的
        // this.resFilter(result);
        // 清空数组
        this.tableData.splice(0);
        this.tableData.push(...result);
      });
    },

    /**
     * 操作
     */

    // 分页跳转，获取学生信息
    currentChange(item) {
      // stu页面
      if (this.currentpage === "name") {
        this.getselectStuNameGra(this.searchName, item - 1);
      }
      if (this.currentpage === "studentid") {
        this.getselectStuidGra(this.searchName, item - 1);
      }
      if (this.currentpage === "subject") {
        this.getselectStuCourseNameGra(this.searchName, item - 1);
      }
      
      if (this.currentpage === "sex") {
        this.getselectStuSexGra(this.searchName, item - 1);
      }
      //增加
      if (this.currentpage === "stu") {
        this.getStudentGra(item - 1);
      }
    },
    // 获取search组件发送的要查找数据
    getSearchData(searchData) {
      console.log(searchData);
      this.searchName = searchData.content;
      // 修改页面flg
      this.currentpage = searchData.type;
      // 修改此页内容
      // 1.姓名查询
      if (this.currentpage === "name") {
        this.getselectStuNameGra(this.searchName);
      }
      // 2.学号查询
      if (this.currentpage === "studentid") {
        this.getselectStuidGra(this.searchName);
      }
      // 3.课程名查询
      if (this.currentpage === "subject") {
        this.getselectStuCourseNameGra(this.searchName);
      }
      
      // 4.性别查询
      if (this.currentpage === "sex") {
        this.getselectStuSexGra(this.searchName);
      }
    },
  

    // 3.弹窗修改
    handleEdit(index, row) {
      console.log(row);
      this.stuBaseInfo = row;
      this.dialogEditVisible.value = true;
    },

    // 删除学生信息
    handleDelete(index, row) {
      this.$confirm("确认删除？")
        .then(() => {
          console.log(index, row);
          deleteStuGrade(row)
            .then(() => {
              this.$message({
                type: "success",
                message: "删除成功!",
              });
            })
            .catch((err) => {
              this.$message.error("删除失败!");
            });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    
    handleCurrentChange(rows) {
      console.log(rows);
      //将选中赋值到回显和传参数组
      // this.templateRadio = rows;
      this.selectedData = [];
      if (rows) {
        rows.forEach((row) => {
          if (row) {
            this.selectedData.push(row);
          }
        });
      }
    },
    // 新增添加
    newAdd(event) {
      this.lostBlur(event);
      this.handleEdit();
    },
    // 全选删除
    batchDelete(event) {
      this.lostBlur(event);
      this.$confirm("确认删除选中？")
        .then(() => {
          this.selectedData.forEach(async (item, index) => {
            await deleteStuGrade(item);
            this.$message({
              type: "info",
              message: "第" + index + 1 + "条记录，删除成功!",
            });
          });
          this.$message({
            type: "success",
            message: "全部删除成功!",
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除选中",
          });
        });
    },
    refresh(event) {
      this.lostBlur(event);
      this.getStudentGra();
    },
    // element button自动失焦
    lostBlur(event) {
      let target = event.target;
      if (target.nodeName == "SPAN") {
        target = event.target.parentNode;
      }
      target.blur();
    },
  },
};
</script>
<style lang='scss' scoped>
.batchOption {
  margin-bottom: 5px;
  .el-button {
    font-size: 10px;
    padding: 5px;
  }
}
.pagination {
  text-align: center;
  margin-top: 15px;
}
.name-wrapper {
  .el-tag {
    cursor: pointer;
  }
}
</style>