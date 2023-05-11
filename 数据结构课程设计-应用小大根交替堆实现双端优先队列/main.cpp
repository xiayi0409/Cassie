#include"min_max_heap.h"
#include"student.h"
#include<string.h>
#include<iostream>
#include<fstream>
#include<vector>
#include<cstdio>
using namespace std;

vector<student> students;//学生信息
min_max_heap<int> student_mh(50);//学生数学成绩信息堆
min_max_heap<int> student_eh(50);//学生英语成绩信息堆
min_max_heap<int> student_ch(50);//学生语文成绩信息堆
min_max_heap<int> student_h(50);//学生总成绩信息堆
min_max_heap<int> h(50);//小大根交替堆测试堆

//不同堆中的数组成员，初始化堆时的数组以及元素数
int ArrayHeapm[100], Arraym[100], flag_search, a, initSizem = 0;//初始化堆时的数组及元素数
int ArrayHeape[100], Arraye[100], initSizee = 0;
int ArrayHeapc[100], Arrayc[100], initSizec = 0;
int ArrayHeap[100], Array[100], initSize = 0;

char choose, c;//用户的功能选项


void initial()
 //读入学生信息
{
    ifstream file("information.txt");//文件里有一个成绩很大的数作为初始化的起点
    if (file.fail())
    {
        printf("文件打开失败！\n");
        return;
    }
    else
    {
        char s[101];
        student student1;
        while (file >> student1.getStudentId() >> student1.getName() >> student1.getSex() >> student1.getBirthPlace()
>> student1.getBirthDate() >> student1.getTelephone() >> student1.getmathGrade()>> student1.getchineseGrade()>> student1.getenglishGrade())
        {
            ArrayHeapm[++initSizem] = student1.getmathGrade();
            ArrayHeape[++initSizee] = student1.getenglishGrade();
            ArrayHeapc[++initSizec] = student1.getchineseGrade();
            ArrayHeap[++initSize] = student1.getchineseGrade()+ student1.getmathGrade()+ student1.getenglishGrade();
            students.push_back(student1);
        }
        cout << "按学生数学成绩建立小大根交替堆并不断调整的过程如下："<<endl;
        student_mh.initialize(ArrayHeapm, initSizem);
        cout<<endl<<endl<<endl;
        cout << "按学生语文成绩建立小大根交替堆并不断调整的过程如下：" << endl;
        student_ch.initialize(ArrayHeapc, initSizec);
        cout<<endl<<endl<<endl;
        cout << "按学生英语成绩建立小大根交替堆并不断调整的过程如下：" << endl;
        student_eh.initialize(ArrayHeape, initSizee);
        cout<<endl<<endl<<endl;
        cout << "按学生总分成绩建立小大根交替堆并不断调整的过程如下：" << endl;
        student_h.initialize(ArrayHeap, initSize);
    }
}


void menu()
//菜单显示
{
    printf("****小大根交替堆实现双端优先队列****\n");
    printf("* a-建立小大根交替堆\n");
    printf("* b-插入元素\n");
    printf("* c-删除最大值\n");
    printf("* d-删除最小值\n");
    printf("* e-输出最小值\n");
    printf("* f-输出最大值\n");
    printf("* g-依据学生成绩对学生信息的查询\n");
    printf("* h-退出\n");
    printf("************************************\n");
}

