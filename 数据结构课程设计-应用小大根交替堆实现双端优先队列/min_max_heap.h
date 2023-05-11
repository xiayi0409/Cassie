#pragma once
#include<iostream>
#include<string>
#include<sstream>
#include<math.h>
#include <algorithm>
#include <iomanip>
using namespace std;
#define MAXN 0x3f3f3f3f


int parent(int i) { return i / 2; }   //下标为i的元素的父亲节点
int left_child(int i) { return 2 * i; }   //下标为i的元素的左孩子
int right_child(int i) { return 2 * i + 1; }   //下标为i的元素的右孩子

int flagprint = true;

int downcount;   //下滤的次数
int upcount;   //上滤的次数


template<class T>
class Two_terminal_priority_queue
//双端优先级队列
{
    public:
        virtual ~Two_terminal_priority_queue() {};
        virtual bool empty() = 0;   //队列为空则返回true
        virtual int size() = 0;   //队列的元素个数
        virtual T& getmax() = 0;   //最大元素的获取
        virtual T& getmin() = 0;   //最小元素的获取
        virtual T& popmax() = 0;   //删除最大元素
        virtual T& popmin() = 0;   //删除最小元素
        virtual void insert(T& theElement) = 0;   //插入元素
};

template<class T>
void changeArrayLength(T*& a, int oldLength, int newLength)
//数组扩容
{
    T* temp = new T[newLength];   //新数组
    copy(a, a + oldLength, temp);
    delete[] a;
    a = temp;
}

template<class T>
//小大根交替堆实现下的双端优先级队列
class min_max_heap :Two_terminal_priority_queue<T>
{
    public:
    min_max_heap(int initial = 50)
    {//构造函数,初始构造50容量
        if (initial < 1)
        {//初始大小必须大于0
        ostringstream s;
        s << "错误：初始容量" << initial<< " 必须> 0";
        throw s.str();
        }
        arrayLength = initial + 1;
        heap = new T[arrayLength];
        heapsize = 0;
    }

    ~min_max_heap() { delete[] heap; }//析构堆

    bool empty()
    {
        return heapsize == 0;
    }//判断堆空

    int size()
    {
        return heapsize;
    }//获取当前堆的实际大小

    T* getheap()
    {
        return heap;
    }//获取当前堆

    void initialize(T* theheap, int thesize);//根据已知数组建堆
    T& getmax();//最大元素的获取
    T& getmin();//最小元素的获取
    T& popmax();//删除最大元素
    T& popmin();//删除最小元素
    void insert(T& theElement);//插入元素
    void output(ostream& out);//输出

    T* heap;//堆数组
    int heapsize;//堆的实际大小
    int arrayLength;//堆的容量
};


