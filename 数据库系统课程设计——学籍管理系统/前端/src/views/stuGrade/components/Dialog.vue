<template>
  <div> 
    <!-- 修改弹窗 -->
    <el-dialog
      :visible.sync="dialogEditVisible.value"
      @close="childClose3"
      @open="stuBaseDialogOpen"
      width="25%"
    >
      <el-form :model="stuBaseInfo" ref="stuBaseInfo" label-width="80px">
        <el-form-item
          label="学号"
          :rules="[
            { required: true, message: '请输入学号', trigger: 'blur' },
            {
              type: 'number',
              message: '请输入正确的学号',
              trigger: ['blur', 'change'],
            },
          ]"
        >
          <el-input v-model.number="stuBaseInfo.studentid" disabled></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="stuBaseInfo.name" disabled></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="resource">
          <el-radio-group v-model="stuBaseInfo.sex" disabled>
            <el-radio label="男">男</el-radio>
            <el-radio label="女">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="学院">
          <el-select
            v-model="stuBaseInfo.xueyuan"
            @visible-change="changeXueyuan"
            placeholder="请选择"
          >
            <el-option
              v-for="(item, index) in xueyuanOptions"
              :key="index"
              :label="item"
              :value="item" disabled
            >
            </el-option>
          </el-select>
          <!-- <el-input v-model="stuBaseInfo.xueyuan"></el-input> -->
        </el-form-item>

        <el-form-item label="班级">
          <el-select
            v-model="stuBaseInfo.classname"
            @visible-change="changeClass"
            placeholder="请选择"
          >
            <el-option
              v-for="(item, index) in classOptions"
              :key="index"
              :label="item"
              :value="item" disabled
            >
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="课程">
          <el-input v-model="stuBaseInfo.subject" disabled></el-input>
        </el-form-item>
        <el-form-item label="考试情况">
          <el-input v-model="stuBaseInfo.status"></el-input>
        </el-form-item>
        <el-form-item label="成绩">
          <el-input v-model="stuBaseInfo.grade"></el-input>
        </el-form-item>       

        <el-form-item>
          <el-button type="primary" @click="submitForm('stuBaseInfo')"
            >确认修改</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
  
  <script>
  import { isExit, updateStuInfo,newGra,updateStuInfoGrade } from "@/api/request";
  export default {
    name: "Dialog",
    data() {
      return {
        xueyuanOptions: [
          "计算机科学与工程学院",
          "艺术学院",
          "外国语学院",
          "信息与电气工程学院",
          "化学化工学院",
        ],
        classOptions: [],
        stuBaseInfo: {},
      };
    },
    props: {
      dialogTableVisible: {
        type: Object,
        default() {
          return {};
        },
      },
      dialogRewardVisible: {
        type: Object,
        default() {
          return {};
        },
      },
      dialogEditVisible: {
        type: Object,
        default() {
          return {};
        },
      },
      // 获奖，惩罚信息
      punishData: {
        type: Object,
        default() {
          return [];
        },
      },
      //  修改学生基本信息
      stuBaseInfo1: {
        type: Object,
        default() {
          return {};
        },
      },
      //用来选择是增加学生还是修改学生信息
      choose: {
         type: Boolean, 
     }
    },
    mounted() {},
  
    methods: {
      childClose1() {
        this.dialogTableVisible.value = false;
      },
      childClose2() {
        this.dialogRewardVisible.value = false;
      },
      childClose3() {
        this.dialogEditVisible.value = false;
      },
      handleClose(done) {
        this.$confirm("确认关闭？")
          .then(() => {
            done();
          })
          .catch(() => {});
      },
      // 更改学院时,返回二级专业班级选择框
      changeXueyuan() {
        if (this.stuBaseInfo.xueyuan === "计算机科学与工程学院") {
          this.classOptions = ["计算机科学与技术", "网络工程", "信息安全"];
        } else if (this.stuBaseInfo.xueyuan === "艺术学院") {
          this.classOptions = ["音乐与舞蹈学", "美术学", "设计学"];
        } else if (this.stuBaseInfo.xueyuan === "外国语学院") {
          this.classOptions = ["汉语国际教育", "日语", "翻译"];
        } else if (this.stuBaseInfo.xueyuan === "信息与电气工程学院") {
          this.classOptions = ["电气工程及其自动化", "电子信息工程", "通信工程"];
        } else {
          this.classOptions = ["应用化学", "化学工程与工艺", "环境工程"];
        }
        // 并将专业班级切换成所属学院
        this.stuBaseInfo.classname = this.classOptions[0];
      },
      // 修改班级
      changeClass() {
        if (this.stuBaseInfo.xueyuan === "计算机科学与工程学院") {
          this.classOptions = ["计算机科学与技术", "网络工程", "信息安全"];
        } else if (this.stuBaseInfo.xueyuan === "艺术学院") {
          this.classOptions = ["音乐与舞蹈学", "美术学", "设计学"];
        } else if (this.stuBaseInfo.xueyuan === "外国语学院") {
          this.classOptions = ["汉语国际教育", "日语", "翻译"];
        } else if (this.stuBaseInfo.xueyuan === "信息与电气工程学院") {
          this.classOptions = ["电气工程及其自动化", "电子信息工程", "通信工程"];
        } else {
          this.classOptions = ["应用化学", "化学工程与工艺", "环境工程"];
        }
      },
      // 提交修改
      submitForm(formName) {
        this.$refs[formName].validate(async (valid) => {
          if (valid) {
            // 判断学号是否 修改
            // 1. 未修改
            if (this.stuBaseInfo1.studentid === this.stuBaseInfo.studentid) {
              // 提交修改
              updateStuInfoGrade(this.stuBaseInfo)
                .then((res) => {
                  this.$message({ message: "修改成功", type: "success" });
                  this.childClose3();
                  return true;
                })
                .catch((err) => {
                  this.$message.error("修改失败!");
                  this.childClose3();
                  return true;
                });
            }
            // 2. 修改
            else {
              // 请求 判断学号是否已经在数据库存在
              let stuidExit = await isExit(this.stuBaseInfo.studentid);
              //
              if (stuidExit.data.length !== 0) {
                // console.log("error submit!!学号已经存在");
                this.$message({
                  message: "该学号在数据库中已存在",
                  type: "warning",
                });
                return false;
              } else {
                updateStuInfoGrade(this.stuBaseInfo)
                  .then((res) => {
                    this.$message({ message: "修改成功", type: "success" });
                    this.childClose3();
                    return true;
                  })
                  .catch((err) => {
                    this.$message.error("修改失败!");
                    this.childClose3();
                    return true;
                  });
              }
            }
            // console.log(this.stuBaseInfo);
          } else {
            console.log("error submit!!");
            return false;
          }
        });
      },
  
      // 弹窗被打开
      stuBaseDialogOpen() {
        this.stuBaseInfo = Object.assign({}, this.stuBaseInfo1);
      },
  
      /**
       * 请求部分
       */
      // 判断是否存在学号
      checkStuid(stuid) {
        isExit(stuid).then((res) => {
          if (res.data.length == 0) {
            return false;
          } else {
            return true;
          }
        });
      },
    },
  };
  </script>
  <style lang='scss' scoped>
  .dialog-stu {
    margin-bottom: 10px;
    font-size: 16px;
    span {
      display: inline-block;
    }
    .dia-item {
      margin-bottom: 10px;
    }
    .dia-title {
      margin-right: 15px;
      font-weight: 500;
      color: #909399;
    }
  }
  .dialog-table {
    font-size: 14px;
  }
  .dialog .el-dialog__body {
    padding: 10px 20px;
  }
  </style>