import axios from "axios";

export function request(config) {
  const instanse = axios.create({
    baseURL: "http://localhost:3000/",
    timeout: 1000,
  });

  return instanse(config);
}

// 登录信息
export function getLogin(data){
  return request({
    url: "/login",
    method: "post", 
    data,
  });
}

// 获取用户信息
export function getInfo(data){
  return request({
    url: '/getinfo',
    method: 'post',
    data
  })
}

// overview 数目总览
export function overview() {
  return request({
    url: "/overview",
  });
}

// 全部学生信息
export function selectallstudent(page) {
  return request({
    url: "/select/allstudent/" + page,
  });
}

// 全部学生成绩信息
export function selectallgrade(page) {
  return request({
    url: "/select/allgrade/" + page,
  });
}

// 全部学生体检信息
export function selectallsports(page) {
  return request({
    url: "/select/allsports/" + page,
  });
}

// 姓名查找
export function selectStuName(name, page) {
  return request({
    url: "/select/" + name + "/page/" + page,
  });
}

// 性别查找
export function selectStuSex(name, page) {
  return request({
    url: "/selectsex/" + name + "/page/" + page,
  });
}

// 学号查找
export function selectStuid(stuid, page) {
  return request({
    url: "/selectid/" + stuid + "/page/" + page,
  });
}

// 成绩——课程名字查找
export function selectStuCourseNameGra(name, page) {
  return request({
    url: "/selectcoursename/" + name + "/page/" + page,
  });
}

// 成绩——性别查找
export function selectStuSexGra(name, page) {
  return request({
    url: "/selectsexgra/" + name + "/page/" + page,
  });
}

// 成绩——姓名查找
export function selectStuNameGra(name, page) {
  return request({
    url: "/selectnamegra/" + name + "/page/" + page,
  });
}

// 成绩——学号查找
export function selectStuidGra(stuid, page) {
  return request({
    url: "/selectidgra/" + stuid + "/page/" + page,
  });
}

// 体检——学号查找
export function selectStuidSports(stuid, page) {
  return request({
    url: "/selectidsports/" + stuid + "/page/" + page,
  });
}

// 体检——姓名查找
export function selectStuNameSports(stuid, page) {
  return request({
    url: "/selectnamesports/" + stuid + "/page/" + page,
  });
}

// 体检——性别查找
export function selectStuSexSports(stuid, page) {
  return request({
    url: "/selectsexsports/" + stuid + "/page/" + page,
  });
}

// 学号查看违纪
export function selectPunish(stuid) {
  return request({
    url: "/selcetpunish/" + stuid,
  });
}

// 学号查看获奖
export function selectReward(stuid) {
  return request({
    url: "/selcetreward/" + stuid,
  });
}

// 查看班级人数
export function selectClassNuber() {
  return request({
    url: "/getclassnum",
  });
}

// 获取各省人数
export function selectProvince() {
  return request({
    url: "/getnative",
  });
}

// 获取奖励获取情况人数
export function selectRewardCount() {
  return request({
    url: "/getreward",
  });
}

// 获取处罚情况人数
export function selectPunishCount() {
  return request({
    url: "/getpunish",
  });
}

// 学籍改动情况
export function selectStatusChange() {
  return request({
    url: "/getchange",
  });
}

// 各班高数平均分
export function selectGradeAvg() {
  return request({
    url: "/getgradeavg",
  });
}

// 请求某学号是否已经存在
export function isExit(stuid) {
  return request({
    url: "/isexist/" + stuid,
  });
}

//isexist_sport
// 在sports中请求某学号是否已经存在
export function isExit_sports(stuid) {
  return request({
    url: "/isexist_sport/" + stuid,
  });
}

/**
 * stuStatus
 */
// 查找全部学生信息加学籍信息
export function selectallstudentstatus(page) {
  return request({
    url: "/select/allstudentstatus/" + page,
  });
}


// 提交修改学生信息
export function updateStuInfo(data){
  return request({
    url: '/update',
    method: 'post',
    data,
  })
}

// 提交修改学生奖惩信息
export function updateStuWR(data){
  return request({
    url: '/updatewr',
    method: 'post',
    data,
  })
}

// 提交删除学生信息
export function deleteStu(data){
  return request({
    url: '/delete',
    method: 'post',
    data,
  })
}

// 修改学生成绩信息
export function updateGra(data){
  return request({
    url: '/updategra',
    method: 'post',
    data,
  })
}

// 体测——提交删除学生信息
export function deleteStuSports(data){
  return request({
    url: '/deletesports',
    method: 'post',
    data,
  })
}

// 成绩——提交删除学生信息
export function deleteStuGrade(data){
  return request({
    url: '/deletegrade',
    method: 'post',
    data,
  })
}

// // 修改学生成绩信息
// export function updateGra(data){
//   return request({
//     url: '/updategra',
//     method: 'post',
//     data,
//   })
// }

/**
 * admin页面
 */

// 查找admin
export function admin(){
  return request({
    url: '/admin'
  })
}

// 提交添加学生信息
export function addStuInfo(data){
  console.log('add')
  return request({
    url: '/add',
    method: 'post',
    data,
  })
}

// 体测——提交添加学生信息
export function addStuInfoSports(data){
  console.log('addsports')
  return request({
    url: '/addsports',
    method: 'post',
    data,
  })
}

// 体测——提交修改学生信息
export function updateStuInfoSports(data){
  return request({
    url: '/updatesports',
    method: 'post',
    data,
  })
}

// 成绩——提交修改学生信息
export function updateStuInfoGrade(data){
  return request({
    url: '/updategra',
    method: 'post',
    data,
  })
}