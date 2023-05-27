package 课程设计;

import java.io.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class ConstructQuaternion {
	//定义队列用于存放四元式(采用链表结构)
	private Queue<Quaternion> queue=new LinkedList<Quaternion>();
	//定义List集合用于存储当前句子的词语
	private ArrayList<String> list=new ArrayList<String>(); 
	//定义哈希表用于存储所有词语
    private HashMap<String,Integer>all;
    private HashMap<String,Integer> hashMap=new HashMap<>();
    //定义栈用于存放运算对象
    public Stack<String> arg=new Stack<String>();
    //定义栈用于存放操作符
    public Stack<String> op=new Stack<String>();
    
    private Lexer lexer;
    private Parsing parsing;
    
    //定义函数构建四元式
    public ConstructQuaternion(){
    	//定义关键字为while
    	String keyword[] = {"while"};
    	//定义运算符集合
    	String operator[] = {"+","-","*","/",">","<=","=","<","==",">="};
    	//将关键字和运算符导入所定义的词法分析哈希表中
    	lexer = new Lexer(keyword, operator);
    	this.all = lexer.all;
    	
    	//将相关符号加入新建的词法分析所用的哈希表
    	//并按照优先级大小进行标号
    	hashMap.put("=",0);
        hashMap.put(">",1);
        hashMap.put("<",1);
        hashMap.put(">=",1);
        hashMap.put("<=",1);
        hashMap.put("==",1);
        hashMap.put("+",2);
        hashMap.put("-",2);
        hashMap.put("*",3);
        hashMap.put("/",3);
        hashMap.put("%",3);			
    }
    
    //定义函数用于返回生成词法分析
    public String[][] getLexer(){
    	//定义2*词语个数大小的矩阵
    	String [][] str = new String[this.list.size()][2];
    	for( int i=0; i < this.list.size(); i++ ){
    		str[i][0]=this.list.get(i);
    		String type="";
    		//对各个词语的类型进行标号
    		switch(all.get(list.get(i))){
            	case 0: type="关键字";break;
            	case 1: type="常量";break;
            	case 2: type="标识符";break;
            	case 3: type="操作符";break;
            	case 4: type="界符";break;
            	case 5: type="分隔符";break;
    		}
    		str[i][1] = type;
    	}
    	return str;
    }

    //定义函数用于返回语法分析结果
    public String getParsing(){
    	return parsing.message;
    }
    
    @SuppressWarnings("unchecked")
	public Queue<Quaternion> semantic (String filename) throws IOException {
    	//定义文件输入流
    	File file=new File(filename);
        FileInputStream fis =new FileInputStream(file);
        InputStreamReader is =new InputStreamReader(fis);
		BufferedReader bfr=new BufferedReader(is);
        
        //将文件中的内容存入字符串中
        String s="";
        String str ="";
        //读取一行数据后放入新定义的变量s中
        while(( s=bfr.readLine()) != null ){
            str += s;
        }
        //对所得到的语句进行词法分析和语法分析
        ArrayList<String> alist = lexer.analyse(str);
        this.list=(ArrayList<String>) alist.clone();
        //对于得到的语句进行语法分析——递归下降分析
        parsing = new Parsing(alist,lexer.all);
        //当前句子转化为LL(1)文法
        if (parsing.flag == true){
        	int n = 2;//while=0 (=1
        	int table = 1;
        	int count = 1;
        	
        	//while后的部分
        	while( n<list.size() && !list.get(n).equals(")") ){
        		//当前为常数或者标识符则将其入栈
        		if(all.get(list.get(n))==1||all.get(list.get(n))==2){
                    arg.push(list.get(n));
                    n++;
        		}
        		else{
        			//当前操作码栈为空
        			if(op.size()==0){
        				op.push(list.get(n));
        				n++;
        			}
        			else{
        				//比较当前栈顶的元素和当前元素的优先级(即两个操作符优先级进行比较）
        				if(hashMap.get(list.get(n)) > hashMap.get(op.peek())){
        					//当前操作符优先级高，入栈
        					op.push(list.get(n));
        					n++;
        				}
        				else{
        					while(arg.size()>0&&op.size()>0&& hashMap.get(list.get(n))<=hashMap.get(op.peek()) ) {
        						//栈顶操作符优先级较高，则输出四元式
        						String arg1 = arg.pop();
                                String arg2 = arg.pop();
                                String sign = op.pop();
                                //生成当前语句四元式
                                Quaternion e= new Quaternion((count++) + "", sign, arg1, arg2, "T" + table);
                                //将当前插入队列中
                                queue.offer(e);
                                //将T入栈(运算对象)
                                arg.push("T" + table++);
        					}
        					op.push(list.get(n));
                            n++;
        				}
        			}		
        		}
        	}
        	while(op.size()>0){
        		//当操作符是<,<=,>,>=时
                if(hashMap.get(op.peek())==1){
                	String a = arg.pop();
                	String b = arg.pop();
                	//若当前式子为真，则有以下四元式
                	Quaternion e= new Quaternion((count++) + "", "j"+op.pop(), a,b, "<"+(count+1)+">");
                    queue.offer(e);
                    //若当前式子为假，则有以下四元式
                    Quaternion e1= new Quaternion((count++) + "", "j", "_ ", "_ ", "?");
                    queue.offer(e1);
                }
                else{
                	Quaternion e= new Quaternion((count++) + "", op.pop(), arg.pop(), arg.pop(), "T"+table);
                    queue.offer(e);
                    arg.push("T"+table);
                    table++;
                }
            }
        	
        	//大括号中的部分
            n+=2;//忽略)和{
            int t=n;
            int k=0;//表示语句的数量
            while(!list.get(n).equals("}")){
                if(list.get(n).equals(";"))
                    k++;
                n++;
            }
            n=t;
            
            for(int i=0; i<k; i++){
                while(n<list.size()&&all.get(list.get(n))!=0&&!list.get(n).equals(";"))
                {
                    //当前为常数或标识符
                	if(all.get(list.get(n))==1||all.get(list.get(n))==2){
                        arg.push(list.get(n));
                        n++;
                    }
                    else {
                        if(op.size()>0){
                            if(hashMap.get(list.get(n))>hashMap.get(op.peek())){
                                op.push(list.get(n));
                                n++;
                            }
                            else{
                                while(arg.size()>0&&op.size()>0&&hashMap.get(list.get(n))<=hashMap.get(op.peek())) {
                                    String arg1 = arg.pop();
                                    String arg2 = arg.pop();
                                    String sign = op.pop();
                                    Quaternion e= new Quaternion((count++) + "", sign, arg1, arg2, "T"+table);
                                    queue.offer(e);
                                    arg.push("T" + table++);
                                }
                                op.push(list.get(n));
                                n++;
                            }
                        }
                        else{
                            op.push(list.get(n));
                            n++;
                        }
                    }
                }
                while(op.size()>0)
                {
                	//赋值
                    if(op.peek().equals("=")){
                    	Quaternion e= new Quaternion((count++) + "", op.pop(), arg.pop(), "_ ", arg.pop());
                        queue.offer(e);
                    }
                    else{
                    	Quaternion e= new Quaternion((count++) + "", op.pop(), arg.pop(), arg.pop(), "T"+table);
                        queue.offer(e);
                        arg.push("T"+table);
                        table++;
                    }
                }
                if (list.get(n).equals(";")){
                    n++;
                }
            }
            //输出最后一句四元式表示翻译完成
            Quaternion e=new Quaternion((count++) + "", "j", "_ ", "_ ", "<1>");
            queue.offer(e);
        }
        else
            System.out.println("语法错误！");
        return queue;
    }	
    
    public static void main(String args[]) throws IOException {
    	ConstructQuaternion ConstructQuaternion=new ConstructQuaternion();
    	ConstructQuaternion.semantic("test.txt");
    }
}
