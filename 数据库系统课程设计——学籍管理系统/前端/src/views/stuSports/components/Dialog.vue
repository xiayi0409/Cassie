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
        <el-form-item label="性别" prop="resource" >
          <el-radio-group v-model="stuBaseInfo.sex" disabled>
            <el-radio label="男">男</el-radio>
            <el-radio label="女">女</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="身高/cm">
          <el-input v-model="stuBaseInfo.height"></el-input>
        </el-form-item>
        <el-form-item label="体重/kg">
          <el-input v-model="stuBaseInfo.weight"></el-input>
        </el-form-item>
        <el-form-item label="肺活量/ml">
          <el-input v-model="stuBaseInfo.vital"></el-input>
        </el-form-item>
        <el-form-item label="跳远/cm">
          <el-input v-model="stuBaseInfo.long"></el-input>
        </el-form-item>
        <el-form-item label="坐位体前屈/cm">
          <el-input v-model="stuBaseInfo.sitreach"></el-input>
        </el-form-item>
        <el-form-item label="1000米">
          <el-input v-model="stuBaseInfo.run1000"></el-input>
        </el-form-item>
        <el-form-item label="800米">
          <el-input v-model="stuBaseInfo.run800"></el-input>
        </el-form-item>
        <el-form-item label="仰卧起坐/个">
          <el-input v-model="stuBaseInfo.situp"></el-input>
        </el-form-item>
        <el-form-item label="引体向上/个">
          <el-input v-model="stuBaseInfo.pullup"></el-input>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submitForm('stuBaseInfo')"
            >确认修改</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>

    <el-dialog
      :visible.sync="dialogEditVisible01.value"
      @close="childClose4"
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
          <el-input v-model.number="stuBaseInfo.studentid"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="stuBaseInfo.name"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="resource" >
          <el-radio-group v-model="stuBaseInfo.sex">
            <el-radio label="男">男</el-radio>
            <el-radio label="女">女</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="身高/cm">
          <el-input v-model="stuBaseInfo.height"></el-input>
        </el-form-item>
        <el-form-item label="体重/kg">
          <el-input v-model="stuBaseInfo.weight"></el-input>
        </el-form-item>
        <el-form-item label="肺活量/ml">
          <el-input v-model="stuBaseInfo.vital"></el-input>
        </el-form-item>
        <el-form-item label="跳远/cm">
          <el-input v-model="stuBaseInfo.long"></el-input>
        </el-form-item>
        <el-form-item label="坐位体前屈/cm">
          <el-input v-model="stuBaseInfo.sitreach"></el-input>
        </el-form-item>
        <el-form-item label="1000米">
          <el-input v-model="stuBaseInfo.run1000"></el-input>
        </el-form-item>
        <el-form-item label="800米">
          <el-input v-model="stuBaseInfo.run800"></el-input>
        </el-form-item>
        <el-form-item label="仰卧起坐/个">
          <el-input v-model="stuBaseInfo.situp"></el-input>
        </el-form-item>
        <el-form-item label="引体向上/个">
          <el-input v-model="stuBaseInfo.pullup"></el-input>
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
import { isExit, updateStuInfo,addStuInfoSports,updateStuInfoSports ,isExit_sports} from "@/api/request";
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
    dialogEditVisible01: {
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
    childClose4() {
      this.dialogEditVisible01.value = false;
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
        if(this.choose==false){ //修改学生信息
         // console.log(this.choose);
          if (this.stuBaseInfo1.studentid === this.stuBaseInfo.studentid) {   
            //如果学号没有变         
           updateStuInfoSports(this.stuBaseInfo)
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
        else {
          //判断学号是否已经在数据库存在
          let stuidExit = await isExit_sports(this.stuBaseInfo.studentid);
          //
          if (stuidExit.data.length !== 0) {
           
            this.$message({
              message: "该学号在数据库中已存在",
              type: "warning",
            });
            return false;
          } else {
            updateStuInfoSports(this.stuBaseInfo)
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
          }else{//增加学生
            //跟修改学生信息的代码只有addStuInfo不一样

          // 判断学号是否已经在体测的数据库存在
          let stuidExit = await isExit_sports(this.stuBaseInfo.studentid);
          console.log(stuidExit.data)
           //判断学号是否已经在student的数据库存在
           let stuidExit2 = await isExit(this.stuBaseInfo.studentid);
           console.log(stuidExit2.data)
            if (stuidExit2.data.length == 0)
            {
              this.$message({
              message: "该学生不存在",
              type: "warning",
            });
            return false;
            }else
           if (stuidExit.data.length != 0) {
            // console.log("error submit!!学号已经存在");
            this.$message({
              message: "该学号信息已经存在",
              type: "warning",
            });
            return false;
          } else 
          {
            addStuInfoSports(this.stuBaseInfo)
              .then((res) => {
                this.$message({ message: "增加成功", type: "success" });
                this.childClose4();
                return true;
              })
              .catch((err) => {
                this.$message.error("增加失败!");
                this.childClose4();
                return true;
              });
          }
        //}
          }
      
         console.log(this.stuBaseInfo);
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

    // 判断是否存在学号
    checkStuid(stuid) {
      isExit_sports(stuid).then((res) => {
        if (res.data.length == 0) {
          return false;
        } else {
          return true;
        }
      });
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

