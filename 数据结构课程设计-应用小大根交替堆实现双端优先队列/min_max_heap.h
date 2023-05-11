#pragma once
#include<iostream>
#include<string>
#include<sstream>
#include<math.h>
#include <algorithm>
#include <iomanip>
using namespace std;
#define MAXN 0x3f3f3f3f


int parent(int i) { return i / 2; }   //�±�Ϊi��Ԫ�صĸ��׽ڵ�
int left_child(int i) { return 2 * i; }   //�±�Ϊi��Ԫ�ص�����
int right_child(int i) { return 2 * i + 1; }   //�±�Ϊi��Ԫ�ص��Һ���

int flagprint = true;

int downcount;   //���˵Ĵ���
int upcount;   //���˵Ĵ���


template<class T>
class Two_terminal_priority_queue
//˫�����ȼ�����
{
    public:
        virtual ~Two_terminal_priority_queue() {};
        virtual bool empty() = 0;   //����Ϊ���򷵻�true
        virtual int size() = 0;   //���е�Ԫ�ظ���
        virtual T& getmax() = 0;   //���Ԫ�صĻ�ȡ
        virtual T& getmin() = 0;   //��СԪ�صĻ�ȡ
        virtual T& popmax() = 0;   //ɾ�����Ԫ��
        virtual T& popmin() = 0;   //ɾ����СԪ��
        virtual void insert(T& theElement) = 0;   //����Ԫ��
};

template<class T>
void changeArrayLength(T*& a, int oldLength, int newLength)
//��������
{
    T* temp = new T[newLength];   //������
    copy(a, a + oldLength, temp);
    delete[] a;
    a = temp;
}

template<class T>
//С��������ʵ���µ�˫�����ȼ�����
class min_max_heap :Two_terminal_priority_queue<T>
{
    public:
    min_max_heap(int initial = 50)
    {//���캯��,��ʼ����50����
        if (initial < 1)
        {//��ʼ��С�������0
        ostringstream s;
        s << "���󣺳�ʼ����" << initial<< " ����> 0";
        throw s.str();
        }
        arrayLength = initial + 1;
        heap = new T[arrayLength];
        heapsize = 0;
    }

    ~min_max_heap() { delete[] heap; }//������

    bool empty()
    {
        return heapsize == 0;
    }//�ж϶ѿ�

    int size()
    {
        return heapsize;
    }//��ȡ��ǰ�ѵ�ʵ�ʴ�С

    T* getheap()
    {
        return heap;
    }//��ȡ��ǰ��

    void initialize(T* theheap, int thesize);//������֪���齨��
    T& getmax();//���Ԫ�صĻ�ȡ
    T& getmin();//��СԪ�صĻ�ȡ
    T& popmax();//ɾ�����Ԫ��
    T& popmin();//ɾ����СԪ��
    void insert(T& theElement);//����Ԫ��
    void output(ostream& out);//���

    T* heap;//������
    int heapsize;//�ѵ�ʵ�ʴ�С
    int arrayLength;//�ѵ�����
};


template<class T>
int find_min_child_grandchild(min_max_heap<T>* h, int i)
//�ҳ��±�Ϊi�Ľ��Ķ��Ӻ���������С��ֵ
{
    int cl = left_child(i);//�±�Ϊi�Ľڵ������
    int cr = right_child(i);//�±�Ϊi�Ľڵ���Һ���
    int cll = left_child(cl);//���ӵ�����
    int clr = right_child(cl);//���ӵ��Һ���
    int crl = left_child(cr);//�Һ��ӵ�����
    int crr = right_child(cr);//�Һ��ӵ��Һ���
    int minn = -1;
    if (cl <= h->heapsize)
        minn = cl;
    if (cr <= h->heapsize && h->heap[cr] < h->heap[minn])
        minn = cr;
    if (cll <= h->heapsize && h->heap[cll] < h->heap[minn])
        minn = cll;
    if (clr <= h->heapsize && h->heap[clr] < h->heap[minn])
        minn = clr;
    if (crl <= h->heapsize && h->heap[crl] < h->heap[minn])
        minn = crl;
    if (crr <= h->heapsize && h->heap[crr] < h->heap[minn])
        minn = crr;
    return minn;
}

