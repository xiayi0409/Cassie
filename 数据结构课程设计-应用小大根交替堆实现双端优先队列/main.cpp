#include"min_max_heap.h"
#include"student.h"
#include<string.h>
#include<iostream>
#include<fstream>
#include<vector>
#include<cstdio>
using namespace std;

vector<student> students;//ѧ����Ϣ
min_max_heap<int> student_mh(50);//ѧ����ѧ�ɼ���Ϣ��
min_max_heap<int> student_eh(50);//ѧ��Ӣ��ɼ���Ϣ��
min_max_heap<int> student_ch(50);//ѧ�����ĳɼ���Ϣ��
min_max_heap<int> student_h(50);//ѧ���ܳɼ���Ϣ��
min_max_heap<int> h(50);//С�������Ѳ��Զ�

//��ͬ���е������Ա����ʼ����ʱ�������Լ�Ԫ����
int ArrayHeapm[100], Arraym[100], flag_search, a, initSizem = 0;//��ʼ����ʱ�����鼰Ԫ����
int ArrayHeape[100], Arraye[100], initSizee = 0;
int ArrayHeapc[100], Arrayc[100], initSizec = 0;
int ArrayHeap[100], Array[100], initSize = 0;

char choose, c;//�û��Ĺ���ѡ��


void initial()
 //����ѧ����Ϣ
{
    ifstream file("information.txt");//�ļ�����һ���ɼ��ܴ������Ϊ��ʼ�������
    if (file.fail())
    {
        printf("�ļ���ʧ�ܣ�\n");
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
        cout << "��ѧ����ѧ�ɼ�����С�������Ѳ����ϵ����Ĺ������£�"<<endl;
        student_mh.initialize(ArrayHeapm, initSizem);
        cout<<endl<<endl<<endl;
        cout << "��ѧ�����ĳɼ�����С�������Ѳ����ϵ����Ĺ������£�" << endl;
        student_ch.initialize(ArrayHeapc, initSizec);
        cout<<endl<<endl<<endl;
        cout << "��ѧ��Ӣ��ɼ�����С�������Ѳ����ϵ����Ĺ������£�" << endl;
        student_eh.initialize(ArrayHeape, initSizee);
        cout<<endl<<endl<<endl;
        cout << "��ѧ���ֳܷɼ�����С�������Ѳ����ϵ����Ĺ������£�" << endl;
        student_h.initialize(ArrayHeap, initSize);
    }
}


void menu()
//�˵���ʾ
{
    printf("****С��������ʵ��˫�����ȶ���****\n");
    printf("* a-����С��������\n");
    printf("* b-����Ԫ��\n");
    printf("* c-ɾ�����ֵ\n");
    printf("* d-ɾ����Сֵ\n");
    printf("* e-�����Сֵ\n");
    printf("* f-������ֵ\n");
    printf("* g-����ѧ���ɼ���ѧ����Ϣ�Ĳ�ѯ\n");
    printf("* h-�˳�\n");
    printf("************************************\n");
}

