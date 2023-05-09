#include"标头.h"  
/*0 空地 1 墙  3 目的地 4 箱子 5 人 */  

int main(void)       //主程序
{
	InitGame();
	while (1)
	{
		while (!_kbhit()) {}   //没有按键按下什么都不执行，只有按下了按键才进行判断方向 画地图操作
		PlayGame();
		DrawMap();
		int select = Win();	      //是否继续下一关，1 确定 2  取消
		if (select == 1)
		{
			gameLevel++;
			InitGame();
		}
		else if (select == 2)
		{
			closegraph();
			return 0;
		}
	}
	system("pause");
	
	return 0;
}

void InitGame()      //游戏开始前需要做的准备工作
{
	//加载地图
	char  fileName[100] = "";      //定义
	sprintf(fileName, "./第%d关.txt", gameLevel);      //为了简化代码以及便于增加游戏关卡数，采用读取TXT文件的方法

	FILE* file;         
	if ((file = fopen(fileName, "r")) == NULL)
	{
		exit(0);
	}
	else
	{
		fscanf(file, "%d", &ROW);       //地图的行
		fscanf(file, "%d", &COL);       //地图的列    （读取行列数以便控制窗口的大小和遍历）
		
		for (int i = 0; i < ROW; i++)
		{
			for (int j = 0; j < COL; j++)
			{
				fscanf(file, "%d", &map[i][j]);
			}
		}
		rewind(file);     //文件指针回绕到文件起始处
	}
	initgraph(WINDOWSWIDTH + 220, WINDOWSHEIGHT, NULL);         //初始化图形系统


	loadimage(&bkImg, "blank.jpg", WINDOWSWIDTH, WINDOWSHEIGHT);
	loadimage(&targetImg, "target.jpg", SIZE, SIZE);
	loadimage(&boxImg, "box.jpg", SIZE, SIZE);
	loadimage(&dkboxImg, "boxToTarget.jpg", SIZE, SIZE);
	loadimage(&blankImg, "blank.jpg", SIZE, SIZE);
	loadimage(&wallImg, "wall.jpg", SIZE, SIZE);
	//加载人物动作图片

	for (int i = 0; i < 4; i++)
	{
		sprintf(fileName, "%d.jpg", i);
		//	loadimage(&playerImg[i], fileName, SIZE, SIZE);
		loadimage(&playerImg[i], fileName, SIZE, SIZE);       //存储地图
	}

	TargetCount();           //遍历地图，查看总共的目的地的个数，用于判断是否所有的箱子都移动到了目的地
	step = -1;
	SaveStep();               //将玩家的每一步都保存起来，以便回退操作
	DrawMap();
	/*
	开始操作之前就要把原始地图存起来，才可以回退到最原始的地图，不然只可以回退到
	按键操作之后的那一步
	*/
}

