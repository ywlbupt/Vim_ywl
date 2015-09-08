
// heartDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "heart.h"
#include "heartDlg.h"
#include "math.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CheartDlg 对话框




CheartDlg::CheartDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CheartDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CheartDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CheartDlg, CDialog)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


// CheartDlg 消息处理程序

BOOL CheartDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CheartDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		
		CPaintDC dc(this);
		CPen mypen(PS_SOLID , 1 , RGB(255,0,0));
		dc.SelectObject(&mypen);
		CRect rect;
		GetClientRect(&rect);
		dc.FillSolidRect(&rect, RGB(255,255,255));
		rect.right -= 10;
		rect.bottom -= 55;
		double x, y, y2;
		int i = 0;
		x = rect.right / 2;
		y = rect.bottom / 5;
		dc.MoveTo(x + 5, y + 5);
		for (i = 1; i <= 500; i++)
		{
			x = i / 500.0;
			y = pow(x * x, 1.0/3) + sqrt(1 - x*x);
			x = (x + 1) * rect.right / 2;
			y = (3 - 2 * y) * rect.bottom / 5;
			dc.LineTo(x + 5, y + 5);
			Sleep(1);
		}
		for (i = 500; i >= -500; i--)
		{
			x = i / 500.0;
			y = pow(x * x, 1.0/3) - sqrt(1 - x*x);
			x = (x + 1) * rect.right / 2;
			y = (3 - 2 * y) * rect.bottom / 5;
			dc.LineTo(x + 5, y + 5);
			Sleep(1);
		}
		for (i = -500; i <= 0; i++)
		{
			x = i / 500.0;
			y = pow(x * x, 1.0/3) + sqrt(1 - x*x);
			x = (x + 1) * rect.right / 2;
			y = (3 - 2 * y) * rect.bottom / 5;
			dc.LineTo(x + 5, y + 5);
			Sleep(1);
		}

		for (i = -500; i <= 500; i++)
		{
			x = i / 500.0;
			y = pow(x * x, 1.0/3) - sqrt(1 - x*x);
			y2 = pow(x * x, 1.0/3) + sqrt(1 - x*x);
			x = (x + 1) * rect.right / 2;
			y = (3 - 2 * y) * rect.bottom / 5;
			y2 = (3 - 2 * y2) * rect.bottom / 5;
			dc.MoveTo(x + 5, y + 5);
			dc.LineTo(x + 5, y2 + 5);
		}
		CDialog::OnPaint();	
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CheartDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

