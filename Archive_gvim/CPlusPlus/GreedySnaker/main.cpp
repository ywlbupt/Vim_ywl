//������Ч�����̶�д
#include "colorConsole.h"
#include <conio.h>
#include <ctime>
#include <stdlib.h>
void Menu(HANDLE handle,WORD wcolors[],WORD wcolor[],WORD wcolorss[],WORD wScolor[]);//��ʼ����
void FoodProduce(HANDLE handle,WORD wcolor[],int l);//����ʳ��ĺ���
void Direction();//������
void Move(HANDLE handle,WORD wScolor[],WORD wcolor[]);//�����ߵ��ƶ��ĺ���
void Turning(bool *start);//�ߵ�ת����
void gameover(HANDLE handle,WORD wcolor[]);//��Ϸ��������
void begin(HANDLE handle);
struct Food //ʳ��Ľṹ��
{ 
int x; //ʳ��ĺ�����
int y; //ʳ��������� 
int yes; //ʳ���Ƿ���ֵı���
}food; 

struct Snack //�ߵĽṹ��
{ 
int x[100]; 
int y[100]; 
int node; //�ߵĽ���
int direction; //�ߵķ���
int life; //�ߵ�������0���ţ�1����
}snake; 
//������
int main(void)
{
	HANDLE handle;
    handle=initiate();
	WORD wcolors[1],wcolor[1],wScolor[1],wcolorss[4];
	wcolors[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
    wcolor[0]=FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wScolor[0]=FOREGROUND_RED|FOREGROUND_INTENSITY;
	wcolorss[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wcolorss[1]=FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wcolorss[2]=FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wcolorss[3]=FOREGROUND_BLUE|FOREGROUND_INTENSITY;
	//��ʼ����
	begin(handle);
	//��ӡ�߿�
    Menu(handle,wcolors,wcolor,wcolorss,wScolor);
	//��ʼ��һЩֵ
	snake.direction=1;
	snake.life=0;
	snake.x[0]=18;
	snake.y[0]=6;
	snake.node=2;
	food.yes=1;
	if(_kbhit)//_kbhit��_kbhit()���������
	{
		_getch();
    //��ʼ�ƶ�
	Move(handle,wScolor,wcolor);
	}
	return 0;
}
//��������
void Menu(HANDLE handle,WORD wcolors[],WORD wcolor[],WORD wcolorss[],WORD wScolor[])
{
	int i;
textout(handle,16,5,wcolors,1,"�������������������������������");
textout(handle,16,25,wcolors,1,"�������������������������������");
//����ֵ�λ��x(17-59,60)ż��,y(6-24)��Ȼ����
for(i=6;i<25;i++)
    textout(handle,16,i,wcolors,1,"��");
for(i=6;i<25;i++)
    textout(handle,60,i,wcolors,1,"��");
for(i=6;i<25;i++)
    textout(handle,74,i,wcolors,1,"��");
textout(handle,64,10,wcolor,1,"�ȼ�:");
textout(handle,64,11,wcolor,1,"1");
textout(handle,64,15,wcolor,1,"�÷�:");
textout(handle,64,16,wcolor,1,"0");
textout(handle,16,27,wcolorss,4,"1.�����������Ϸ��ʼ");
textout(handle,16,28,wcolorss,4,"2.w(��),s(��),a(��),d(��)��Ϊ���������");
textout(handle,16,29,wcolorss,4,"3.��Ϸ���м���ϵͳ���ٶȻ����ŵȼ����������ӿ�");
textout(handle,16,30,wcolorss,4,"4.�����̡�z������ͣ");
textout(handle,16,31,wcolorss,4,"5.����Capslock�Ƿ�رգ���رպ��ٿ�ʼ��Ϸ");
textout(handle,55,36,wcolorss,4,"����ϣ��������.");
textout(handle,38,2,wcolors,1,"̰!ʳ!��!");
textout(handle,16,4,wcolorss,4,"���Ƚ�������󻯣������ῴ����ʾ!");
textout(handle,8,8,wScolor,1,"��");
textout(handle,8,9,wScolor,1,"ս");
textout(handle,8,10,wScolor,1,"��");
textout(handle,8,11,wScolor,1,"��");
textout(handle,8,12,wScolor,1,"��");
textout(handle,8,13,wScolor,1,"��");
textout(handle,8,14,wScolor,1,"!");
textout(handle,2,19,wcolors,1,"<(������)> ");
textout(handle,5,20,wcolors,1,"�۹���...");

}
void FoodProduce(HANDLE handle,WORD wcolor[],int l)
{
    srand(time(NULL));
	bool produce=true;
	int count=0; 
	while(produce)  //��֤ʳ�ﲻ��������ߵ�������
	{
    food.x=(rand()%21+9)*2;
    food.y=(rand()%9+3)*2;
	for(int i=0;i<=l;i++)
	{
		if(food.x!=snake.x[i]||food.y!=snake.y[i])
			count++;
	}
	if (count>=l) break;
	}
	textout(handle,food.x,food.y,wcolor,1,"��");
}

void Direction()
{
	switch(snake.direction)
	{
	case 1:snake.x[0]+=2;break; //��
	case 2:snake.x[0]-=2;break; //��
	case 3:snake.y[0]-=1;break; //��
	case 4:snake.y[0]+=1;break; //��
	}
}

void Turning(bool *start)//�趨����
{
	if(_kbhit)
	{
	char Direct=_getch();
	switch (Direct)
	{
	case 'w':if (snake.direction!=4)
			snake.direction=3;
		break;
	case 's':if (snake.direction!=3)
			snake.direction=4;
		break;
	case 'a':if(snake.direction!=1)
            snake.direction=2;
		break;
	case 'd':if(snake.direction!=2)
			snake.direction=1;
		break;
	case 'z':*start=!*start;
		break;
	default:break;
	}
	}
}

void Move(HANDLE handle,WORD wScolor[],WORD wcolor[])
{
	static bool started=true;//�趨bool�ͱ���������ѭ������
	int i;
	while(1)//���ƶ��Ĵ�ѭ��
	{
		while(started)
		{
		static int count=100;
		static long int rank=1;
		static long int initialspeed=250;//�趨��ʼ���ٶ�
		long int nowspeed=initialspeed-rank*30;
		if(nowspeed<=0) nowspeed=10; //ȷ�����ֲ��������Ϸbug����֤�ٶ�ʼ�մ���0
		textout(handle,snake.x[0],snake.y[0],wScolor,1,"��");
		Sleep(nowspeed);//�����ƶ��ٶȵı仯�����ŵȼ�������Խ��Խ��
		textout(handle,snake.x[0],snake.y[0],wScolor,1,"  ");
		Direction();
		//����ʳ��
        if(food.yes==1)
		{
			FoodProduce(handle,wcolor,snake.node);
			food.yes=0;
		}
		for( i=snake.node;i>0;i--) //̰���ߵ��ƶ��㷨
		{ 
			snake.x[i]=snake.x[i-1]; 
			snake.y[i]=snake.y[i-1]; //̰���ߵ������ƶ��㷨
			textout(handle,snake.x[i],snake.y[i],wcolor,1,"��");//��������
			textout(handle,snake.x[snake.node],snake.y[snake.node],wcolor,1,"  ");//��ȥ�������һ���������嶯����
		} 
		for(i=3;i<snake.node;i++) //�ж��Ƿ�ͷ����������ײ
		{ 
			if(snake.x[i]==snake.x[0]&&snake.y[i]==snake.y[0]) 
			{
				snake.life=1; 
				gameover(handle,wcolor);
				break;
			}
		}
		if((snake.x[0]<17)||(snake.x[0]>58)||(snake.y[0]>24)||(snake.y[0]<6))//�ж��Ƿ���ǽ����
		{
			snake.life=1;
			gameover(handle,wcolor);
			break;
		}
		if(snake.x[0]==food.x&&snake.y[0]==food.y)
		{
			//���ӵ÷�
			char number1[30];
			char number2[15];
			textout(handle,64,16,wcolor,1,"      ");
			textout(handle,64,16,wcolor,1,_itoa(count,number1,10));//itoa(�����ͱ�Ϊ�ַ���)
			food.yes=1;
			snake.node++;
			count+=100;
			textout(handle,64,11,wcolor,1,"      ");
			textout(handle,64,11,wcolor,1,_itoa(rank,number2,10));
			rank=count/1000+1;
		}
				if(_kbhit()) break;
		}
		if(snake.life==1) break;//�˳���ѭ��
		Turning(&started);
	}

}

void begin(HANDLE handle)
{
	WORD wcolor[1],wcolor1[1],wcolor2[1],wcolor3[1];
	int i;
	wcolor[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY;//��
	wcolor1[0]=FOREGROUND_GREEN;//��
	wcolor2[0]=FOREGROUND_BLUE;//��
	wcolor3[0]=BACKGROUND_RED|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_INTENSITY;//����ɫ��
	textout(handle,10,8,wcolor,1,"����һ����϶������ص���Ϸ.....");
	Sleep(2200);
	for(i=10;i<40;i++)
	{
			textout(handle,i,8,wcolor,1,"  ");
			Sleep(60);
	}
	textout(handle,15,10,wcolor1,1,"����û����֪������ʼ����������ս��ںη�....");
	Sleep(2200);
	for(i=15;i<60;i++)
	{
			textout(handle,i,10,wcolor,1,"  ");
			Sleep(60);
	}
	textout(handle,10,12,wcolor2,1,"�ܶ��˶���������ʧ��ʧȥ�����ң���֪���Լ�������·����������..");
	Sleep(2200);
	for(i=10;i<80;i++)
	{
			textout(handle,i,12,wcolor,1,"  ");
			Sleep(60);
	}
    textout(handle,25,7,wcolor,1,"��");
	Sleep(1200);
	textout(handle,29,8,wcolor,1,"��");
	Sleep(1200);
	textout(handle,33,9,wcolor,1,"��");
	Sleep(1200);
	textout(handle,37,10,wcolor,1,"....");
	Sleep(1200);
	textout(handle,25,7,wcolor,1,"  ");
	textout(handle,29,8,wcolor,1,"  ");
	textout(handle,33,9,wcolor,1,"  ");
	textout(handle,37,10,wcolor,1,"    ");
	for(i=0;i<=80;i++)
	{
		for(int j=0;j<=50;j++)
		{
				textout(handle,i,j,wcolor3,1,"  ");
		}
	}
    Sleep(2000);
    for(i=0;i<=80;i++)
	{
		for(int j=0;j<=50;j++)
		{
				textout(handle,i,j,wcolor1,1,"  ");
		}
	}


}

void gameover(HANDLE handle,WORD wcolor[])//�趨��Ϸ��������
{
	int i;
	for(i=1;i<=80;i++)
	{
		for(int j=1;j<=50;j++)
		{
				textout(handle,i,j,wcolor,1,"  ");
		}
	}
    while(1)
	{
		for(i=1;i<80;i++)
		{
			textout(handle,i,17,wcolor,1,"��Ϸ������~����������������˳�");
			Sleep(60);
            textout(handle,i,17,wcolor,1,"                               ");
		}
		if(_kbhit()) break;
	}
}
