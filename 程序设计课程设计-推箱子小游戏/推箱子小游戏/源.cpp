#include"��ͷ.h"  
/*0 �յ� 1 ǽ  3 Ŀ�ĵ� 4 ���� 5 �� */  

int main(void)       //������
{
	InitGame();
	while (1)
	{
		while (!_kbhit()) {}   //û�а�������ʲô����ִ�У�ֻ�а����˰����Ž����жϷ��� ����ͼ����
		PlayGame();
		DrawMap();
		int select = Win();	      //�Ƿ������һ�أ�1 ȷ�� 2  ȡ��
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

void InitGame()      //��Ϸ��ʼǰ��Ҫ����׼������
{
	//���ص�ͼ
	char  fileName[100] = "";      //����
	sprintf(fileName, "./��%d��.txt", gameLevel);      //Ϊ�˼򻯴����Լ�����������Ϸ�ؿ��������ö�ȡTXT�ļ��ķ���

	FILE* file;         
	if ((file = fopen(fileName, "r")) == NULL)
	{
		exit(0);
	}
	else
	{
		fscanf(file, "%d", &ROW);       //��ͼ����
		fscanf(file, "%d", &COL);       //��ͼ����    ����ȡ�������Ա���ƴ��ڵĴ�С�ͱ�����
		
		for (int i = 0; i < ROW; i++)
		{
			for (int j = 0; j < COL; j++)
			{
				fscanf(file, "%d", &map[i][j]);
			}
		}
		rewind(file);     //�ļ�ָ����Ƶ��ļ���ʼ��
	}
	initgraph(WINDOWSWIDTH + 220, WINDOWSHEIGHT, NULL);         //��ʼ��ͼ��ϵͳ


	loadimage(&bkImg, "blank.jpg", WINDOWSWIDTH, WINDOWSHEIGHT);
	loadimage(&targetImg, "target.jpg", SIZE, SIZE);
	loadimage(&boxImg, "box.jpg", SIZE, SIZE);
	loadimage(&dkboxImg, "boxToTarget.jpg", SIZE, SIZE);
	loadimage(&blankImg, "blank.jpg", SIZE, SIZE);
	loadimage(&wallImg, "wall.jpg", SIZE, SIZE);
	//�������ﶯ��ͼƬ

	for (int i = 0; i < 4; i++)
	{
		sprintf(fileName, "%d.jpg", i);
		//	loadimage(&playerImg[i], fileName, SIZE, SIZE);
		loadimage(&playerImg[i], fileName, SIZE, SIZE);       //�洢��ͼ
	}

	TargetCount();           //������ͼ���鿴�ܹ���Ŀ�ĵصĸ����������ж��Ƿ����е����Ӷ��ƶ�����Ŀ�ĵ�
	step = -1;
	SaveStep();               //����ҵ�ÿһ���������������Ա���˲���
	DrawMap();
	/*
	��ʼ����֮ǰ��Ҫ��ԭʼ��ͼ���������ſ��Ի��˵���ԭʼ�ĵ�ͼ����Ȼֻ���Ի��˵�
	��������֮�����һ��
	*/
}

void DrawMap()         //ͼ�������ֵĶ�Ӧ����Ϸ�����Աߵ�����˵���Ĵ�ӡ���ж��Ƿ������¿�ʼ
{
	BeginBatchDraw();	//����ͼ����BeginBatchDraw����������EndBatchDraw��������֮�䣬�Ͳ������������
	cleardevice();
	//��������Ҫ������ʾ��Ϸ��Ϣ
	setfillcolor(RGB(235, 227, 206));   //��䵱ǰ��ɫ
	fillrectangle(WINDOWSWIDTH, 0, WINDOWSWIDTH + 220, WINDOWSHEIGHT);   //���ڴ�С
	settextcolor(BLACK);
	settextstyle(20, 0, "����");
	setbkmode(TRANSPARENT);

	outtextxy(WINDOWSWIDTH + 45, 45, "������С��Ϸ");
	outtextxy(WINDOWSWIDTH, 70, "����˵��:");
	outtextxy(WINDOWSWIDTH, 95, "WASD ���ߡ�������");
	char str[100] = "";
	sprintf(str, "�ؿ�           ��%d/%d", gameLevel, MAXLEVEL);
	outtextxy(WINDOWSWIDTH, 120, str);
	char stepStr[100] = "";

	/*
	֮�����ж��ǲ������¿�ʼ����Ϊ���г���ʼ�Ͱ���R��ʼ��������ǲ�һ����
	����ǵ�һ�ο�ʼ������������ִ��DrawMap����֮��ͻ�ȴ���Ұ��˰���֮��
	���ٴ�ִ��DrawMap�������������step�Ǵ�-1��ʼ�Ʋ��ģ���ʱ��ʾʱ����Ҫ+1
	���������R���¿�ʼ����ʱִ����InitGame������Ȼ��PlayGame����ִ�����
	�ͻ����ִ��DrawMap��������ʱstep��Ϊ0�ľͲ���Ҫ+1��
	*/

	if (step == -1)
	{
		sprintf(stepStr, "����           ��%d", step + 1);
		outtextxy(WINDOWSWIDTH, 145, stepStr);
	}
	else
	{
		sprintf(stepStr, "����           ��%d", step);
		outtextxy(WINDOWSWIDTH, 145, stepStr);
	}

	outtextxy(WINDOWSWIDTH, 170, "����           ��ESC");
	outtextxy(WINDOWSWIDTH, 195, "���¿�ʼ       ��R");
	outtextxy(WINDOWSWIDTH, 270, "��һ��         ��X");
	outtextxy(WINDOWSWIDTH, 295, "��һ��         ��N");


	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			switch ((map[i][j]))                       //0 �յ� 1 ǽ  3 Ŀ�ĵ� 4 ���� 5 ��
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
				putimage(j * SIZE, i * SIZE, &boxImg);         //Ϊ������С�������ӵķ���������4��С�˵�ͼƬ�������ĸ�����
				break;
			case 5:			 //5 8 ����������
			case 8:			 //���ߵ���Ŀ�ĵ��� 5+3
				R = i;
				C = j;
				
				switch (dir)      //�Ӽ����л�ȡ��ֵ���Ըı�����ͼƬ�ķ���
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
			case 7:     //���ӱ��Ƶ���Ŀ�ĵ� 4+3
				putimage(j * SIZE, i * SIZE, &dkboxImg);
				break;
			}
		}
	}
	EndBatchDraw();
}

