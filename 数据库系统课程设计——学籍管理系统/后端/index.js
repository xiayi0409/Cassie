let express = require("express");
var bodyParser = require('body-parser');

let sqlQuery = require("./dbmysql");

let app = express();


// create application/json parser
var jsonParser = bodyParser.json()
 
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false })

// 解决跨域
app.all("*", function(req, res, next) {
	// 设置允许跨域的域名，*代表允许任意域名跨域
	res.header("Access-Control-Allow-Origin", "*");
	// 允许的header类型
	res.header("Access-Control-Allow-Headers", "content-type");
	// 跨域允许的请求方式
	res.header("Access-Control-Allow-Methods", "DELETE,PUT,POST,GET,OPTIONS");
	if (req.method.toLowerCase() === "options") {
		res.sendStatus(200); // 让options尝试请求快速结束
	} else {
		next();
	}
});

// 登录
app.post("/login",jsonParser,async(req,res) => {
	let sql = `select * from admin where username = ? and passwd = ? `
	let arr = []
	arr[0] = req.body.username
	arr[1] = req.body.pass
	
	let result =await sqlQuery(sql,arr);
	if(result.length>0){
		res.json({
			message: '登录成功！',
			code: 1000,
			token: result[0].token,
			
			
		})
	}else{
		res.json({
			message: '账户或密码错误！',
			code: 2000
		})
	}
})

// 获取用户信息
app.post('/getinfo',jsonParser,async(req,res) => {
	let sql = `select * from admin where token = ? `
	let arr = []
	arr[0] = req.body.token
	let result =await sqlQuery(sql,arr);
	if(result.length>0){
		res.json({
			nickname: result[0].nickname,
			avatar: result[0].avatar,
			position: result[0].position
		})
	}else{
		res.json({
			message: '账户或密码错误！',
		})
	}
})

// 获取全部学生信息
app.get("/select/allstudent/:page", async (req, res) => {
	// 获取总页数
	let strSql0 = "select count(*) as pagenum from student;";
	let result = await sqlQuery(strSql0);
	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	// console.log(currentPage*itemPerPage +"," +(currentPage+1)*itemPerPage +" ;")
	// 获取学生详细信息
	let strSql1 = `SELECT ` +
		`student.studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`birthday, ` +
		`native_place, ` +
		`class.NAME AS classname, ` +
		`department.NAME AS xueyuan,` +
		`GROUP_CONCAT( punishment.DESCRIPTION ) AS punishstatus, ` +
		`GROUP_CONCAT( reward.DESCRIPTION ) AS rewardstatus ` +
		`FROM ` +
		`student ` +
		`INNER JOIN class ON ( student.class = class.id ) ` +
		`INNER JOIN department ON ( student.department = department.id ) ` +
		`LEFT JOIN punishment ON ( student.studentid = punishment.studentid ) ` +
		`LEFT JOIN reward ON ( student.studentid = reward.STUDENTID ) ` +
		`GROUP BY ` +
		`student.STUDENTID ` +
		`ORDER BY ` +
		`student.STUDENTID ` +
		`LIMIT ` +
		currentPage * itemPerPage +
		"," +
		itemPerPage +
		" ;";
	let result1 = await sqlQuery(strSql1);
	res.json({
		data: Array.from(result1),
		pageAll
	});
});

// 增加
// 获取全部学生成绩
app.get("/select/allgrade/:page", async (req, res) => {
	// 获取总页数
	// 获取总页数
	let strSql0 = "select count(*) as pagenum from grade;";
	let result = await sqlQuery(strSql0);
	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	// console.log(currentPage*itemPerPage +"," +(currentPage+1)*itemPerPage +" ;")
	// 获取学生详细信息  成绩
	let strSql1 = `SELECT ` +
		`student.studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`department.NAME AS xueyuan,` +
		`class.NAME AS classname, ` +
		`course.coursename AS subject,` +
		`course.class AS class,` +
		`status,` +
		`grade ` +
		`FROM ` +
		`grade ` +
		`INNER JOIN student ON ( student.studentid = grade.studentid ) ` +
		`INNER JOIN course ON ( course.courseid = grade.courseid ) ` +
		`INNER JOIN class ON ( student.class = class.id ) ` +
		`INNER JOIN department ON ( student.department = department.id ) ` +
		`LIMIT ` +
		currentPage * itemPerPage +
		"," +
		itemPerPage +
		" ;";
	let result1 = await sqlQuery(strSql1);
	res.json({
		data: Array.from(result1),
		pageAll
	});
});