void studentInfoQuery()
{
    flag_search = 1;
    while (flag_search)
    {
        printf("****小大根交替堆实现的学生成绩管理系统****\n");
        printf("* 1-输出所有学生的信息\n");
        printf("* 2-查询成绩最高的学生信息\n");
        printf("* 3-查询成绩最低的学生信息\n");
        printf("* 4-通过具体的成绩进行查询\n");
        printf("* 5-输出学生成绩的平均值\n");
        printf("* 6-添加学生信息\n");
        printf("* 7-退出\n");
        printf("*****************************************\n");
        getchar();
        scanf("%d", &a);
        int count, max, min;
        if (a == 2)//查询最高成绩学生的信息
        {
            cout << "选择查询的科目：1：数学  2：英语 3：语文 4：总分"<<endl;
            int k;
            cin >> k;
            if (k == 1)
            {
                cout << "数学最高成绩为：" << endl;
                max = student_mh.getmax();
                count = 0;
                for (int i = 0; i < students.size(); i++)
                {
                    if (students.at(i).getmathGrade() == max)
                    {
                        count++;
                        cout << students.at(i).getStudentId() << " "
                            << students.at(i).getName() << " "
                            << students.at(i).getSex() << " "
                            << students.at(i).getBirthDate() << " "
                            << students.at(i).getBirthPlace() << " "
                            << students.at(i).getTelephone() << " "
                            << "数学成绩：" << students.at(i).getmathGrade() << " "
                            << "语文成绩：" << students.at(i).getchineseGrade() << " "
                            << "英语成绩：" << students.at(i).getenglishGrade() << " "
                            << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
                if (count == 0)
                    printf("没有数学最高成绩的同学\n");
            }
            if (k == 2)
            {
                cout << "英语最高成绩为：" << endl;
                max = student_eh.getmax();
                count = 0;
                for (int i = 0; i < students.size(); i++)
                {
                    if (students.at(i).getenglishGrade() == max)
                    {
                        count++;
                        cout << students.at(i).getStudentId() << " "
                            << students.at(i).getName() << " "
                            << students.at(i).getSex() << " "
                            << students.at(i).getBirthDate() << " "
                            << students.at(i).getBirthPlace() << " "
                            << students.at(i).getTelephone() << " "
                            << "数学成绩：" << students.at(i).getmathGrade() << " "
                            << "语文成绩：" << students.at(i).getchineseGrade() << " "
                            << "英语成绩：" << students.at(i).getenglishGrade() << " "
                            << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
            if (count == 0)
                printf("没有英语最高成绩的同学\n");
            }
            if (k == 3)
            {
                cout << "语文最高成绩为：" << endl;
                max = student_ch.getmax();
                count = 0;
                for (int i = 0; i < students.size(); i++)
                {
                    if (students.at(i).getchineseGrade() == max)
                    {
                        count++;
                        cout << students.at(i).getStudentId() << " "
                        << students.at(i).getName() << " "
                        << students.at(i).getSex() << " "
                        << students.at(i).getBirthDate() << " "
                        << students.at(i).getBirthPlace() << " "
                        << students.at(i).getTelephone() << " "
                        << "数学成绩：" << students.at(i).getmathGrade() << " "
                        << "语文成绩：" << students.at(i).getchineseGrade() << " "
                        << "英语成绩：" << students.at(i).getenglishGrade() << " "
                        << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
                if (count == 0)
                    printf("没有语文最高成绩的同学\n");
            }
        if (k == 4)
        {
            cout << "总分最高成绩为：" << endl;
            max = student_h.getmax();
            count = 0;
            for (int i = 0; i < students.size(); i++)
            {
                if (students.at(i).getchineseGrade()+ students.at(i).getmathGrade()+ students.at(i).getenglishGrade() == max)
                {
                    count++;
                    cout << students.at(i).getStudentId() << " "
                    << students.at(i).getName() << " "
                    << students.at(i).getSex() << " "
                    << students.at(i).getBirthDate() << " "
                    << students.at(i).getBirthPlace() << " "
                    << students.at(i).getTelephone() << " "
                    << "数学成绩：" << students.at(i).getmathGrade() << " "
                    << "语文成绩：" << students.at(i).getchineseGrade() << " "
                    << "英语成绩：" << students.at(i).getenglishGrade() << " "
                    << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
        if (count == 0)
            printf("没有总分最高成绩的同学\n");
        }
    }
    else if (a == 3)//查询最低成绩学生的信息
    {
        cout << "选择查询的科目：1：数学  2：英语 3：语文 4：总分"<<endl;
        int k;
        cin >> k;
        if (k == 1)
        {
            cout << "数学最低成绩为：" << endl;
            min = student_mh.getmin();
            count = 0;
            for (int i = 0; i < students.size(); i++)
            {
                if (students.at(i).getmathGrade() == min)
                {
                    count++;
                    cout << students.at(i).getStudentId() << " "
                    << students.at(i).getName() << " "
                    << students.at(i).getSex() << " "
                    << students.at(i).getBirthDate() << " "
                    << students.at(i).getBirthPlace() << " "
                    << students.at(i).getTelephone() << " "
                    << "数学成绩：" << students.at(i).getmathGrade() << " "
                    << "语文成绩：" << students.at(i).getchineseGrade() << " "
                    << "英语成绩：" << students.at(i).getenglishGrade() << " "
                    << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
            if (count == 0)
                printf("没有数学最低成绩的同学\n");
        }
        if (k == 2)
        {
            cout << "英语最低成绩为：" << endl;
            min = student_eh.getmin();
            count = 0;
            for (int i = 0; i < students.size(); i++)
            {
                if (students.at(i).getenglishGrade() == min)
                {
                    count++;
                    cout << students.at(i).getStudentId() << " "
                    << students.at(i).getName() << " "
                    << students.at(i).getSex() << " "
                    << students.at(i).getBirthDate() << " "
                    << students.at(i).getBirthPlace() << " "
                    << students.at(i).getTelephone() << " "
                    << "数学成绩：" << students.at(i).getmathGrade() << " "
                    << "语文成绩：" << students.at(i).getchineseGrade() << " "
                    << "英语成绩：" << students.at(i).getenglishGrade() << " "
                    << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
            if (count == 0)
                printf("没有英语最低成绩的同学\n");
        }
        if (k == 3)
        {
            cout << "语文最低成绩为：" << endl;
            min = student_ch.getmin();
            count = 0;
        for (int i = 0; i < students.size(); i++)
        {
            if (students.at(i).getchineseGrade() == min)
            {
                count++;
                cout << students.at(i).getStudentId() << " "
                << students.at(i).getName() << " "
                << students.at(i).getSex() << " "
                << students.at(i).getBirthDate() << " "
                << students.at(i).getBirthPlace() << " "
                << students.at(i).getTelephone() << " "
                << "数学成绩：" << students.at(i).getmathGrade() << " "
                << "语文成绩：" << students.at(i).getchineseGrade() << " "
                << "英语成绩：" << students.at(i).getenglishGrade() << " "
                << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
            }
        }
        if (count == 0)
            printf("没有语文最低成绩的同学\n");
        }
        if (k == 4)
        {
            cout << "总分最低成绩为：" << endl;
            min = student_h.getmin();
            count = 0;
            for (int i = 0; i < students.size(); i++)
            {
                if (students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() == min)
                {
                    count++;
                    cout << students.at(i).getStudentId() << " "
                    << students.at(i).getName() << " "
                    << students.at(i).getSex() << " "
                    << students.at(i).getBirthDate() << " "
                    << students.at(i).getBirthPlace() << " "
                    << students.at(i).getTelephone() << " "
                    << "数学成绩：" << students.at(i).getmathGrade() << " "
                    << "语文成绩：" << students.at(i).getchineseGrade() << " "
                    << "英语成绩：" << students.at(i).getenglishGrade() << " "
                    << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
        if (count == 0)
            printf("没有总分最低成绩的同学\n");
        }
    }
    else if (a == 4)//给出具体成绩进行查询
    {
        while (1)
        {
            cout << "选择查询的科目：1：数学  2：英语 3：语文 4：总分"<<endl;
            int k;
            cin >> k;
            printf("给出学生成绩(输入-1结束查询):");
            scanf("%d", &a);
            if (k == 1)
            {
                if (a == -1)
                    break;
                if (a < 0 || a>100)
                {
                    printf("请检查输入的成绩是否正确\n");
                    break;
                }
                count = 0;
                for (int i = 0; i < students.size(); i++)
                {
                    if (students.at(i).getmathGrade() == a)
                    {
                        count++;
                        cout << students.at(i).getStudentId() << " "
                        << students.at(i).getName() << " "
                        << students.at(i).getSex() << " "
                        << students.at(i).getBirthDate() << " "
                        << students.at(i).getBirthPlace() << " "
                        << students.at(i).getTelephone() << " "
                        << "数学成绩：" << students.at(i).getmathGrade() << " "
                        << "语文成绩：" << students.at(i).getchineseGrade() << " "
                        << "英语成绩：" << students.at(i).getenglishGrade() << " "
                        << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
                    }
                }
                if (count == 0)
                    printf("没有此成绩的同学\n");
            }
            if (k == 2)
            {
                if (a == -1)
                    break;
            if (a < 0 || a>100)
            {
                printf("请检查输入的成绩是否正确\n");
                break;
            }
            count = 0;
            for (int i = 0; i < students.size(); i++)
            {
                if (students.at(i).getenglishGrade() == a)
                {
                    count++;
                    cout << students.at(i).getStudentId() << " "
                    << students.at(i).getName() << " "
                    << students.at(i).getSex() << " "
                    << students.at(i).getBirthDate() << " "
                    << students.at(i).getBirthPlace() << " "
                    << students.at(i).getTelephone() << " "
                    << "数学成绩：" << students.at(i).getmathGrade() << " "
                    << "语文成绩：" << students.at(i).getchineseGrade() << " "
                    << "英语成绩：" << students.at(i).getenglishGrade() << " "
                    << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
                }
            }
            if (count == 0)
                printf("没有此成绩的同学\n");
            }
    if (k == 3)
    {
        if (a == -1)
            break;
        if (a < 0 || a>100)
        {
            printf("请检查输入的成绩是否正确\n");
            break;
            }
        count = 0;
        for (int i = 0; i < students.size(); i++)
        {
            if (students.at(i).getchineseGrade() == a)
            {
                count++;
                cout << students.at(i).getStudentId() << " "
                << students.at(i).getName() << " "
                << students.at(i).getSex() << " "
                << students.at(i).getBirthDate() << " "
                << students.at(i).getBirthPlace() << " "
                << students.at(i).getTelephone() << " "
                << "数学成绩：" << students.at(i).getmathGrade() << " "
                << "语文成绩：" << students.at(i).getchineseGrade() << " "
                << "英语成绩：" << students.at(i).getenglishGrade() << " "
                << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
        }
        if (count == 0)
            printf("没有此成绩的同学\n");
    }
    if (k == 4)
    {
        if (a == -1)
            break;
        cout << "总成绩中最高成绩为：";
        max = student_h.getmax();
        cout << "总成绩中最低成绩为：";
        min = student_h.getmin();
        if (a < min || a>max)
        {
            printf("请检查输入的成绩是否正确\n");
            break;
        }
        count = 0;
        for (int i = 0; i < students.size(); i++)
        {
            if (students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() == a)
            {
                count++;
                cout << students.at(i).getStudentId() << " "
                << students.at(i).getName() << " "
                << students.at(i).getSex() << " "
                << students.at(i).getBirthDate() << " "
                << students.at(i).getBirthPlace() << " "
                << students.at(i).getTelephone() << " "
                << "数学成绩：" << students.at(i).getmathGrade() << " "
                << "语文成绩：" << students.at(i).getchineseGrade() << " "
                << "英语成绩：" << students.at(i).getenglishGrade() << " "
                << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
        }
        if (count == 0)
            printf("没有此成绩的同学\n");
    }
    }
    }
    else if (a == 1)//输出所有学生的信息
    {
            printf("所有学生的信息如下:\n\n");

            for (int i = 0; i <= initSize-1; i++)
            {
                cout << students.at(i).getStudentId() << " "
                << students.at(i).getName() << " "
                << students.at(i).getSex() << " "
                << students.at(i).getBirthDate() << " "
                << students.at(i).getBirthPlace() << " "
                << students.at(i).getTelephone() << " "
                << "数学成绩：" << students.at(i).getmathGrade() << " "
                << "语文成绩：" << students.at(i).getchineseGrade() << " "
                << "英语成绩：" << students.at(i).getenglishGrade() << " "
                << "总分：" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
    }
    else if (a == 5)//输出学生成绩的平均值
    {
            cout << "选择查询的科目：1：数学  2：英语 3：语文 4：总分"<<endl;
            int k;
            cin >> k;
            if (k == 1)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getmathGrade();
                }
                cout<<"数学成绩的平均值为："<<(chengji/students.size())<<endl;
            }
            else if( k == 2 )
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getenglishGrade();
                }
                cout<<"英语成绩的平均值为："<<chengji/students.size()<<endl;
            }
            else if( k == 3)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getchineseGrade();
                }
                cout<<"语文成绩的平均值为："<<chengji/students.size()<<endl;
            }
            else if ( k == 4)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() ;
                }
                cout<<"总分的平均值为："<<chengji/students.size()<<endl;
            }
    }
    else if (a == 6)//添加学生信息
    {
        cout << "请输入待写入学生的学生信息，以学生学号，学生姓名，学生性别，学生出生年月，出生地，学生电话，数学成绩，语文成绩，英语成绩的顺序写入";
        char name[50];
        char telephone[12];
        char studentID[20];
        char birthDate[20];
        char birthPlace[100];
        char sex[3];
        int mathgrade, chinesegrade, englishgrade;
        cin >> studentID >>  name >> sex >> birthDate >> birthPlace >> telephone >> mathgrade >> chinesegrade>>englishgrade;
        ofstream outfile("information.txt",ios::app);//写入文件
        outfile<<studentID<<" "<<name<<" "<<sex<<" "<<birthDate<<" "<<birthPlace<<" "<<telephone<<" "<<mathgrade<<" "<<chinesegrade<<" "<<englishgrade;
        student_mh.insert(mathgrade);
        student_ch.insert(chinesegrade);
        student_eh.insert(englishgrade);
        int sum = mathgrade + chinesegrade + englishgrade;
        student_h.insert(sum);
    }
    else if (a == 7)
    {
        flag_search = 0;
        printf("即将退出该系统\n");
        break;
    }
    else
    {
        printf("输入有误，请重新输入\n");
        break;
    }

    system("pause");//暂停黑窗口
    system("Cls");//清除屏幕输出
    }
}


void input()
{
    //输入，并根据输入选项进行相应的输出
    initSize = 0;//初始化数组元素个数
    cin >> choose;
    if (choose == 'a')
    {
        printf("建立小大根交替堆：\n");
        printf("请输入小大根交替堆的堆元素:\n");
        getchar();
        while (1)
        {
        scanf("%d", &a);
        c = getchar();
        Array[++initSize] = a;//初始化数组
        if (c == '\n')
            break;
            }
        h.initialize(Array, initSize);
        cout <<endl<< "建立的小大根交替堆如下：" <<endl<< h <<endl;
    }
    else if (choose == 'b')
    {
        printf("请输入插入元素：");
        scanf("%d", &a);
        h.insert(a);
    }
    else if (choose == 'c')
    {
        a = h.popmax();
        printf("删除最大值，删除元素为%d\n", a);
    }
    else if (choose == 'd')
    {
        a = h.popmin();
        printf("删除最小值，删除元素为%d\n", a);
    }
    else if (choose == 'e')
    {
        cout << "得到最小值：" << endl;
        h.getmin();
    }
    else if (choose == 'f')
    {
        cout << " 得到最大值：" << endl;
        h.getmax();
    }
    else if (choose == 'g')
    {
        initial();
        while (1)
        {
            studentInfoQuery();
            if (flag_search == 0)
                break;
        }
    }
    else  if (choose == 'h')
    {
        printf("即将退出该系统\n");
        return;
    }
    else
        printf("选择有误，请重新输入\n");
    }


int main()
{
    while(1)
    {
        menu();//菜单显示
        input();//输入，并根据输入选项进行相应的输出
        if (choose == 'h')
        {
            break;
        }
    system("pause");//暂停黑窗口
    system("Cls");//清除屏幕输出
    }

return 0;
}