void studentInfoQuery()
{
    flag_search = 1;
    while (flag_search)
    {
        printf("****С��������ʵ�ֵ�ѧ���ɼ�����ϵͳ****\n");
        printf("* 1-�������ѧ������Ϣ\n");
        printf("* 2-��ѯ�ɼ���ߵ�ѧ����Ϣ\n");
        printf("* 3-��ѯ�ɼ���͵�ѧ����Ϣ\n");
        printf("* 4-ͨ������ĳɼ����в�ѯ\n");
        printf("* 5-���ѧ���ɼ���ƽ��ֵ\n");
        printf("* 6-���ѧ����Ϣ\n");
        printf("* 7-�˳�\n");
        printf("*****************************************\n");
        getchar();
        scanf("%d", &a);
        int count, max, min;
        if (a == 2)//��ѯ��߳ɼ�ѧ������Ϣ
        {
            cout << "ѡ���ѯ�Ŀ�Ŀ��1����ѧ  2��Ӣ�� 3������ 4���ܷ�"<<endl;
            int k;
            cin >> k;
            if (k == 1)
            {
                cout << "��ѧ��߳ɼ�Ϊ��" << endl;
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
                            << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                            << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                            << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                            << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
                if (count == 0)
                    printf("û����ѧ��߳ɼ���ͬѧ\n");
            }
            if (k == 2)
            {
                cout << "Ӣ����߳ɼ�Ϊ��" << endl;
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
                            << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                            << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                            << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                            << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
            if (count == 0)
                printf("û��Ӣ����߳ɼ���ͬѧ\n");
            }
            if (k == 3)
            {
                cout << "������߳ɼ�Ϊ��" << endl;
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
                        << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                        << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                        << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                        << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                    }
                }
                if (count == 0)
                    printf("û��������߳ɼ���ͬѧ\n");
            }
        if (k == 4)
        {
            cout << "�ܷ���߳ɼ�Ϊ��" << endl;
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
                    << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                    << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                    << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                    << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
        if (count == 0)
            printf("û���ܷ���߳ɼ���ͬѧ\n");
        }
    }
    else if (a == 3)//��ѯ��ͳɼ�ѧ������Ϣ
    {
        cout << "ѡ���ѯ�Ŀ�Ŀ��1����ѧ  2��Ӣ�� 3������ 4���ܷ�"<<endl;
        int k;
        cin >> k;
        if (k == 1)
        {
            cout << "��ѧ��ͳɼ�Ϊ��" << endl;
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
                    << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                    << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                    << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                    << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
            if (count == 0)
                printf("û����ѧ��ͳɼ���ͬѧ\n");
        }
        if (k == 2)
        {
            cout << "Ӣ����ͳɼ�Ϊ��" << endl;
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
                    << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                    << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                    << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                    << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
            if (count == 0)
                printf("û��Ӣ����ͳɼ���ͬѧ\n");
        }
        if (k == 3)
        {
            cout << "������ͳɼ�Ϊ��" << endl;
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
                << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
            }
        }
        if (count == 0)
            printf("û��������ͳɼ���ͬѧ\n");
        }
        if (k == 4)
        {
            cout << "�ܷ���ͳɼ�Ϊ��" << endl;
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
                    << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                    << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                    << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                    << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade()<<endl;
                }
            }
        if (count == 0)
            printf("û���ܷ���ͳɼ���ͬѧ\n");
        }
    }
    else if (a == 4)//��������ɼ����в�ѯ
    {
        while (1)
        {
            cout << "ѡ���ѯ�Ŀ�Ŀ��1����ѧ  2��Ӣ�� 3������ 4���ܷ�"<<endl;
            int k;
            cin >> k;
            printf("����ѧ���ɼ�(����-1������ѯ):");
            scanf("%d", &a);
            if (k == 1)
            {
                if (a == -1)
                    break;
                if (a < 0 || a>100)
                {
                    printf("��������ĳɼ��Ƿ���ȷ\n");
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
                        << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                        << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                        << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                        << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
                    }
                }
                if (count == 0)
                    printf("û�д˳ɼ���ͬѧ\n");
            }
            if (k == 2)
            {
                if (a == -1)
                    break;
            if (a < 0 || a>100)
            {
                printf("��������ĳɼ��Ƿ���ȷ\n");
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
                    << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                    << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                    << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                    << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
                }
            }
            if (count == 0)
                printf("û�д˳ɼ���ͬѧ\n");
            }
    if (k == 3)
    {
        if (a == -1)
            break;
        if (a < 0 || a>100)
        {
            printf("��������ĳɼ��Ƿ���ȷ\n");
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
                << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
        }
        if (count == 0)
            printf("û�д˳ɼ���ͬѧ\n");
    }
    if (k == 4)
    {
        if (a == -1)
            break;
        cout << "�ܳɼ�����߳ɼ�Ϊ��";
        max = student_h.getmax();
        cout << "�ܳɼ�����ͳɼ�Ϊ��";
        min = student_h.getmin();
        if (a < min || a>max)
        {
            printf("��������ĳɼ��Ƿ���ȷ\n");
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
                << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
        }
        if (count == 0)
            printf("û�д˳ɼ���ͬѧ\n");
    }
    }
    }
    else if (a == 1)//�������ѧ������Ϣ
    {
            printf("����ѧ������Ϣ����:\n\n");

            for (int i = 0; i <= initSize-1; i++)
            {
                cout << students.at(i).getStudentId() << " "
                << students.at(i).getName() << " "
                << students.at(i).getSex() << " "
                << students.at(i).getBirthDate() << " "
                << students.at(i).getBirthPlace() << " "
                << students.at(i).getTelephone() << " "
                << "��ѧ�ɼ���" << students.at(i).getmathGrade() << " "
                << "���ĳɼ���" << students.at(i).getchineseGrade() << " "
                << "Ӣ��ɼ���" << students.at(i).getenglishGrade() << " "
                << "�ܷ֣�" << students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() << endl;
            }
    }
    else if (a == 5)//���ѧ���ɼ���ƽ��ֵ
    {
            cout << "ѡ���ѯ�Ŀ�Ŀ��1����ѧ  2��Ӣ�� 3������ 4���ܷ�"<<endl;
            int k;
            cin >> k;
            if (k == 1)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getmathGrade();
                }
                cout<<"��ѧ�ɼ���ƽ��ֵΪ��"<<(chengji/students.size())<<endl;
            }
            else if( k == 2 )
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getenglishGrade();
                }
                cout<<"Ӣ��ɼ���ƽ��ֵΪ��"<<chengji/students.size()<<endl;
            }
            else if( k == 3)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getchineseGrade();
                }
                cout<<"���ĳɼ���ƽ��ֵΪ��"<<chengji/students.size()<<endl;
            }
            else if ( k == 4)
            {
                float chengji=0.0;
                for (int i = 0; i < initSize; i++)
                {
                    chengji+=students.at(i).getchineseGrade() + students.at(i).getmathGrade() + students.at(i).getenglishGrade() ;
                }
                cout<<"�ֵܷ�ƽ��ֵΪ��"<<chengji/students.size()<<endl;
            }
    }
    else if (a == 6)//���ѧ����Ϣ
    {
        cout << "�������д��ѧ����ѧ����Ϣ����ѧ��ѧ�ţ�ѧ��������ѧ���Ա�ѧ���������£������أ�ѧ���绰����ѧ�ɼ������ĳɼ���Ӣ��ɼ���˳��д��";
        char name[50];
        char telephone[12];
        char studentID[20];
        char birthDate[20];
        char birthPlace[100];
        char sex[3];
        int mathgrade, chinesegrade, englishgrade;
        cin >> studentID >>  name >> sex >> birthDate >> birthPlace >> telephone >> mathgrade >> chinesegrade>>englishgrade;
        ofstream outfile("information.txt",ios::app);//д���ļ�
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
        printf("�����˳���ϵͳ\n");
        break;
    }
    else
    {
        printf("������������������\n");
        break;
    }

    system("pause");//��ͣ�ڴ���
    system("Cls");//�����Ļ���
    }
}