void DrawMap()         //图形与数字的对应，游戏界面旁边的文字说明的打印，判断是否是重新开始
{
	BeginBatchDraw();	//将贴图放在BeginBatchDraw（）函数和EndBatchDraw（）函数之间，就不会出现闪屏了
	cleardevice();
	//清屏后需要重新显示游戏信息
	setfillcolor(RGB(235, 227, 206));   //填充当前颜色
	fillrectangle(WINDOWSWIDTH, 0, WINDOWSWIDTH + 220, WINDOWSHEIGHT);   //窗口大小
	settextcolor(BLACK);
	settextstyle(20, 0, "宋体");
	setbkmode(TRANSPARENT);

	outtextxy(WINDOWSWIDTH + 45, 45, "推箱子小游戏");
	outtextxy(WINDOWSWIDTH, 70, "操作说明:");
	outtextxy(WINDOWSWIDTH, 95, "WASD 或者↑↓←→");
	char str[100] = "";
	sprintf(str, "关卡           ：%d/%d", gameLevel, MAXLEVEL);
	outtextxy(WINDOWSWIDTH, 120, str);
	char stepStr[100] = "";

	/*
	之所以判断是不是重新开始，因为运行程序开始和按了R开始两种情况是不一样的
	如果是第一次开始，在主函数中执行DrawMap函数之后就会等待玩家按了按键之后，
	才再次执行DrawMap函数，这种情况step是从-1开始计步的，这时显示时就需要+1
	而如果按了R重新开始，这时执行了InitGame函数，然后PlayGame函数执行完毕
	就会继续执行DrawMap函数，这时step是为0的就不需要+1了
	*/

	if (step == -1)
	{
		sprintf(stepStr, "步数           ：%d", step + 1);
		outtextxy(WINDOWSWIDTH, 145, stepStr);
	}
	else
	{
		sprintf(stepStr, "步数           ：%d", step);
		outtextxy(WINDOWSWIDTH, 145, stepStr);
	}

	outtextxy(WINDOWSWIDTH, 170, "回退           ：ESC");
	outtextxy(WINDOWSWIDTH, 195, "重新开始       ：R");
	outtextxy(WINDOWSWIDTH, 270, "上一关         ：X");
	outtextxy(WINDOWSWIDTH, 295, "下一关         ：N");


	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			switch ((map[i][j]))                       //0 空地 1 墙  3 目的地 4 箱子 5 人
			{
			case 0:
				putimage(j * SIZE, i * SIZE, &blankImg);
				break;
			case 1:
				putimage(j * SIZE, i * SIZE, &wallImg);
				break;
			case 3:
				putimage(j * SIZE, i * SIZE, &targetImg);
				break;
			case 4:
				putimage(j * SIZE, i * SIZE, &boxImg);         //为了增加小人推箱子的方向，设置了4张小人的图片，代表四个方向
				break;
			case 5:			 //5 8 都代表是人
			case 8:			 //人走到了目的地上 5+3
				R = i;
				C = j;
				
				switch (dir)      //从键盘中获取键值，以改变人物图片的方向
				{
				case 'w':
				case'W':
				case 72:
					putimage(j * SIZE, i * SIZE, &playerImg[0]); break;
				case 's':
				case'S':
				case 80:
					putimage(j * SIZE, i * SIZE, &playerImg[1]); break;
				case 'a':
				case'A':
				case 75:
					putimage(j * SIZE, i * SIZE, &playerImg[2]); break;
				case 'd':
				case'D':
				case 77:
					putimage(j * SIZE, i * SIZE, &playerImg[3]); break;
				default:
					putimage(j * SIZE, i * SIZE, &playerImg[1]);
				}
				break;
			case 7:     //箱子被推到了目的地 4+3
				putimage(j * SIZE, i * SIZE, &dkboxImg);
				break;
			}
		}
	}
	EndBatchDraw();
}