// 获取全部学生体检信息
app.get("/select/allsports/:page", async (req, res) => {
	// 获取总页数
	let strSql0 = "select count(*) as pagenum from sports;";
	let result = await sqlQuery(strSql0);
	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	// console.log(currentPage*itemPerPage +"," +(currentPage+1)*itemPerPage +" ;")
	// 获取学生详细信息  体检
	let strSql1 = `SELECT ` +
		`student.studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`height, ` +
		`weight, ` +
		`vital, ` +
		`jump,` +
		`sitreach, ` +
		`run1000, ` +
		`run800, ` +
		`situp, ` +
		`pullup ` +
		`FROM ` +
		`sports ` +
		`INNER JOIN student ON ( student.studentid = sports.studentid ) ` +
		`LIMIT ` +
		currentPage * itemPerPage +
		"," +
		itemPerPage +
		" ;";
	let result1 = await sqlQuery(strSql1);
	res.json({
		data: Array.from(result1),
		pageAll
	});
});

// 搜索框查找 查找性别
app.get("/selectsex/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
		"select count(*) as pagenum from student where (sex like '%" +
		req.params.stuname +
		"%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`birthday, ` +
			`native_place, ` +
			`class.NAME AS classname, ` +
			`department.NAME AS xueyuan,` +
			`GROUP_CONCAT( punishment.DESCRIPTION ) AS punishstatus, ` +
			`GROUP_CONCAT( reward.DESCRIPTION ) AS rewardstatus ` +
			`FROM ` +
			`student ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`LEFT JOIN punishment ON ( student.studentid = punishment.studentid ) ` +
			`LEFT JOIN reward ON ( student.studentid = reward.STUDENTID ) ` +
			`WHERE student.sex like '%` + req.params.stuname + `%'` +
			`GROUP BY ` +
			`student.STUDENTID ` +
			`ORDER BY ` +
			`student.STUDENTID ` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 搜索框查找 查找姓名
app.get("/select/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
		"select count(*) as pagenum from student where (name like '%" +
		req.params.stuname +
		"%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`birthday, ` +
			`native_place, ` +
			`class.NAME AS classname, ` +
			`department.NAME AS xueyuan,` +
			`GROUP_CONCAT( punishment.DESCRIPTION ) AS punishstatus, ` +
			`GROUP_CONCAT( reward.DESCRIPTION ) AS rewardstatus ` +
			`FROM ` +
			`student ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`LEFT JOIN punishment ON ( student.studentid = punishment.studentid ) ` +
			`LEFT JOIN reward ON ( student.studentid = reward.STUDENTID ) ` +
			`WHERE student.name like '%` + req.params.stuname + `%'` +
			`GROUP BY ` +
			`student.STUDENTID ` +
			`ORDER BY ` +
			`student.STUDENTID ` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 搜索，学号搜索
app.get("/selectid/:stuid/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);

	// 获取总页数
	let strSql0 =
		"select count(*) as pagenum from student where (studentid like '%" +
		req.params.stuid +
		"%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`birthday, ` +
			`native_place, ` +
			`class.NAME AS classname, ` +
			`department.NAME AS xueyuan,` +
			`GROUP_CONCAT( punishment.DESCRIPTION ) AS punishstatus, ` +
			`GROUP_CONCAT( reward.DESCRIPTION ) AS rewardstatus ` +
			`FROM ` +
			`student ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`LEFT JOIN punishment ON ( student.studentid = punishment.studentid ) ` +
			`LEFT JOIN reward ON ( student.studentid = reward.STUDENTID ) ` +
			`WHERE student.studentid like '%` + req.params.stuid + `%'` +
			`GROUP BY ` +
			`student.STUDENTID ` +
			`ORDER BY ` +
			`student.STUDENTID ` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 成绩——搜索框查找 查找课程名
app.get("/selectcoursename/:stuname/page/:page", async (req, res) => {
	let strSql0 =
	  "SELECT COUNT(*) AS pagenum FROM grade, course WHERE (course.courseid = grade.courseid AND course.coursename LIKE '%" +
	  req.params.stuname +
	  "%')";
	
	let result1 = await sqlQuery(strSql0);
  
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page);
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`department.NAME AS xueyuan,` +
			`class.NAME AS classname, ` +
			`course.coursename AS subject,` +
			`course.class AS class,` +
			`status,` +
			`grade ` +
			`FROM ` +
			`grade ` +
			`INNER JOIN student ON ( student.studentid = grade.studentid ) ` +
			`INNER JOIN course ON ( course.courseid = grade.courseid ) ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`WHERE course.coursename like '%` + req.params.stuname + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
  });

// 成绩——搜索框查找 查找性别
app.get("/selectsexgra/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
	  "SELECT COUNT(*) AS pagenum FROM grade, student WHERE (student.studentid = grade.studentid AND student.sex LIKE '%" +
	  req.params.stuname +
	  "%')";
	
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`department.NAME AS xueyuan,` +
			`class.NAME AS classname, ` +
			`course.coursename AS subject,` +
			`course.class AS class,` +
			`status,` +
			`grade ` +
			`FROM ` +
			`grade ` +
			`INNER JOIN student ON ( student.studentid = grade.studentid ) ` +
			`INNER JOIN course ON ( course.courseid = grade.courseid ) ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`WHERE student.sex like '%` + req.params.stuname + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});


// 成绩——搜索框查找 查找姓名
app.get("/selectnamegra/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
	  "SELECT COUNT(*) AS pagenum FROM grade, student WHERE (student.studentid = grade.studentid AND student.name LIKE '%" +
	  req.params.stuname +
	  "%')";
	
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`department.NAME AS xueyuan,` +
			`class.NAME AS classname, ` +
			`course.coursename AS subject,` +
			`course.class AS class,` +
			`status,` +
			`grade ` +
			`FROM ` +
			`grade ` +
			`INNER JOIN student ON ( student.studentid = grade.studentid ) ` +
			`INNER JOIN course ON ( course.courseid = grade.courseid ) ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`WHERE student.name like '%` + req.params.stuname + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 成绩——搜索，学号搜索
app.get("/selectidgra/:stuid/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
		"select count(*) as pagenum from grade where (studentid like '%" +
		req.params.stuid +
		"%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql =
		`SELECT ` +
			`student.studentid, ` +
			`student.NAME AS name, ` +
			`sex, ` +
			`department.NAME AS xueyuan,` +
			`class.NAME AS classname, ` +
			`course.coursename AS subject,` +
			`course.class AS class,` +
			`status,` +
			`grade ` +
			`FROM ` +
			`grade ` +
			`INNER JOIN student ON ( student.studentid = grade.studentid ) ` +
			`INNER JOIN course ON ( course.courseid = grade.courseid ) ` +
			`INNER JOIN class ON ( student.class = class.id ) ` +
			`INNER JOIN department ON ( student.department = department.id ) ` +
			`WHERE grade.studentid like '%` + req.params.stuid + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 体测——搜索，学号搜索
app.get("/selectidsports/:stuid/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
		"select count(*) as pagenum from sports where (studentid like '%" +
		req.params.stuid +
		"%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql = `SELECT ` +
		`student.studentid AS studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`height, ` +
		`weight, ` +
		`vital, ` +
		`jump,` +
		`sitreach, ` +
		`run1000, ` +
		`run800, ` +
		`situp, ` +
		`pullup ` +
		`FROM ` +
		`sports ` +
		`INNER JOIN student ON ( student.studentid = sports.studentid ) ` +
			`WHERE sports.studentid like '%` + req.params.stuid + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 体测——搜索，姓名搜索
app.get("/selectnamesports/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
	  "SELECT COUNT(*) AS pagenum FROM sports, student WHERE (student.studentid = sports.studentid AND student.name LIKE '%" +
	  req.params.stuname +
	  "%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql = `SELECT ` +
		`student.studentid AS studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`height, ` +
		`weight, ` +
		`vital, ` +
		`jump,` +
		`sitreach, ` +
		`run1000, ` +
		`run800, ` +
		`situp, ` +
		`pullup ` +
		`FROM ` +
		`sports ` +
		`INNER JOIN student ON ( student.studentid = sports.studentid ) ` +
		`WHERE student.name like '%` + req.params.stuname + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 体测——搜索，性别搜索
app.get("/selectsexsports/:stuname/page/:page", async (req, res) => {
	// console.log(req.params.stuname);
	// console.log(req.params.page);
	// 获取总页数
	let strSql0 =
	  "SELECT COUNT(*) AS pagenum FROM sports, student WHERE (student.studentid = sports.studentid AND student.sex LIKE '%" +
	  req.params.stuname +
	  "%')";
	let result1 = await sqlQuery(strSql0);
	// console.log(pageAll);

	// 每页包含的条数
	let itemPerPage = 8;
	let pageAll = Math.ceil(result1[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page)
	let strSql = `SELECT ` +
		`student.studentid AS studentid, ` +
		`student.NAME AS name, ` +
		`sex, ` +
		`height, ` +
		`weight, ` +
		`vital, ` +
		`jump,` +
		`sitreach, ` +
		`run1000, ` +
		`run800, ` +
		`situp, ` +
		`pullup ` +
		`FROM ` +
		`sports ` +
		`INNER JOIN student ON ( student.studentid = sports.studentid ) ` +
		`WHERE student.sex like '%` + req.params.stuname + `%'` +
			`LIMIT ` +
			currentPage * itemPerPage +
			"," +
			itemPerPage +
			" ;";
	let result2 = await sqlQuery(strSql);
	res.json({
		data: Array.from(result2),
		pageAll
	});
});

// 插入学生信息

// 获取学生总数，学院总数，班级，奖励
app.get('/overview', async (req, res) => {
	let sqlstr0 = 'select count(*) as num from '
	
	//使用触发器方式
	let sqlstr1 = 'select studentcount as num from '
	let result1 = await sqlQuery(sqlstr1 + 'count')
	//let result1 = await sqlQuery(sqlstr0 + 'student')
	let result2 = await sqlQuery(sqlstr0 + 'department')
	let result3 = await sqlQuery(sqlstr0 + 'class')
	let result4 = await sqlQuery(sqlstr0 + 'reward')

	result1[0].name = '学生总数'
	result2[0].name = '学院总数'
	result3[0].name = '班级总数'
	result4[0].name = '奖励记录'
	res.json({
		data: [
			result1[0],
			result2[0],
			result3[0],
			result4[0]
		]
	})
})

// 查看违纪情况
app.get('/selcetpunish/:stuid',async(req,res) => {
	let sql = `SELECT ` +
	`punishment.description, `+
	`punish_levels.DESCRIPTION,punishment.REC_TIME `+
`FROM `+
	`punishment `+
	`INNER JOIN punish_levels ON (LEVELS = CODE) `+
	`where STUDENTID = ` + req.params.stuid
	
	let result1 = await sqlQuery(sql)
	res.json(result1)
})

// 查看获奖情况
app.get('/selcetreward/:stuid',async(req,res) => {
	let sql = `SELECT ` +
	`reward.description, `+
	`reward_levels.DESCRIPTION,reward.REC_TIME `+
`FROM `+
	`reward `+
	`INNER JOIN reward_levels ON (LEVELS = CODE) `+
	`where STUDENTID = ` + req.params.stuid
	
	let result1 = await sqlQuery(sql)
	res.json(result1)
})

// 获取每个班级的人数
app.get('/getclassnum',async(req,res) => {
	// 查找数目多少
	let sql0 = `SELECT count(*) as value FROM student WHERE student.CLASS = `
	// 查找student的class 对应 class的name
	let sql1 = `select name from class where CLASS.id = `
	
	let result = []
	for (let i=0 ; i<12 ; i++){
		result[i] = await sqlQuery(sql0 + i)
		let classname = await sqlQuery(sql1 + i)
		result[i][0].name = classname[0].name
	}
	res.json({
		data: [
			result[0][0],
			result[1][0],
			result[2][0],
			result[3][0],
			result[4][0],
			result[5][0],
			result[6][0],
			result[7][0],
			result[8][0],
			result[9][0],
			result[10][0],
			result[11][0],		
		]
	})
})

// 获取每个省份人数
app.get('/getnative',async(req,res) => {
	let sql = `select count(*) as "value", NATIVE_PLACE as "name" from student GROUP BY NATIVE_PLACE;`
	let result = await sqlQuery(sql)
	res.json(result)
})

// 获取奖学金情况
app.get('/getreward',async(req,res) => {
	let sql = `SELECT count(*) as value, reward_levels.DESCRIPTION as name `+
			`FROM reward `+
			`INNER JOIN reward_levels `+
			`WHERE LEVELS = CODE GROUP BY (LEVELS) `
	let result = await sqlQuery(sql)
	res.json(result)
})

// 获取处罚情况
app.get('/getpunish',async(req,res) => {
	let sql = `SELECT count(*) as value, punish_levels.DESCRIPTION as name `+
			`FROM punishment `+
			`INNER JOIN punish_levels `+
			`WHERE LEVELS = CODE GROUP BY (LEVELS) `
	let result = await sqlQuery(sql)
	res.json(result)
})

// 学籍变更情况
app.get('/getchange',async(req,res) => {
	let sql = `SELECT count(*) as value, change_code.DESCRIPTION as name `+
			`FROM \`change_\` `+
			`INNER JOIN \`change_code\` `+
			`WHERE \`CODE\` = \`CHANGE\` GROUP BY (\`CHANGE\`) `
	let result = await sqlQuery(sql)
	res.json(result)
})

// 各班高数平均成绩
app.get('/getgradeavg',async(req,res) => {
	let sql = `SELECT avg( grade ) AS value, class.NAME as name `+
`FROM grade INNER JOIN class ` +
`WHERE grade.class = class.id ` +
`GROUP BY (grade.class) `
	let result = await sqlQuery(sql)
	res.json(result)
})

// // 获取全部学生学籍情况——查表方法
// app.get("/select/allstudentstatus/:page", async (req, res) => {
// 	// 获取总页数
// 	let strSql0 = "select count(*) as pagenum from change_;";
// 	let result = await sqlQuery(strSql0);
// 	// 每页包含的条数
// 	let itemPerPage = 8;
// 	let pageAll = Math.ceil(result[0].pagenum / itemPerPage);
// 	let currentPage = parseInt(req.params.page)
// 	// console.log(currentPage*itemPerPage +"," +(currentPage+1)*itemPerPage +" ;")
// 	// 获取详细信息
// 	let strSql1 = `SELECT ` +
// 		`change_.studentid , ` +
// 		`student.NAME AS name, ` +
// 		`sex, ` +
// 		`department.NAME AS xueyuan, ` +
// 		`class.NAME AS classname, ` +
// 		`change_code.DESCRIPTION AS stu_status, ` +
// 		`change_.DESCRIPTION AS stu_reason, ` +
// 		`REC_TIME AS change_time ` + 
// 		`FROM ` +
// 		`change_ ` + 
// 		`INNER JOIN student ON (change_.STUDENTID = student.STUDENTID) `+
// 		`INNER JOIN class ON ( student.class = class.id ) ` +
// 		`INNER JOIN department ON ( student.department = department.id ) ` +
// 		`INNER JOIN change_code ON ( change_code.code = change_.change ) ` +
// 		`ORDER BY ` +
// 		`change_.STUDENTID ` +
// 		`LIMIT ` +
// 		currentPage * itemPerPage +
// 		"," +
// 		itemPerPage +
// 		" ;";
// 	let result1 = await sqlQuery(strSql1);
// 	res.json({
// 		data: Array.from(result1),
// 		pageAll
// 	});
// });

// 获取全部学生学籍情况——视图方法
app.get("/select/allstudentstatus/:page", async (req, res) => {
	// 获取总页数
	let strSql0 = "SELECT COUNT(*) AS pagenum FROM v_status;";
	let result = await sqlQuery(strSql0);
  
	// 每页包含的条数
	let itemPerPage = 10;
	let pageAll = Math.ceil(result[0].pagenum / itemPerPage);
	let currentPage = parseInt(req.params.page);
  
	// 获取详细信息
	let strSql1 =
	  `SELECT * FROM v_status ORDER BY STUDENTID LIMIT ` +
	  currentPage * itemPerPage +
	  `,` +
	  itemPerPage +
	  `;`;
  
	let result1 = await sqlQuery(strSql1);
  
	res.json({
	  data: Array.from(result1),
	  pageAll,
	});
  });


// 查看某个学号是否存在
app.get("/isexist/:stuid",async(req,res) => {
	let sql = `select * from student where STUDENTID = ` + req.params.stuid
	let result = await sqlQuery(sql)
	res.json(result)
})

//查看sports
app.get("/isexist_sport/:stuid",async(req,res) => {
	console.log('查看学号add_sports')
	let sql = `select * from sports where STUDENTID = ` + req.params.stuid
	let result = await sqlQuery(sql)
	res.json(result)
})

// // 更改新增
// app.post('/update',jsonParser,async(req,res) => {
// 	let sql = `UPDATE \`student\` `+ 
// 		`SET STUDENTID = ? , student.NAME =  ?,sex= ?, `+
// 		`student.class = ( SELECT class.id FROM class WHERE class.NAME = ? ),`+
// 		`student.DEPARTMENT = ( SELECT department.id FROM department WHERE department.NAME = ? ) `+
// 		`WHERE STUDENTID = ? `
// 	let arr = []
// 	arr[0] = req.body.studentid
// 	arr[1] = req.body.name
// 	arr[2] = req.body.sex
// 	arr[3] = req.body.classname
// 	arr[4] = req.body.xueyuan
// 	arr[5] = req.body.studentid
	
// 	let result =await sqlQuery(sql,arr);
// 	res.end()
// })
// 更改新增
app.post('/update',jsonParser,async(req,res) => {
	let sql = `UPDATE \`student\` `+ 
		`SET STUDENTID = ? , student.NAME =  ?,sex= ?, `+`native_place=?,`+
		`student.class = ( SELECT class.id FROM class WHERE class.NAME = ? ),`+
		`student.DEPARTMENT = ( SELECT department.id FROM department WHERE department.NAME = ? ) `+
		`WHERE STUDENTID = ? `
	let arr = []
	arr[0] = req.body.studentid
	arr[1] = req.body.name
	arr[2] = req.body.sex
	arr[3] = req.body.native_place
	arr[4] = req.body.classname
	arr[5] = req.body.xueyuan
	arr[6] = req.body.studentid
	
	let result =await sqlQuery(sql,arr);
	res.end()
})

// 成绩——更新
app.post('/updategra', jsonParser, async (req, res) => {
    let studentid = req.body.studentid;
    let coursename = req.body.subject;
    let status = req.body.status; // 新的课程状况
    let grade = req.body.grade; // 新的成绩

    let sql1 = `SELECT courseid FROM course WHERE coursename = ?`;

    let arr1 = [coursename];

    try {
        let result1 = await sqlQuery(sql1, arr1);

        if (!result1 || result1.length === 0) {
            res.status(404).json({ error: "Course not found" });
            return;
        }

        let courseid = result1[0].courseid;

        let sql2 = `
            UPDATE grade
            SET status = ?, grade = ?
            WHERE studentid = ? AND courseid = ?
        `;

        let arr = [
            status,
            grade,
            studentid,
            courseid
        ];

        let result = await sqlQuery(sql2, arr);
        res.end();

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// 成绩——新增
app.post('/newgra', jsonParser, async (req, res) => {
	let sql = "UPDATE `grade` " +
	"INNER JOIN student ON student.studentid = grade.studentid " +
	"INNER JOIN course ON course.courseid = grade.courseid " +
	"SET grade.studentid = ?, " +
	"student.NAME = ?, " +
	"student.sex = ?, " +
	"student.DEPARTMENT = (SELECT department.id FROM department WHERE department.NAME = ?), " +
	"student.class = (SELECT class.id FROM class WHERE class.NAME = ?), " +
	"course.coursename = ?, " +
	"course.class = ?, " +
	"grade.status = ?, " +
	"grade.grade = ? " +
	"WHERE grade.studentid = ? AND course.courseid = ?";  // 添加逗号并修正占位符

let arr = [];
arr[0] = req.body.studentid;
arr[1] = req.body.name;
arr[2] = req.body.sex;
arr[3] = req.body.xueyuan;
arr[4] = req.body.classname;
arr[5] = req.body.subject;
arr[6] = req.body.class;
arr[7] = req.body.status;
arr[8] = req.body.grade;
arr[9] = req.body.studentid;
arr[10] = req.body.courseid;

let result = await sqlQuery(sql, arr);
res.end();
  })

// 删除操作
// 删除操作
app.post('/delete',jsonParser,async(req,res) => {

	let sql=`delete from sports where studentid = ?`
	let sql1 = `delete from grade where studentid = ?`
	let sql2 = `delete from change_ where studentid = ?`
	let sql3 = `delete from reward where studentid = ?`
	let sql4 = `delete from student where studentid = ?`
	let arr = []
	arr[0] = req.body.studentid;
	let result3 =await sqlQuery(sql3,arr);
	let result2 =await sqlQuery(sql2,arr);
	let result1 =await sqlQuery(sql1,arr);
	let result =await sqlQuery(sql,arr);
	let result4 =await sqlQuery(sql4,arr);
	
	res.end();
})



// admin查找
app.get('/admin',async(req,res) => {
	let sql = `select * from admin`
	let result = await sqlQuery(sql)
	res.json(result)
})

//添加学生
app.post('/add', jsonParser, async (req, res) => {
	console.log(req.body.birthday);
	
		let sql1 = `INSERT INTO \`student\` ` +
    `VALUES (?, ?, ?, ` +
    `(SELECT id FROM class WHERE NAME = ?), ` +
    `(SELECT id FROM department WHERE NAME = ?), ` +
    `?, ?)`; // 替换 "?" 为实际字段值

	let arr = []
	arr[0] = req.body.studentid
	arr[1] = req.body.name
	arr[2] = req.body.sex
	arr[3] = req.body.classname
	arr[4] = req.body.xueyuan
	arr[6] = req.body.native_place

    let month = req.body.birthday.substring(5, 7); // 从索引位置 5 开始截取，包括索引位置 5
    let day= req.body.birthday.substring(8, 10); // 从索引位置 8 开始截取，包括索引位置 8
    arr[5]= month + "-" + day;
  
	try {
	  let result = await sqlQuery(sql1, arr);
	  
	  res.end();
	} catch (error) {
	  console.error(error);
	  res.status(500).json({ error: 'Internal Server Error' });
	}
  });
 
// 体测——删除操作
app.post('/deletesports',jsonParser,async(req,res) => {
	let sql = `delete from sports where studentid = ?`
	let arr = []
	arr[0] = req.body.studentid
	
	let result =await sqlQuery(sql,arr);
	res.end()
})

// 成绩——删除操作
app.post('/deletegrade', jsonParser, async (req, res) => {
	const studentid = req.body.studentid;
	const coursename = req.body.subject;
  
	// 使用子查询查找 course 表中对应的 courseId
	let sql = `DELETE FROM grade WHERE studentid = ? AND courseid = (
	  SELECT courseid FROM course WHERE coursename = ?
	)`;
	let result = await sqlQuery(sql, [studentid, coursename]);
	res.end();
  });  

// 体测——更改新增
app.post('/updatesports',jsonParser,async(req,res) => {
	let name = req.body.name;
	let sex = req.body.sex;
	let studentid = req.body.studentid;
  
	// 先查询出对应的studentid
	let studentQuerySql = 'SELECT studentid FROM student WHERE name = ? AND sex = ?';
	let studentQueryArr = [name, sex];
	let studentQueryResult = await sqlQuery(studentQuerySql, studentQueryArr);
  
	if (studentQueryResult.length === 0) {
	  res.end('未查询到对应的学生');
	  return;
	}
  
	studentid = studentQueryResult[0].studentid;
  
	let sql = `UPDATE \`sports\` `+ 
	  `SET studentid = ? ,` +
	  `height = ?, ` +
	  `weight = ?, ` +
	  `vital = ?, ` +
	  `jump = ?,` +
	  `sitreach = ?, ` +
	  `run1000 = ?, ` +
	  `run800 = ?, ` +
	  `situp = ?, ` +
	  `pullup = ? ` +
	  `WHERE studentid = ? `;
	let arr = [
	  studentid, 
	  req.body.height, 
	  req.body.weight, 
	  req.body.vital, 
	  req.body.jump, 
	  req.body.sitreach, 
	  req.body.run1000, 
	  req.body.run800, 
	  req.body.situp, 
	  req.body.pullup, 
	  req.body.studentid,
	];
	
	let result = await sqlQuery(sql, arr);
	res.end();
  });


// 体测——添加学生
app.post('/addsports', jsonParser, async (req, res) => {
	let name = req.body.name;
	let sex = req.body.sex;
	let studentid = req.body.studentid;

	// studentid = studentQueryResult[0].studentid;
	let sql1 = `INSERT INTO \`sports\` ` +
	`VALUES (?, ?, ?, ?,?,?,?, ?,?,?)`;

	// let sql = `INSERT INTO \`sports\` `+ 
	//   `SET studentid = ? ,` +
	//   `height = ?, ` +
	//   `weight = ?, ` +
	//   `vital = ?, ` +
	//   `jump = ?,` +
	//   `sitreach = ?, ` +
	//   `run1000 = ?, ` +
	//   `run800 = ?, ` +
	//   `situp = ?, ` +
	//   `pullup = ? ` ;

	let arr = [
	req.body.studentid,
	  req.body.height, 
	  req.body.weight, 
	  req.body.vital, 
	  req.body.jump, 
	  req.body.sitreach, 
	  req.body.run1000, 
	  req.body.run800, 
	  req.body.situp, 
	  req.body.pullup, 
	 // req.body.studentid,
	];
  
	try {
	  let result = await sqlQuery(sql1, arr);
	  console.log('add发送成功')
	  res.end();
	} catch (error) {
	  console.error(error);
	  res.status(500).json({ error: 'Internal Server Error' });
	}
});
  
app.listen(3000);
console.log("success listen at port:8080......");