template<class T>
int find_max_child_grandchild(min_max_heap<T>* h, int i)
//�ҳ��±�Ϊi�Ľ��Ķ��Ӻ�����������ֵ
{
    int cl = left_child(i);//�±�Ϊi�Ľڵ������
    int cr = right_child(i);//�±�Ϊi�Ľڵ���Һ���
    int cll = left_child(cl);//���ӵ�����
    int clr = right_child(cl);//���ӵ��Һ���
    int crl = left_child(cr);//�Һ��ӵ�����
    int crr = right_child(cr);//�Һ��ӵ��Һ���
    int maxx = -1;
    if (cl <= h->heapsize)
        maxx = cl;
    if (cr <= h->heapsize && h->heap[cr] > h->heap[maxx])
        maxx = cr;
    if (cll <= h->heapsize && h->heap[cll] > h->heap[maxx])
        maxx = cll;
    if (clr <= h->heapsize && h->heap[clr] > h->heap[maxx])
        maxx = clr;
    if (crl <= h->heapsize && h->heap[crl] > h->heap[maxx])
        maxx = crl;
    if (crr <= h->heapsize && h->heap[crr] > h->heap[maxx])
        maxx = crr;
    return maxx;
}


template<class T>
void swap(min_max_heap<T>* h, int i, int j)
//���������±�Ϊi��j������
{
    T temp = h->heap[i];
    h->heap[i] = h->heap[j];
    h->heap[j] = temp;
    if (flagprint)
        cout  << "�Ե�ǰ�ѽ��е���ʹ���ΪС��������h:\n" << *h << endl;
}

template<class T>
void TrickleDownMin(min_max_heap<T>* h, int i)
//С��Ԫ�����˲�������֤�ṹΪ��С��Ԫ��Ϊ����С����
{
    int m = find_min_child_grandchild(h, i);//��С��Ԫ�صĶ��Ӻ������е���Сֵ
    if (m <= -1)
    {
        return;
    }
    else
    {
        if (m > right_child(i))
        {//���������С
            if (h->heap[m] < h->heap[i])
        {
        swap(h, i, m);
        if (h->heap[m] > h->heap[parent(m)])
            swap(h, m, parent(m));
        TrickleDownMin(h, m);
    }
}
        else
            {//���������С
                if (h->heap[m] < h->heap[i])
                swap(h, i, m);
            }
    }
}


template<class T>
void TrickleDownMax(min_max_heap<T>* h, int i)
//���Ԫ�����˲�������֤�ṹΪ�Դ��Ԫ��Ϊ���Ĵ����
{
    int m = find_max_child_grandchild(h, i);//�ô��Ԫ�صĶ��Ӻ������е����ֵ
    if (m <= -1)
    {
        return;
    }
    else
    {
        if (m > right_child(i))
        {//����������
            if (h->heap[m] > h->heap[i])
            {
                swap(h, i, m);
                if (h->heap[m] < h->heap[parent(m)])
                    swap(h, m, parent(m));
                TrickleDownMin(h, m);
            }
            }
        else
        {//����������
            if (h->heap[m] > h->heap[i])
                swap(h, i, m);
        }
    }
}


template<class T>
void BubbleUpMin(min_max_heap<T>* h, int i)
//С��Ԫ�����˲���
{
    int pp = parent(parent(i));
    if (pp <= 0) return;
    if (h->heap[i] < h->heap[pp])
    {//����游���Լ����򽻻�
        swap(h, i, pp);
        BubbleUpMin(h, pp);
    }
}


template<class T>
void BubbleUpMax(min_max_heap<T>* h, int i)
//���Ԫ�����˲���
{
    int pp = parent(parent(i));
    if (pp <= 0) return;
    if (h->heap[i] > h->heap[pp])
    {//����游���Լ�С�򽻻�
        swap(h, i, pp);
        BubbleUpMax(h, pp);
    }
}