void PlayGame()          //��Ϸ��������ҵ�ÿһ����������Ӧ�ı仯
{
	dir = _getch();         //�Ӽ����ϻ�ȡ����
	switch (dir)          
	{
	case 'W':
	case 'w':
	case 72:               //�������
		if (map[R - 1][C] == 0)						  // 1 �������ǿյأ�0��
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                  // 1.1��վ�ĵط���ǰ�ǿյأ�5+0��
			{										                  // 1.2��վ�ĵط���ǰ��Ŀ�ĵأ�3+5��
				map[R][C] -= 5;
				map[R - 1][C] = 5; 
			}
		}
		else if (map[R - 1][C] == 4)				  // 2 �����������ӣ�4��
		{												              //2.1��վ�ĵط���ǰ�ǿյأ�5+0)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                     //2.1.1���ӵ������ǿյ�(0)												
			{												                                         //2.1.2���ӵ�������Ŀ�ĵ�(3)				
															          //2.2��վ�ĵط���ǰ��Ŀ�ĵ�(5+3)
				if (map[R - 2][C] == 0 || map[R - 2][C] == 3)		                                 //2.2.1���ӵ������ǿյ�(0)
				{											                                         //2.2.2���ӵ�������Ŀ�ĵ�(3)
					map[R][C] -= 5;
					map[R - 1][C] = 5;
					map[R - 2][C] += 4;
				}
			}
		}
		else if (map[R - 1][C] == 3)		          //3��������Ŀ�ĵ�(3)
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                 //3.1����վ�ĵط��ǿյ�(5+0)
			{									                     //3.2����վ�ĵط���Ŀ�ĵ�(5+3)
				map[R][C] -= 5;
				map[R - 1][C] = 8;
			}
		}
		else if (map[R - 1][C] == 7)	            //4����������Ŀ�ĵص�����Ҳ����(3+4)
		{
			if (map[R][C] == 5 || map[R][C] == 8)		            //4.1����վ�ĵط���ǰ�ǿյأ�0+5�� 
			{
				if (map[R - 2][C] == 0 || map[R - 2][C] == 3)                                       //4.1.1���ӵ������ǿյأ�0)
				{										                                            //4.1.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;                                 //4.2����վ�ĵط���ǰ��Ŀ�ĵأ�3+5��       
					map[R - 1][C] = 8;                                                              //4.2.1���ӵ������ǿյأ�0��
					map[R - 2][C] += 4;                                                             //4.2.2���ӵ�������Ŀ�ĵأ�3��
				}
			}
		}
		SaveStep();		//��ÿһ����֮��ĵ�ͼ��Ϣ����������
		break;
	case 'S':
	case 's':
	case 80:         //�������
		if (map[R + 1][C] == 0)	                    // 1�������ǿյأ�0��
		{
			if (map[R][C] == 5 || map[R][C] == 8)                    // 1.1��վ�ĵط���ǰ�ǿյأ�0+5��
			{								                         //  1.2��վ�ĵط���ǰ��Ŀ�ĵ�(3+5��
				map[R][C] -= 5;
				map[R + 1][C] = 5;
			}
		}
		else if (map[R + 1][C] == 4)				//2 �����������ӣ�4)
		{												             //2.1��վ�ĵط���ǰ�ǿյ�(0+5)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                     //2.1.1���ӵ������ǿյ�(0)												
			{												                                         //2.1.2���ӵ�������Ŀ�ĵ�(3)				
															         //2.2��վ�ĵط���ǰ��Ŀ�ĵ�(3+5)
				if (map[R + 2][C] == 0 || map[R + 2][C] == 3)		                                 //2.2.1���ӵ������ǿյ�(0)
				{											                                         //2.2.2���ӵ�������Ŀ�ĵ�(3)
					map[R][C] -= 5;
					map[R + 1][C] = 5;
					map[R + 2][C] += 4;
				}
			}
		}
		else if (map[R + 1][C] == 3)		       //3��������Ŀ�ĵ�(3��
		{
			if (map[R][C] == 5 || map[R][C] == 8)	                 //3.1����վ�ĵط��ǿյأ�0+5��
			{									                     //3.2����վ�ĵط���Ŀ�ĵ�(3+5��
				map[R][C] -= 5;
				map[R + 1][C] = 8;
			}
		}
		else if (map[R + 1][C] == 7)	           //4����������Ŀ�ĵص����ӣ�3+4��
		{
			if (map[R][C] == 5 || map[R][C] == 8)		             //4.1����վ�ĵط���ǰ�ǿյأ�0+5��
			{
				if (map[R + 2][C] == 0 || map[R + 2][C] == 3)                                         //4.1.1���ӵ������ǿյأ�0��
				{										                                              //4.1.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;                                 //4.2����վ�ĵط���ǰ��Ŀ�ĵأ�3+5��
					map[R + 1][C] = 8;                                                                //4.2.1���ӵ������ǿյأ�0��
					map[R + 2][C] += 4;                                                               //4.2.2���ӵ�������Ŀ�ĵأ�3��
				}
			}
		}
		SaveStep();		//��ÿһ����֮��ĵ�ͼ��Ϣ����������
		break;
	case 'A':
	case 'a':
	case 75:    //�������
		if (map[R][C - 1] == 0)	                   // 1�������ǿյأ�0��
		{
			if (map[R][C] == 5 || map[R][C] == 8)                   // 1.1��վ�ĵط���ǰ�ǿյأ�0+5��
			{								                        // 1.2��վ�ĵط���ǰ��Ŀ�ĵأ�3+5)
				map[R][C] -= 5;
				map[R][C - 1] = 5;
			}
		}
		else if (map[R][C - 1] == 4)			   //2 ������������(4)
		{												           //2.1��վ�ĵط���ǰ�ǿյ�(0+5)	
			if (map[R][C] == 5 || map[R][C] == 8)				                                       //2.1.1���ӵ������ǿյ�(0)												
			{												                                           //2.1.2���ӵ�������Ŀ�ĵ�(3��				
															       //2.2��վ�ĵط���ǰ��Ŀ�ĵ�(3+5)
				if (map[R][C - 2] == 0 || map[R][C - 2] == 3)		                                   //2.2.1���ӵ������ǿյأ�0��
				{											                                           //2.2.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;
					map[R][C - 1] = 5;
					map[R][C - 2] += 4;
				}
			}
		}
		else if (map[R][C - 1] == 3)		      //3��������Ŀ�ĵأ�3��
		{
			if (map[R][C] == 5 || map[R][C] == 8)	               //3.1����վ�ĵط��ǿյأ�0+5��
			{									                   //3.2����վ�ĵط���Ŀ�ĵأ�3+5��
				map[R][C] -= 5;
				map[R][C - 1] = 8;
			}
		}
		else if (map[R][C - 1] == 7)	         //4����������Ŀ�ĵص����ӣ�3+4��
		{
			if (map[R][C] == 5 || map[R][C] == 8)		           //4.1����վ�ĵط���ǰ�ǿյأ�0+5��
			{                                              
				if (map[R][C - 2] == 0 || map[R][C - 2] == 3)                                          //4.1.1���ӵ������ǿյأ�0��
				{										                                               //4.1.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;                               //4.2����վ�ĵط���ǰ��Ŀ�ĵأ�3+5��
					map[R][C - 1] = 8;                                                                 //4.2.1���ӵ������ǿյأ�0��
					map[R][C - 2] += 4;                                                                //4.2.2���ӵ�������Ŀ�ĵأ�3��
				}
			}
		}
		SaveStep();		//��ÿһ����֮��ĵ�ͼ��Ϣ����������
		break;
	case 'D':
	case 'd':
	case 77:    //�������
		if (map[R][C + 1] == 0)	                 // 1�������ǿյأ�0��
		{
			if (map[R][C] == 5 || map[R][C] == 8)                  // 1.1��վ�ĵط���ǰ�ǿյأ�0+5��
			{								                       // 1.2��վ�ĵط���ǰ��Ŀ�ĵأ�0+3��
				map[R][C] -= 5;
				map[R][C + 1] = 5;
			}
		}
		else if (map[R][C + 1] == 4)	         //2 �����������ӣ�4��
		{												           //2.1��վ�ĵط���ǰ�ǿյأ�0+5��	
			if (map[R][C] == 5 || map[R][C] == 8)				                                        //2.1.1���ӵ��������ǿյأ�0��											
			{												                                            //2.1.2���ӵ�������Ŀ�ĵأ�3��				
															       //2.2��վ�ĵط���ǰ��Ŀ�ĵأ�3+5��
				if (map[R][C + 2] == 0 || map[R][C + 2] == 3)		                                    //2.2.1���ӵ������ǿյأ�0��
				{											                                            //2.2.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;
					map[R][C + 1] = 5;
					map[R][C + 2] += 4;
				}
			}
		}
		else if (map[R][C + 1] == 3)		    //3��������Ŀ�ĵأ�3��
		{
			if (map[R][C] == 5 || map[R][C] == 8)	               //3.1����վ�ĵط��ǿյأ�0+5��
			{									                   //3.2����վ�ĵط���Ŀ�ĵأ�3+5��
				map[R][C] -= 5;
				map[R][C + 1] = 8;
			}
		}
		else if (map[R][C + 1] == 7)	        //4����������Ŀ�ĵص����ӣ�3+4��
		{
			if (map[R][C] == 5 || map[R][C] == 8)		           //4.1����վ�ĵط���ǰ�ǿյأ�0+5��
			{
				if (map[R][C + 2] == 0 || map[R][C + 2] == 3)                                           //4.1.1���ӵ������ǿյأ�0��
				{										                                                //4.1.2���ӵ�������Ŀ�ĵأ�3��
					map[R][C] -= 5;                                //4.2����վ�ĵط���ǰ��Ŀ�ĵأ�3+5��
					map[R][C + 1] = 8;                                                                  //4.1.1���ӵ������ǿյأ�0��
					map[R][C + 2] += 4;                                                                 //4.1.2���ӵ�������Ŀ�ĵأ�3��
				}
			}
		}
		SaveStep();		//��ÿһ����֮��ĵ�ͼ��Ϣ����������
		break;
	case 27:		//ESC����ASCIIֵ   ����
		PreviousStep();
		break;
	case 'R':			//���¿�ʼ��һ��
	case 'r':
		InitGame();
		break;
	case 'X':	//��һ��
	case 'x':
		if (gameLevel > 1)
		{
			gameLevel--;
			InitGame();
		}
		break;
	case 'N':		//��һ��
	case 'n':
		if (gameLevel < MAXLEVEL)
		{
			gameLevel++;
			InitGame();
		}

		break;
	}

}