template<class T>
int find_min_child_grandchild(min_max_heap<T>* h, int i)
//找出下标为i的结点的儿子和孙子中最小的值
{
    int cl = left_child(i);//下标为i的节点的左孩子
    int cr = right_child(i);//下标为i的节点的右孩子
    int cll = left_child(cl);//左孩子的左孩子
    int clr = right_child(cl);//左孩子的右孩子
    int crl = left_child(cr);//右孩子的左孩子
    int crr = right_child(cr);//右孩子的右孩子
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
//找出下标为i的结点的儿子和孙子中最大的值
{
    int cl = left_child(i);//下标为i的节点的左孩子
    int cr = right_child(i);//下标为i的节点的右孩子
    int cll = left_child(cl);//左孩子的左孩子
    int clr = right_child(cl);//左孩子的右孩子
    int crl = left_child(cr);//右孩子的左孩子
    int crr = right_child(cr);//右孩子的右孩子
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
//交换堆中下标为i和j的数据
{
    T temp = h->heap[i];
    h->heap[i] = h->heap[j];
    h->heap[j] = temp;
    if (flagprint)
        cout  << "对当前堆进行调整使其成为小大根交替堆h:\n" << *h << endl;
}

template<class T>
void TrickleDownMin(min_max_heap<T>* h, int i)
//小层元素下滤操作，保证结构为以小层元素为根的小根堆
{
    int m = find_min_child_grandchild(h, i);//该小层元素的儿子和孙子中的最小值
    if (m <= -1)
    {
        return;
    }
    else
    {
        if (m > right_child(i))
        {//如果孙子最小
            if (h->heap[m] < h->heap[i])
        {
        swap(h, i, m);
        if (h->heap[m] > h->heap[parent(m)])
            swap(h, m, parent(m));
        TrickleDownMin(h, m);
    }
}
        else
            {//如果儿子最小
                if (h->heap[m] < h->heap[i])
                swap(h, i, m);
            }
    }
}


template<class T>
void TrickleDownMax(min_max_heap<T>* h, int i)
//大层元素下滤操作，保证结构为以大层元素为根的大根堆
{
    int m = find_max_child_grandchild(h, i);//该大层元素的儿子和孙子中的最大值
    if (m <= -1)
    {
        return;
    }
    else
    {
        if (m > right_child(i))
        {//如果孙子最大
            if (h->heap[m] > h->heap[i])
            {
                swap(h, i, m);
                if (h->heap[m] < h->heap[parent(m)])
                    swap(h, m, parent(m));
                TrickleDownMin(h, m);
            }
            }
        else
        {//如果儿子最大
            if (h->heap[m] > h->heap[i])
                swap(h, i, m);
        }
    }
}


template<class T>
void BubbleUpMin(min_max_heap<T>* h, int i)
//小层元素上滤操作
{
    int pp = parent(parent(i));
    if (pp <= 0) return;
    if (h->heap[i] < h->heap[pp])
    {//如果祖父比自己大，则交换
        swap(h, i, pp);
        BubbleUpMin(h, pp);
    }
}


template<class T>
void BubbleUpMax(min_max_heap<T>* h, int i)
//大层元素上滤操作
{
    int pp = parent(parent(i));
    if (pp <= 0) return;
    if (h->heap[i] > h->heap[pp])
    {//如果祖父比自己小则交换
        swap(h, i, pp);
        BubbleUpMax(h, pp);
    }
}

int level(int i)
{//返回下标为i的数据属于大层还是小层
//	if((int)(floor(log(i)/log(2)))%2)//floor向下取整
//以2为底的对数
//最大整数值不大于参数
    if ((int)(floor(log(i) / log(2))) % 2)
        return 0; //大层元素
    else
        return 1; //小层元素
}


template<class T>
void TrickleDown(min_max_heap<T>* h, int i)
//下滤，用于删除
{
    downcount = 0;
    if (level(i))
    {//删除最小元素
        TrickleDownMin(h, i);
    }
    else
    {//删除了最大元素
        TrickleDownMax(h, i);
    }
}


template<class T>
void BubbleUp(min_max_heap<T>* h, int i)
//上滤，可用于插入
{
    upcount = 0;
    int p = parent(i);
    if (p <= 0)
        return;
    if (level(i))
    {//如果是小层，进行父亲节点与自己的值大小比较
        if (h->heap[i] > h->heap[p])
        {//若父节点小，则交换，并进行大层上滤
            swap(h, i, p);
        BubbleUpMax(h, p);
        }
        else
        {//如果父节点大则进行小层上滤
            BubbleUpMin(h, i);
        }
    }
    else
    {//否则是大层
        if (h->heap[i] < h->heap[p])
        {//若父亲节点大于自己，则交换，并进行小层上滤
            swap(h, i, p);
        BubbleUpMin(h, p);
        }
        else
        {//否则父亲节点小于自己，进行大层交换
            BubbleUpMax(h, i);
        }
    }
}


template<class T>
void min_max_heap<T>::initialize(T* theheap, int theSize)
//小大根交替堆初始化,根据已知数组建堆
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
//返回最大值
{
    static int m;
    if (heapsize == 1)
    {
    //堆中只含有一个元素，最大值为这个元素
        cout << heap[1] << endl;
        return heap[1];
    }
    if (heapsize == 2)
    {
    //堆中只含有两个元素，所以取第二个元素
        cout << heap[2] << endl;
        return heap[2];
    }
    if (heapsize > 2)
    {//比较heap[2]和heap[3]
            m = max(heap[2], heap[3]);
            cout << m << endl;
            return m;
    }
    else
        cout << "当前为空堆，没有最大值" << endl;
}


template<class T>
T& min_max_heap<T>::getmin()
//返回最小值，即根节点
{
    if (heapsize > 0)
    {
        cout << heap[1] << endl;
        return heap[1];
    }
    else
        throw  "当前为空堆，没有最小值\n" ;
}


template<class T>
T& min_max_heap<T>::popmin()
//删除最小值
{
    if (flagprint)
    cout << "删除最小值操作" << endl;
    if (heapsize == 1)
    {//只有一个元素，故删除后堆为空"
        if(flagprint)
            cout << "只有一个元素，故删除后堆为空" << endl;
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
        throw "当前为空堆，不能删除最小值\n";
}


template<class T>
T& min_max_heap<T>::popmax()
//删除最大值
{
    if (flagprint)
    cout << "删除最大值操作" << endl;
    if (heapsize == 1)
    {//只有一个元素，删除后堆为空
        if (flagprint)
            cout << "只有一个元素，故删除后堆为空" << endl;
        heapsize--;
        return heap[1];
    }
        if (heapsize == 2)
        {//两个元素，返回heap[2]即可
            if (flagprint)
                cout << "两个元素，返回heap[2]即可" << endl;
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
            cout << "当前结构为空堆，没有最小值" << endl;
}


template<class T>
void min_max_heap<T>::insert(T& Element)
//插入元素
{
    //堆满，增加数组的长度
    if (flagprint)
    {
        cout << "插入操作-插入";
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
//输出堆元素
{
    if (heapsize == 0)
        cout << "当前是空堆" << endl;
    int high = (int)(floor(log(heapsize) / log(2)));//堆的高度
    int bottle_node_count_max = pow(2, high);//最下层最多可以拥有的结点数
    T** heapMatrix = new T * [(high + 1) * 2];//二维数组，为了插入斜杠，指针维度扩大两倍
    for (int i = 0; i < (high + 1) * 2; i++)
    {
        heapMatrix[i] = new T[bottle_node_count_max * 2];
    }
    T* t = new T(MAXN);//初始化
    for (int i = 0; i < (high + 1) * 2; i++)
        for (int j = 0; j < bottle_node_count_max * 2; j++)
            heapMatrix[i][j] = *t;
            //将堆中的值写入矩阵
        int index = 1,level=0;
        bool flag;//判断是线还是元素的位置
        while (level < high + 1)
        {
            flag = true;
            //计算两个数之间的距离
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

    //输出

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
{//<<运算符重载
    x.output(out);
    out << endl;
    return out;
}
