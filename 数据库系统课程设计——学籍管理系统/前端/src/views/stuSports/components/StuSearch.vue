<template>
    <div class="stusearch">
      <el-table :data="tableData" border>
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table-column prop="studentid" label="学号" width="100" align="center">
          </el-table-column>
          <el-table-column prop="name" label="姓名" width="80" align="center"> </el-table-column>
          <el-table-column prop="sex" label="性别" width="80" align="center">
          </el-table-column>
          <el-table-column prop="height" label="身高/cm" width="80" align="center">
          </el-table-column>
          <el-table-column prop="weight" label="体重/kg" width="80" align="center">
          </el-table-column>
          <el-table-column prop="vital" label="肺活量/ml" width="85" align="center">
          </el-table-column>
          <el-table-column prop="jump" label="跳远/cm" width="80" align="center">
          </el-table-column>
          <el-table-column prop="sitreach" label="坐位体前屈/cm" width="120" align="center">
          </el-table-column>
          <el-table-column prop="run1000" label="1000米" width="80" align="center">
          </el-table-column>
          <el-table-column prop="run800" label="800米" width="80" align="center">
          </el-table-column>
          <el-table-column prop="situp" label="仰卧起坐/个" width="100" align="center">
          </el-table-column>
          <el-table-column prop="pullup" label="引体向上/个" width="100" align="center">
          </el-table-column>

        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
              >修改</el-button
            >
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination">
        <el-pagination
          background
          layout="prev, pager, next"
          :total="pagiDataAll"
          style="margin: auto"
          @current-change="currentChange"
        >
        </el-pagination>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "StuSearch",
    data() {
      return {};
    },
  
    mounted() {},
  
    methods: {},
  };
  </script>
  <style lang='scss' scoped>
  </style>