void input()
{
    //���룬����������ѡ�������Ӧ�����
    initSize = 0;//��ʼ������Ԫ�ظ���
    cin >> choose;
    if (choose == 'a')
    {
        printf("����С�������ѣ�\n");
        printf("������С�������ѵĶ�Ԫ��:\n");
        getchar();
        while (1)
        {
        scanf("%d", &a);
        c = getchar();
        Array[++initSize] = a;//��ʼ������
        if (c == '\n')
            break;
            }
        h.initialize(Array, initSize);
        cout <<endl<< "������С�����������£�" <<endl<< h <<endl;
    }
    else if (choose == 'b')
    {
        printf("���������Ԫ�أ�");
        scanf("%d", &a);
        h.insert(a);
    }
    else if (choose == 'c')
    {
        a = h.popmax();
        printf("ɾ�����ֵ��ɾ��Ԫ��Ϊ%d\n", a);
    }
    else if (choose == 'd')
    {
        a = h.popmin();
        printf("ɾ����Сֵ��ɾ��Ԫ��Ϊ%d\n", a);
    }
    else if (choose == 'e')
    {
        cout << "�õ���Сֵ��" << endl;
        h.getmin();
    }
    else if (choose == 'f')
    {
        cout << " �õ����ֵ��" << endl;
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
        printf("�����˳���ϵͳ\n");
        return;
    }
    else
        printf("ѡ����������������\n");
    }


int main()
{
    while(1)
    {
        menu();//�˵���ʾ
        input();//���룬����������ѡ�������Ӧ�����
        if (choose == 'h')
        {
            break;
        }
    system("pause");//��ͣ�ڴ���
    system("Cls");//�����Ļ���
    }

return 0;
}
