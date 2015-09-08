
// heartDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "heart.h"
#include "heartDlg.h"
#include "math.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CheartDlg �Ի���




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


// CheartDlg ��Ϣ�������

BOOL CheartDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CheartDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
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

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CheartDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

