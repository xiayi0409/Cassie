#pragma once
#undef UNICODE
#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>           //��׼�������ͷ�ļ�
#include<stdlib.h>          //system������ͷ�ļ�
#include<windows.h>
#include<conio.h>           //getch������ͷ�ļ�
#include<graphics.h>        //ͼ�ο�ͷ�ļ�
#pragma comment(lib,"winmm.lib")       //����winmm.lib��,�������ſ���֧�ֶ�windows��ý��ı��

#define SIZE 45		//ÿ����ͼ�Ĵ�С
#define WINDOWSWIDTH (COL*SIZE)		//���ڵĿ�
#define WINDOWSHEIGHT (ROW*SIZE)	//���ڵĸ�
#define MAXLEVEL 10				//���ؿ�

void DrawMap();
void PlayGame();
int Win();
void TargetCount();
void InitGame();      //��Ϸ��ʼ֮ǰ��׼������
void SaveStep();
void  PreviousStep();

int map[20][20] = {};
int temp[5000][20][20] = {};	//��ʱ��ͼ���飬���ڴ洢��ǰ�����ǰһ���ĵ�ͼ��Ϣ����ʵ�ֻ��˹���
int step = -1;
int  ROW = 0;		//��ͼ����
int  COL = 0;		//��ͼ����
int R;	//��ҵĺ�����
int C;	//��ҵ�������
int targetCount = 0;	//��ͼ��Ŀ�ĵصĸ���
int gameLevel = 1;	//��Ϸ�ؿ�


char dir = 's';	//���ﵱǰ�ķ���
char fileName[100] = "";	//���ͼƬ·�����ַ���

IMAGE bkImg, boxImg, dkboxImg, targetImg, blankImg, wallImg, playerImg[4];