void TargetCount()             //������ͼ���鿴�ܹ���Ŀ�ĵصĸ����������ж��Ƿ����������ƶ�����Ŀ�ĵ�
{
	targetCount = 0;	//ÿ�ε��ú�������Ҫ��targetCount��ʼ��Ϊ�㣬��Ȼ��������һ�εĻ�����++��
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			if (map[i][j] == 3 || map[i][j] == 7)        
				targetCount++;
		}
	}

}

int Win()          //�ж��Ƿ�ͨ�� 
{
	int boxToTargetCount = 0;	       //��Ŀ�ĵص����Ӹ���
	for (int i = 0; i < ROW; i++)           //�������ŵ�ͼ
	{
		for (int j = 0; j < COL; j++)       
		{
			if (map[i][j] == 7)         //���е����ӵ���Ŀ�ĵأ�3+4=7��
			{
				boxToTargetCount++; 
				if (boxToTargetCount == targetCount)
				{
					if (gameLevel == MAXLEVEL)	        //�Ƿ�ͨ����ȫ���Ĺؿ�
					{
						MessageBox(NULL, "��ϲ��ȫ��ͨ�أ�̫���ˣ�", "ͨ��", MB_OKCANCEL | MB_SYSTEMMODAL);       //������
						exit(0);
					}
					//���أ�����ѡ����ֵ 1 ȷ�� 2ȡ��
					return (MessageBox(NULL, "�������������һ�ذɣ�", "��ʤ", MB_OKCANCEL | MB_SYSTEMMODAL));

				}
			}

		}
	}
}

void SaveStep()                  //����ҵ�ÿһ���������������Ա��ڻ��˲���
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

void  PreviousStep()	//��һ������ʵ�ֻ��˲���
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
