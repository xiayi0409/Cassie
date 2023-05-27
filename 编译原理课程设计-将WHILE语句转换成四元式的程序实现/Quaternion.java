package 课程设计;

//定义四元式部分

public class Quaternion {
	private String table;//四元式表号，方面查找
	private String op;//操作符
	private String arg1;//运算对象1
	private String arg2;//运算对象2
	private String result;//运算结果
	
	//定义Quaternion存储四元式
	public Quaternion(String table,String op,String arg1,String arg2,String result){
		this.table = table;
		this.op = op;
		this.arg1 = arg1;
		this.arg2 = arg2;
		this.result = result;
	}
	
	//分别定义函数获取四元式中的表号、操作符、操作数和运算结果
	public String gettable(){
		return table;
	}
	public String getop(){
		return op;
	}
	public String getarg1(){
		return arg1;
	}
	public String getarg2(){
		return arg2;
	}
	public String getresult(){
		return result;
	}
	
	//定义函数设置四元式中的各项
	public void settable(String table){
		this.table = table;
	}
	public void setop(String op){
		this.op = op;
	}
	public void setarg1(String arg1){
		this.arg1 = arg1;
	}
	public void setarg2(String arg2){
		this.arg2 = arg2;
	}
	public void setresult(String result){
		this.result = result;
	}
	
	//根据格式输出当前四元式
	public String priQuat(){
		return "<" + table + "> (" + op + "," + arg1 + "," + arg2 + "," + result + ")";
	}
}