int level(int i)
{//�����±�Ϊi���������ڴ�㻹��С��
//	if((int)(floor(log(i)/log(2)))%2)//floor����ȡ��
//��2Ϊ�׵Ķ���
//�������ֵ�����ڲ���
    if ((int)(floor(log(i) / log(2))) % 2)
        return 0; //���Ԫ��
    else
        return 1; //С��Ԫ��
}


template<class T>
void TrickleDown(min_max_heap<T>* h, int i)
//���ˣ�����ɾ��
{
    downcount = 0;
    if (level(i))
    {//ɾ����СԪ��
        TrickleDownMin(h, i);
    }
    else
    {//ɾ�������Ԫ��
        TrickleDownMax(h, i);
    }
}


template<class T>
void BubbleUp(min_max_heap<T>* h, int i)
//���ˣ������ڲ���
{
    upcount = 0;
    int p = parent(i);
    if (p <= 0)
        return;
    if (level(i))
    {//�����С�㣬���и��׽ڵ����Լ���ֵ��С�Ƚ�
        if (h->heap[i] > h->heap[p])
        {//�����ڵ�С���򽻻��������д������
            swap(h, i, p);
        BubbleUpMax(h, p);
        }
        else
        {//������ڵ�������С������
            BubbleUpMin(h, i);
        }
    }
    else
    {//�����Ǵ��
        if (h->heap[i] < h->heap[p])
        {//�����׽ڵ�����Լ����򽻻���������С������
            swap(h, i, p);
        BubbleUpMin(h, p);
        }
        else
        {//�����׽ڵ�С���Լ������д�㽻��
            BubbleUpMax(h, i);
        }
    }
}


template<class T>
void min_max_heap<T>::initialize(T* theheap, int theSize)
//С�������ѳ�ʼ��,������֪���齨��
{
    delete[] heap;
    heap = theheap;
    heapsize = theSize;
    if (flagprint)
        cout << *this << endl;
    for (int root = heapsize / 2; root >= 1; root--)
    {
        TrickleDown(this, root);
    }
}


template<class T>
T& min_max_heap<T>::getmax()
//�������ֵ
{
    static int m;
    if (heapsize == 1)
    {
    //����ֻ����һ��Ԫ�أ����ֵΪ���Ԫ��
        cout << heap[1] << endl;
        return heap[1];
    }
    if (heapsize == 2)
    {
    //����ֻ��������Ԫ�أ�����ȡ�ڶ���Ԫ��
        cout << heap[2] << endl;
        return heap[2];
    }
    if (heapsize > 2)
    {//�Ƚ�heap[2]��heap[3]
            m = max(heap[2], heap[3]);
            cout << m << endl;
            return m;
    }
    else
        cout << "��ǰΪ�նѣ�û�����ֵ" << endl;
}


template<class T>
T& min_max_heap<T>::getmin()
//������Сֵ�������ڵ�
{
    if (heapsize > 0)
    {
        cout << heap[1] << endl;
        return heap[1];
    }
    else
        throw  "��ǰΪ�նѣ�û����Сֵ\n" ;
}


template<class T>
T& min_max_heap<T>::popmin()
//ɾ����Сֵ
{
    if (flagprint)
    cout << "ɾ����Сֵ����" << endl;
    if (heapsize == 1)
    {//ֻ��һ��Ԫ�أ���ɾ�����Ϊ��"
        if(flagprint)
            cout << "ֻ��һ��Ԫ�أ���ɾ�����Ϊ��" << endl;
        heapsize--;
    return heap[1];
    }
    else if (heapsize > 1)
    {
        static T temp = heap[1];
        heap[1] = heap[heapsize--];
        TrickleDown(this, 1);
        return temp;
    }
    else
        throw "��ǰΪ�նѣ�����ɾ����Сֵ\n";
}


