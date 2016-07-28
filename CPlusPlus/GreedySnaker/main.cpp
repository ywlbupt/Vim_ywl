//还差音效，磁盘读写
#include "colorConsole.h"
#include <conio.h>
#include <ctime>
#include <stdlib.h>
void Menu(HANDLE handle,WORD wcolors[],WORD wcolor[],WORD wcolorss[],WORD wScolor[]);//初始画面
void FoodProduce(HANDLE handle,WORD wcolor[],int l);//产生食物的函数
void Direction();//方向函数
void Move(HANDLE handle,WORD wScolor[],WORD wcolor[]);//控制蛇的移动的函数
void Turning(bool *start);//蛇的转向函数
void gameover(HANDLE handle,WORD wcolor[]);//游戏结束画面
void begin(HANDLE handle);
struct Food //食物的结构体
{ 
int x; //食物的横坐标
int y; //食物的纵坐标 
int yes; //食物是否出现的变量
}food; 

struct Snack //蛇的结构体
{ 
int x[100]; 
int y[100]; 
int node; //蛇的节数
int direction; //蛇的方向
int life; //蛇的生命，0活着，1死亡
}snake; 
//主函数
int main(void)
{
	HANDLE handle;
    handle=initiate();
	WORD wcolors[1],wcolor[1],wScolor[1],wcolorss[4];
	wcolors[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
    wcolor[0]=FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wScolor[0]=FOREGROUND_RED|FOREGROUND_INTENSITY;
	wcolorss[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_rNTENSITY;
	wcolorss[1]=FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wcolorss[2]=FOREGROUND_GREEN|FOREGROUND_INTENSITY;
	wcolorss[3]=FOREGROUND_BLUE|FOREGROUND_INTENSITY;
	//开始画面
	begin(handle);
	//打印边框
    Menu(handle,wcolors,wcolor,wcolorss,wScolor);
	//初始化一些值
	snake.direction=1;
	snake.life=0;
	snake.x[0]=18;
	snake.y[0]=6;
	snake.node=2;
	food.yes=1;
	if(_kbhit)//_kbhit与_kbhit()是有区别的
	{
		_getch();
    //初始移动
	Move(handle,wScolor,wcolor);
	}
	return 0;
}
//辅助函数
void Menu(HANDLE handle,WORD wcolors[],WORD wcolor[],WORD wcolorss[],WORD wScolor[])
{
	int i;
textout(handle,16,5,wcolors,1,"◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎");
textout(handle,16,25,wcolors,1,"◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎◎");
//点出现的位置x(17-59,60)偶数,y(6-24)自然序列
for(i=6;i<25;i++)
    textout(handle,16,i,wcolors,1,"◎");
for(i=6;i<25;i++)
    textout(handle,60,i,wcolors,1,"◎");
for(i=6;i<25;i++)
    textout(handle,74,i,wcolors,1,"◎");
textout(handle,64,10,wcolor,1,"等级:");
textout(handle,64,11,wcolor,1,"1");
textout(handle,64,15,wcolor,1,"得分:");
textout(handle,64,16,wcolor,1,"0");
textout(handle,16,27,wcolorss,4,"1.按任意键，游戏开始");
textout(handle,16,28,wcolorss,4,"2.w(上),s(下),a(左),d(右)作为方向键控制");
textout(handle,16,29,wcolorss,4,"3.游戏设有加速系统，速度会随着等级的提升而加快");
textout(handle,16,30,wcolorss,4,"4.按键盘‘z’键暂停");
textout(handle,16,31,wcolorss,4,"5.请检查Capslock是否关闭，请关闭后再开始游戏");
textout(handle,55,36,wcolorss,4,"李南希倾情制作.");
textout(handle,38,2,wcolors,1,"贪!食!蛇!");
textout(handle,16,4,wcolorss,4,"请先将窗口最大化，您将会看到提示!");
textout(handle,8,8,wScolor,1,"挑");
textout(handle,8,9,wScolor,1,"战");
textout(handle,8,10,wScolor,1,"你");
textout(handle,8,11,wScolor,1,"的");
textout(handle,8,12,wScolor,1,"极");
textout(handle,8,13,wScolor,1,"限");
textout(handle,8,14,wScolor,1,"!");
textout(handle,2,19,wcolors,1,"<(￣▽￣)> ");
textout(handle,5,20,wcolors,1,"哇哈哈...");

}
void FoodProduce(HANDLE handle,WORD wcolor[],int l)
{
    srand(time(NULL));
	bool produce=true;
	int count=0; 
	while(produce)  //保证食物不会出现在蛇的身体上
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
	textout(handle,food.x,food.y,wcolor,1,"☆");
}

void Direction()
{
	switch(snake.direction)
	{
	case 1:snake.x[0]+=2;break; //右
	case 2:snake.x[0]-=2;break; //左
	case 3:snake.y[0]-=1;break; //上
	case 4:snake.y[0]+=1;break; //下
	}
}

void Turning(bool *start)//设定按键
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
	static bool started=true;//设定bool型变量，控制循环条件
	int i;
	while(1)//蛇移动的大循环
	{
		while(started)
		{
		static int count=100;
		static long int rank=1;
		static long int initialspeed=250;//设定初始移速度
		long int nowspeed=initialspeed-rank*30;
		if(nowspeed<=0) nowspeed=10; //确保高手不会造成游戏bug，保证速度始终大于0
		textout(handle,snake.x[0],snake.y[0],wScolor,1,"◆");
		Sleep(nowspeed);//控制移动速度的变化，随着等级的上升越来越快
		textout(handle,snake.x[0],snake.y[0],wScolor,1,"  ");
		Direction();
		//产生食物
        if(food.yes==1)
		{
			FoodProduce(handle,wcolor,snake.node);
			food.yes=0;
		}
		for( i=snake.node;i>0;i--) //贪吃蛇的移动算法
		{ 
			snake.x[i]=snake.x[i-1]; 
			snake.y[i]=snake.y[i-1]; //贪吃蛇的身体移动算法
			textout(handle,snake.x[i],snake.y[i],wcolor,1,"◇");//画出身体
			textout(handle,snake.x[snake.node],snake.y[snake.node],wcolor,1,"  ");//擦去身体最后一个，让身体动起来
		} 
		for(i=3;i<snake.node;i++) //判断是否头部与身体相撞
		{ 
			if(snake.x[i]==snake.x[0]&&snake.y[i]==snake.y[0]) 
			{
				snake.life=1; 
				gameover(handle,wcolor);
				break;
			}
		}
		if((snake.x[0]<17)||(snake.x[0]>58)||(snake.y[0]>24)||(snake.y[0]<6))//判断是否与墙碰到
		{
			snake.life=1;
			gameover(handle,wcolor);
			break;
		}
		if(snake.x[0]==food.x&&snake.y[0]==food.y)
		{
			//增加得分
			char number1[30];
			char number2[15];
			textout(handle,64,16,wcolor,1,"      ");
			textout(handle,64,16,wcolor,1,_itoa(count,number1,10));//itoa(将整型变为字符型)
			food.yes=1;
			snake.node++;
			count+=100;
			textout(handle,64,11,wcolor,1,"      ");
			textout(handle,64,11,wcolor,1,_itoa(rank,number2,10));
			rank=count/1000+1;
		}
				if(_kbhit()) break;
		}
		if(snake.life==1) break;//退出大循环
		Turning(&started);
	}

}

void begin(HANDLE handle)
{
	WORD wcolor[1],wcolor1[1],wcolor2[1],wcolor3[1];
	int i;
	wcolor[0]=FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY;//白
	wcolor1[0]=FOREGROUND_GREEN;//绿
	wcolor2[0]=FOREGROUND_BLUE;//蓝
	wcolor3[0]=BACKGROUND_RED|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_INTENSITY;//背景色白
	textout(handle,10,8,wcolor,1,"这是一款古老而又神秘的游戏.....");
	Sleep(2200);
	for(i=10;i<40;i++)
	{
			textout(handle,i,8,wcolor,1,"  ");
			Sleep(60);
	}
	textout(handle,15,10,wcolor1,1,"从来没有人知道它起始于哪里，而又终结于何方....");
	Sleep(2200);
	for(i=15;i<60;i++)
	{
			textout(handle,i,10,wcolor,1,"  ");
			Sleep(60);
	}
	textout(handle,10,12,wcolor2,1,"很多人都在里面迷失，失去了自我，不知道自己将来的路究竟会怎样..");
	Sleep(2200);
	for(i=10;i<80;i++)
	{
			textout(handle,i,12,wcolor,1,"  ");
			Sleep(60);
	}
    textout(handle,25,7,wcolor,1,"它");
	Sleep(1200);
	textout(handle,29,8,wcolor,1,"就");
	Sleep(1200);
	textout(handle,33,9,wcolor,1,"是");
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

void gameover(HANDLE handle,WORD wcolor[])//设定游戏结束画面
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
			textout(handle,i,17,wcolor,1,"游戏结束啦~！！！！按任意键退出");
			Sleep(60);
            textout(handle,i,17,wcolor,1,"                               ");
		}
		if(_kbhit()) break;
	}
}
