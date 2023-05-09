#pragma once
#undef UNICODE
#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>           //标准输入输出头文件
#include<stdlib.h>          //system函数的头文件
#include<windows.h>
#include<conio.h>           //getch函数的头文件
#include<graphics.h>        //图形库头文件
#pragma comment(lib,"winmm.lib")       //导入winmm.lib库,有了它才可以支持对windows多媒体的编程

#define SIZE 45		//每张贴图的大小
#define WINDOWSWIDTH (COL*SIZE)		//窗口的宽
#define WINDOWSHEIGHT (ROW*SIZE)	//窗口的高
#define MAXLEVEL 10				//最大关卡

void DrawMap();
void PlayGame();
int Win();
void TargetCount();
void InitGame();      //游戏开始之前的准备工作
void SaveStep();
void  PreviousStep();

int map[20][20] = {};
int temp[5000][20][20] = {};	//临时地图数组，用于存储当前步骤的前一步的地图信息，来实现回退功能
int step = -1;
int  ROW = 0;		//地图的行
int  COL = 0;		//地图的列
int R;	//玩家的横坐标
int C;	//玩家的纵坐标
int targetCount = 0;	//地图中目的地的个数
int gameLevel = 1;	//游戏关卡


char dir = 's';	//人物当前的方向
char fileName[100] = "";	//存放图片路径的字符串

IMAGE bkImg, boxImg, dkboxImg, targetImg, blankImg, wallImg, playerImg[4];
