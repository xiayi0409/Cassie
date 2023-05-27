package 课程设计;

//词法分析部分

import java.util.ArrayList;
import java.util.HashMap;

public class Lexer {
	
	//定义哈希表类型函数keyword,operator,all
    private HashMap<String,Integer>keyword=new HashMap<String,Integer>();//关键字表
    private HashMap<String,Integer>operator=new HashMap<String,Integer>();//运算符表
    public HashMap<String,Integer>all=new HashMap<String,Integer>();
    
    //定义函数进行词法分析，将关键字和运算符导入所定义的哈希表中，有便于后续比较分析
	public Lexer(String keyword[] ,String operator[]){
		for(int i=0;i<keyword.length;i++){
            this.keyword.put(keyword[i],1);
        }
        for(int i=0;i<operator.length;i++){
            this.operator.put(operator[i],1);
        }
	}
	
	//使用ArrayList集合定义函数analyse
	public ArrayList<String> analyse(String line){
		ArrayList<String> list = new ArrayList<>();
		int n = 0;
		
		while (n<line.length()){
			
			//当前字符串以字母开头
			if(line.charAt(n)>='A' && line.charAt(n)<='z'){
				String temp = "";
				//字母后面可以为字母或数字
				while (line.charAt(n) >= 'A' && line.charAt(n) <= 'z' || line.charAt(n)>='0'&&line.charAt(n)<='9') {
					temp += line.charAt(n);//将当前字符输入temp
					n++;
				}
				//将当前temp字符串与关键字表进行比较
				if (keyword.get(temp) != null){//当前字符串为关键字，本题为while
					all.put(temp,0);//将当前字符加入all表中，并定义为0
					list.add(temp);//加入字符串列表
				}
				else{//当前字符为标识符
					all.put(temp,2);//将当前字符加入all表中，并定义为2
					list.add(temp);
				}
			}
			
			//当前字符串以数字开头
			else if(line.charAt(n)>='0' && line.charAt(n)<='9'){
				String temp ="";
				while (line.charAt(n)>='0'&&line.charAt(n)<='9'){
					temp += line.charAt(n);
					n++;
				}//当前字符串为常数
				all.put(temp,1);//将当前字符加入all表中，并定义为1
				list.add(temp);
			}
			
			//忽略空格带来的影响，判断界符、运算符、操作符等
			else if (line.charAt(n)!=' ') {
				//由于界符只占一个字符，较为容易判断，优先判断界符
				if(line.charAt(n)=='('||line.charAt(n)==')'||line.charAt(n)=='{'||line.charAt(n)=='}'){
					String temp = "";
					temp += line.charAt(n);//当前字符为界符
					all.put(temp,4); //将当前字符加入all表中，并定义为4
                    list.add(temp);
                    n++;
				}
				//判断分隔符;
				else if(line.charAt(n)==';'){
					String temp = "";
					temp += line.charAt(n);//当前字符为界符
					all.put(temp,5); //将当前字符加入all表中，并定义为5
                    list.add(temp);
                    n++;
                }
				//判断运算符
				else{
					String temp = "";
					//当前字符既不是数字也不是数字
					while (line.charAt(n) < '0' || line.charAt(n) > '9' && line.charAt(n) < 'A' || line.charAt(n) > 'z') {
						//由于运算符分为一元运算符和二元运算符，因此不能只判断一个字符
						temp += line.charAt(n);
						n++;
						//当前字符串与运算符表中的相同，则说明当前为运算符
						if (n < line.length() && operator.get(temp + line.charAt(n)) != null) {//当前字符串为二元运算符
                            all.put(temp + line.charAt(n), 3);//将当前字符加入all表中，并定义为3
                            list.add(temp + line.charAt(n));
                            n++;
                            break;
						}
						if (operator.get(temp) != null) {//当前字符串为一元运算符
                            all.put(temp, 3);////将当前字符加入all表中，并定义为3
                            list.add(temp);
                            break;
						}
						
						//词法判断结束标志
                        if (n >= line.length())
                            break;
					}
				}
			}
			else{
				n++;
			}
		}
		return list;//返回所得到的词法分析表
	}
}
