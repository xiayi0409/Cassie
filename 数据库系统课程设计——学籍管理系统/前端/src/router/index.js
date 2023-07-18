import Vue from 'vue'
import VueRouter from 'vue-router'

const Login = () => import("@/views/Login.vue");
import Layout from "@/layout";
Vue.use(VueRouter)

const routes = [
  {
    path: "/login",
    name: "Login",
    component: Login,
    hidden: true,
  },
  {
    path: "/404",
    name: "404",
    component: () => import("@/views/404"),
    hidden: true,
  },
  {
    path: "/",
    redirect: "/home",
    meta: { title: "首页", icon: "el-icon-s-home" },
    component: Layout,
    children: [
      {
        path: "/home",
        name: "home",
        meta: { title: "首页", icon: "" },
        component: () => import("../views/home"),
      },
    ],

    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    // component: () =>
    //   import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
  {
    path: "/student/manage",
    component: Layout,
    meta: { title: "学生管理", icon: "iconfont icon-yonghu" },
    children: [
      {
        path: "/student/manage",
        name: "manage",
        bgimgurl: "https://cdn.jsdelivr.net/gh/inkwall233/imgcdn/bg-1.jpg",
        meta: { title: "学生信息管理", icon: "iconfont icon-yonghu" },
        component: () => import("../views/stuManage"),
      },
      {
        path: "/student/status",
        name: "status",
        meta: { title: "学籍信息管理", icon: "iconfont icon-xuejiguanli" },
        component: () => import("../views/stuStatus"),
      },
      //新增
      {
        path: "/student/grade",
        name: "grade",
        meta: { title: "学生成绩管理", icon: "iconfont icon-yonghu" },
        component: () => import("../views/stuGrade"),
      },
      {
        path: "/student/sports",
        name: "sports",
        meta: { title: "学生体检情况管理", icon: "iconfont icon-yonghu" },
        component: () => import("../views/stuSports"),
      },

      {
        path: "/student/charts",
        name: "charts",
        meta: { title: "数据可视化", icon: "iconfont icon-tubiao" },
        component: () => import("../views/stuCharts"),
      },
    ],
  },
  {
    path: "/admin",
    
    meta: { isAuth:false,title: "管理员管理", icon: "el-icon-s-custom" },
    component: Layout,
    
    children: [
      {
        name: "admin",
        path: "/admin",
        meta: {
          title: "管理员",
          icon: "",
        },
        component: () => import("../views/admin"),
       
      },
    ],

    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    // component: () =>
    //   import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