template<class T>
T& min_max_heap<T>::popmax()
//ɾ�����ֵ
{
    if (flagprint)
    cout << "ɾ�����ֵ����" << endl;
    if (heapsize == 1)
    {//ֻ��һ��Ԫ�أ�ɾ�����Ϊ��
        if (flagprint)
            cout << "ֻ��һ��Ԫ�أ���ɾ�����Ϊ��" << endl;
        heapsize--;
        return heap[1];
    }
        if (heapsize == 2)
        {//����Ԫ�أ�����heap[2]����
            if (flagprint)
                cout << "����Ԫ�أ�����heap[2]����" << endl;
            heapsize--;
            return heap[2];
        }
        if (heapsize > 2)
        {
            int index = 2;
            if (heap[2] < heap[3]) index = 3;
                static T d = heap[index];
            heap[index] = heap[heapsize--];
            TrickleDown(this, index);
            return d;
        }
        else
            cout << "��ǰ�ṹΪ�նѣ�û����Сֵ" << endl;
}


template<class T>
void min_max_heap<T>::insert(T& Element)
//����Ԫ��
{
    //��������������ĳ���
    if (flagprint)
    {
        cout << "�������-����";
        cout << Element;
        cout << ":" << endl;
    }
    if (heapsize == arrayLength - 1)
    {
        changeArrayLength(heap, arrayLength, 2 * arrayLength);
        arrayLength *= 2;
    }
    int currentNode = ++heapsize;
    heap[currentNode] = Element;
    if (flagprint)
        cout << "h:\n" << *this << endl;
    BubbleUp(this, currentNode);
}


template<class T>
void min_max_heap<T>::output(ostream& out)
//�����Ԫ��
{
    if (heapsize == 0)
        cout << "��ǰ�ǿն�" << endl;
    int high = (int)(floor(log(heapsize) / log(2)));//�ѵĸ߶�
    int bottle_node_count_max = pow(2, high);//���²�������ӵ�еĽ����
    T** heapMatrix = new T * [(high + 1) * 2];//��ά���飬Ϊ�˲���б�ܣ�ָ��ά����������
    for (int i = 0; i < (high + 1) * 2; i++)
    {
        heapMatrix[i] = new T[bottle_node_count_max * 2];
    }
    T* t = new T(MAXN);//��ʼ��
    for (int i = 0; i < (high + 1) * 2; i++)
        for (int j = 0; j < bottle_node_count_max * 2; j++)
            heapMatrix[i][j] = *t;
            //�����е�ֵд�����
        int index = 1,level=0;
        bool flag;//�ж����߻���Ԫ�ص�λ��
        while (level < high + 1)
        {
            flag = true;
            //����������֮��ľ���
            int inscrease = bottle_node_count_max*2/pow(2, level);
            for (int j = inscrease / 2; j < bottle_node_count_max * 2; j += inscrease)
            {
                if (index <= heapsize)
                {
                    heapMatrix[(level + 1) * 2 - 1][j] = heap[index++];
                    if (flag)
                        heapMatrix[level * 2][j + 1] = MAXN - 1;
                    else
                        heapMatrix[level * 2][j] = MAXN - 2;
                    flag = !flag;
                }
            }
        level++;
    }

    //���

    for (int i = 1; i < (high + 1) * 2; i++)
    {
        for (int j = 0; j < bottle_node_count_max * 2; j++)
        {
            if (heapMatrix[i][j] == *t)
                cout << "    ";
            else if (heapMatrix[i][j] == MAXN - 1)
                cout << "/   ";
            else if (heapMatrix[i][j] == MAXN - 2)
                cout << " \\  ";
            else
                cout << setw(4) << heapMatrix[i][j];
        }
    cout << endl;
    }

    for (int i = 0; i < high + 1; i++)
        delete[] heapMatrix[i];
    delete[] heapMatrix;
}


template<class T>
ostream& operator<<(ostream& out, min_max_heap<T>& x)
{//<<���������
    x.output(out);
    out << endl;
    return out;
}