void PlayGame()          //游戏过程中玩家的每一步操作所对应的变化
{
	dir = _getch();         //从键盘上获取数据
	switch (dir)          
	{
	case 'W':
	case 'w':
	case 72:               //方向键上
		if (map[R - 1][C] == 0)						  // 1 人上面是空地（0）
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                  // 1.1所站的地方以前是空地（5+0）
			{										                  // 1.2所站的地方以前是目的地（3+5）
				map[R][C] -= 5;
				map[R - 1][C] = 5; 
			}
		}
		else if (map[R - 1][C] == 4)				  // 2 人上面是箱子（4）
		{												              //2.1所站的地方以前是空地（5+0)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                     //2.1.1箱子的上面是空地(0)												
			{												                                         //2.1.2箱子的上面是目的地(3)				
															          //2.2所站的地方以前是目的地(5+3)
				if (map[R - 2][C] == 0 || map[R - 2][C] == 3)		                                 //2.2.1箱子的上面是空地(0)
				{											                                         //2.2.2箱子的上面是目的地(3)
					map[R][C] -= 5;
					map[R - 1][C] = 5;
					map[R - 2][C] += 4;
				}
			}
		}
		else if (map[R - 1][C] == 3)		          //3人上面是目的地(3)
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                 //3.1人所站的地方是空地(5+0)
			{									                     //3.2人所站的地方是目的地(5+3)
				map[R][C] -= 5;
				map[R - 1][C] = 8;
			}
		}
		else if (map[R - 1][C] == 7)	            //4人上面是在目的地的箱子也就是(3+4)
		{
			if (map[R][C] == 5 || map[R][C] == 8)		            //4.1人所站的地方以前是空地（0+5） 
			{
				if (map[R - 2][C] == 0 || map[R - 2][C] == 3)                                       //4.1.1箱子的上面是空地（0)
				{										                                            //4.1.2箱子的上面是目的地（3）
					map[R][C] -= 5;                                 //4.2人所站的地方以前是目的地（3+5）       
					map[R - 1][C] = 8;                                                              //4.2.1箱子的上面是空地（0）
					map[R - 2][C] += 4;                                                             //4.2.2箱子的上面是目的地（3）
				}
			}
		}
		SaveStep();		//将每一步走之后的地图信息都保存起来
		break;
	case 'S':
	case 's':
	case 80:         //方向键下
		if (map[R + 1][C] == 0)	                    // 1人下面是空地（0）
		{
			if (map[R][C] == 5 || map[R][C] == 8)                    // 1.1所站的地方以前是空地（0+5）
			{								                         //  1.2所站的地方以前是目的地(3+5）
				map[R][C] -= 5;
				map[R + 1][C] = 5;
			}
		}
		else if (map[R + 1][C] == 4)				//2 人下面是箱子（4)
		{												             //2.1所站的地方以前是空地(0+5)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                     //2.1.1箱子的下面是空地(0)												
			{												                                         //2.1.2箱子的下面是目的地(3)				
															         //2.2所站的地方以前是目的地(3+5)
				if (map[R + 2][C] == 0 || map[R + 2][C] == 3)		                                 //2.2.1箱子的下面是空地(0)
				{											                                         //2.2.2箱子的下面是目的地(3)
					map[R][C] -= 5;
					map[R + 1][C] = 5;
					map[R + 2][C] += 4;
				}
			}
		}
		else if (map[R + 1][C] == 3)		       //3人下面是目的地(3）
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                 //3.1人所站的地方是空地（0+5）
			{									                     //3.2人所站的地方是目的地(3+5）
				map[R][C] -= 5;
				map[R + 1][C] = 8;
			}
		}
		else if (map[R + 1][C] == 7)	           //4人下面是在目的地的箱子（3+4）
		{
			if (map[R][C] == 5 || map[R][C] == 8)		             //4.1人所站的地方以前是空地（0+5）
			{
				if (map[R + 2][C] == 0 || map[R + 2][C] == 3)                                         //4.1.1箱子的下面是空地（0）
				{										                                              //4.1.2箱子的下面是目的地（3）
					map[R][C] -= 5;                                 //4.2人所站的地方以前是目的地（3+5）
					map[R + 1][C] = 8;                                                                //4.2.1箱子的下面是空地（0）
					map[R + 2][C] += 4;                                                               //4.2.2箱子的下面是目的地（3）
				}
			}
		}
		SaveStep();		//将每一步走之后的地图信息都保存起来
		break;
	case 'A':
	case 'a':
	case 75:    //方向键左
		if (map[R][C - 1] == 0)	                   // 1人左面是空地（0）
		{
			if (map[R][C] == 5 || map[R][C] == 8)                   // 1.1所站的地方以前是空地（0+5）
			{								                        // 1.2所站的地方以前是目的地（3+5)
				map[R][C] -= 5;
				map[R][C - 1] = 5;
			}
		}
		else if (map[R][C - 1] == 4)			   //2 人左面是箱子(4)
		{												           //2.1所站的地方以前是空地(0+5)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                       //2.1.1箱子的左面是空地(0)												
			{												                                           //2.1.2箱子的左面是目的地(3）				
															       //2.2所站的地方以前是目的地(3+5)
				if (map[R][C - 2] == 0 || map[R][C - 2] == 3)		                                   //2.2.1箱子的左面是空地（0）
				{											                                           //2.2.2箱子的左面是目的地（3）
					map[R][C] -= 5;
					map[R][C - 1] = 5;
					map[R][C - 2] += 4;
				}
			}
		}
		else if (map[R][C - 1] == 3)		      //3人左面是目的地（3）
		{
			if (map[R][C] == 5 || map[R][C] == 8)	               //3.1人所站的地方是空地（0+5）
			{									                   //3.2人所站的地方是目的地（3+5）
				map[R][C] -= 5;
				map[R][C - 1] = 8;
			}
		}
		else if (map[R][C - 1] == 7)	         //4人左面是在目的地的箱子（3+4）
		{
			if (map[R][C] == 5 || map[R][C] == 8)		           //4.1人所站的地方以前是空地（0+5）
			{                                              
				if (map[R][C - 2] == 0 || map[R][C - 2] == 3)                                          //4.1.1箱子的左面是空地（0）
				{										                                               //4.1.2箱子的左面是目的地（3）
					map[R][C] -= 5;                               //4.2人所站的地方以前是目的地（3+5）
					map[R][C - 1] = 8;                                                                 //4.2.1箱子的左面是空地（0）
					map[R][C - 2] += 4;                                                                //4.2.2箱子的左面是目的地（3）
				}
			}
		}
		SaveStep();		//将每一步走之后的地图信息都保存起来
		break;
	case 'D':
	case 'd':
	case 77:    //方向键右
		if (map[R][C + 1] == 0)	                 // 1人右面是空地（0）
		{
			if (map[R][C] == 5 || map[R][C] == 8)                  // 1.1所站的地方以前是空地（0+5）
			{								                       // 1.2所站的地方以前是目的地（0+3）
				map[R][C] -= 5;
				map[R][C + 1] = 5;
			}
		}
		else if (map[R][C + 1] == 4)	         //2 人右面是箱子（4）
		{												           //2.1所站的地方以前是空地（0+5）	
			if (map[R][C] == 5 || map[R][C] == 8)				                                        //2.1.1箱子的右上面是空地（0）											
			{												                                            //2.1.2箱子的右面是目的地（3）				
															       //2.2所站的地方以前是目的地（3+5）
				if (map[R][C + 2] == 0 || map[R][C + 2] == 3)		                                    //2.2.1箱子的右面是空地（0）
				{											                                            //2.2.2箱子的右面是目的地（3）
					map[R][C] -= 5;
					map[R][C + 1] = 5;
					map[R][C + 2] += 4;
				}
			}
		}
		else if (map[R][C + 1] == 3)		    //3人右面是目的地（3）
		{
			if (map[R][C] == 5 || map[R][C] == 8)	               //3.1人所站的地方是空地（0+5）
			{									                   //3.2人所站的地方是目的地（3+5）
				map[R][C] -= 5;
				map[R][C + 1] = 8;
			}
		}
		else if (map[R][C + 1] == 7)	        //4人右面是在目的地的箱子（3+4）
		{
			if (map[R][C] == 5 || map[R][C] == 8)		           //4.1人所站的地方以前是空地（0+5）
			{
				if (map[R][C + 2] == 0 || map[R][C + 2] == 3)                                           //4.1.1箱子的右面是空地（0）
				{										                                                //4.1.2箱子的右面是目的地（3）
					map[R][C] -= 5;                                //4.2人所站的地方以前是目的地（3+5）
					map[R][C + 1] = 8;                                                                  //4.1.1箱子的右面是空地（0）
					map[R][C + 2] += 4;                                                                 //4.1.2箱子的右面是目的地（3）
				}
			}
		}
		SaveStep();		//将每一步走之后的地图信息都保存起来
		break;
	case 27:		//ESC按键ASCII值   回退
		PreviousStep();
		break;
	case 'R':			//重新开始这一关
	case 'r':
		InitGame();
		break;
	case 'X':	//上一关
	case 'x':
		if (gameLevel > 1)
		{
			gameLevel--;
			InitGame();
		}
		break;
	case 'N':		//下一关
	case 'n':
		if (gameLevel < MAXLEVEL)
		{
			gameLevel++;
			InitGame();
		}

		break;
	}

}

