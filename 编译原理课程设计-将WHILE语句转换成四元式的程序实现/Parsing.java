package 课程设计;

//语法分析部分

import java.util.ArrayList;
import java.util.HashMap;

public class Parsing {
	//创建arrayList空的集合对象
	public ArrayList<String> arrayList;
	//创建哈希表all用于存储词法分析所得的结果
	public HashMap<String, Integer> all;
	//定义四元式是否生成标志，默认为成功
	public boolean flag = true;
	//定义语句Success用于表示四元式生成成功
	public String message = "Success!";
	
	//语法分析
	public Parsing(ArrayList<String>list, HashMap<String, Integer> all){
		arrayList = list;
		this.all = all;
		par();
	}
	
	//定义函数用于删去0位置，及当前位置的值
	public void cut(){
		arrayList.remove(0);
	}
	//定义函数设置错误标识
	public void error(){
		flag = false;
	}
	public void par(){
		//判断索引值为0的元素是否为while
		if(arrayList.get(0).equals("while")){
			cut();//删除当前元素
			//判断while后的元素是否为(
			if(arrayList.get(0).equals("(")){
				cut();
				A();
				if(arrayList.get(0).equals(")")){
					cut();
					if(arrayList.get(0).equals("{")){
						cut();
						B();
					}
					else{
						error();
						message = "Error!当前句型缺少“}”";
					}
				}
				else{
					error();
					message = "Error!当前句型缺少“)”";
				}
			}
			else{
				error();
				message = "Error!当前句型缺少“(”";
			}
		}
		else{
			error();
			message = "Error!当前语句非while句型";
		}
	}
	
	//对当前文法进行改进，消除左递归归改进为LL(1)文法
	//上面已将while语句分为赋值语句B和关系表达式A
	
	//关系表达式
	public void A(){
        C();//表达式C
        D();//比较运算符及判断符D
        C();//表达式C
    }
	//比较运算符D
    public void D(){
    	//判断当前符号是否为判断符号
        if(arrayList.get(0).equals(">")||arrayList.get(0).equals("<")||arrayList.get(0).equals("==")||arrayList.get(0).equals(">=")||arrayList.get(0).equals("<=")){
            cut();
        }
        else {
            error();
            message="Error!当前判断符错误";
        }
    }
    //表达式C
    public void C(){
        E();//标识符和常数E
        G();//加法运算符+和减法运算符-
    }
    public void E(){
        F();//带括号的表达式F
        H();//乘法运算符*和除法运算符/
    }
    //加法运算符+和减法运算符-
    public void G(){
        if(arrayList.size()>0&&arrayList.get(0).equals("+")){
            cut();
            E();//标识符和常数E
            G();//加减运算符G
        }
        else if (arrayList.size()>0&&arrayList.get(0).equals("-")){
            cut();
            E();//标识符和常数E
            G();//加减运算符G
        }
    }
    //乘法运算符*和除法运算符/
    public void H(){
        if(arrayList.size()>0&&arrayList.get(0).equals("*")){
            cut();
            F();//带括号的表达式F
            H();//乘除运算符H
        }
        else  if(arrayList.size()>0&&arrayList.get(0).equals("/")){
            cut();
            F();//带括号的表达式F
            H();//乘除运算符H
        }
    }
    //带括号的表达式F
    public void F(){
        if(arrayList.size()>0&&arrayList.get(0).equals("(")){
            cut();
            C();////表达式C
            if (arrayList.size()>0&&arrayList.get(0).equals(")"))
                cut();
            else {
                error();
                message="Error!当前语句缺失“)”";
            }
        }
        //当前是否为常数或标识符
        else if(arrayList.size()>0&&(all.get(arrayList.get(0))==2||all.get(arrayList.get(0))==1)){
            cut();
        }
        else {
            error();
            message="Error!当前语句标识符或常量错误";
        }
    }
    //赋值语句B
    public void B(){
    	//等号左边——当前语句是否为标识符或常数
        if(arrayList.size()>0&&all.get(arrayList.get(0))==2){
            cut();
            if (arrayList.size()>0&&arrayList.get(0).equals("=")){
                cut();
                C();//表达式C
                if (arrayList.size()>0&&arrayList.get(0).equals(";")){
                    cut();
                    B();//赋值语句B
                }
                else{
                    error();
                    message="Error!当前语句缺失“;”";
                }
            }
            else {
                error();
                message="Error!当前语句赋值符错误";
            }
        }
    }
}