void TargetCount()             //遍历地图，查看总共的目的地的个数，用于判断是否将所有箱子移动到了目的地
{
	targetCount = 0;	//每次调用函数都需要将targetCount初始化为零，不然就是在上一次的基础上++了
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			if (map[i][j] == 3 || map[i][j] == 7)        
				targetCount++;
		}
	}

}

int Win()          //判断是否通关 
{
	int boxToTargetCount = 0;	       //在目的地的箱子个数
	for (int i = 0; i < ROW; i++)           //遍历整张地图
	{
		for (int j = 0; j < COL; j++)       
		{
			if (map[i][j] == 7)         //所有的箱子到达目的地（3+4=7）
			{
				boxToTargetCount++; 
				if (boxToTargetCount == targetCount)
				{
					if (gameLevel == MAXLEVEL)	        //是否通过了全部的关卡
					{
						MessageBox(NULL, "恭喜你全部通关，太棒了！", "通关", MB_OKCANCEL | MB_SYSTEMMODAL);       //弹框函数
						exit(0);
					}
					//过关，返回选择函数值 1 确定 2取消
					return (MessageBox(NULL, "你真棒，继续下一关吧！", "获胜", MB_OKCANCEL | MB_SYSTEMMODAL));

				}
			}

		}
	}
}

void SaveStep()                  //将玩家的每一步都保存起来，以便于回退操作
{
	step += 1;
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			temp[step][i][j] = map[i][j];        
		}
	}
}

void  PreviousStep()	//上一步，以实现回退操作
{
	if (step >= 0)
	{
		step--;
		for (int i = 0; i < ROW; i++)
		{
			for (int j = 0; j < COL; j++)
			{
				map[i][j] = temp[step][i][j];
			}
		}
	}
}
