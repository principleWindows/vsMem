# `CWnd::RepositionBars` ������ `WM_SIZEPARENT` ��Ϣ

1. [CWnd::RepositionBars������WM_SIZEPARENT��Ϣ](https://blog.csdn.net/qiuchengw/article/details/6255459)
2. [Is there an equivalent to RepositionBars() when using CMFCToolBars?](https://social.msdn.microsoft.com/forums/en-US/fa4de71b-826f-429b-af89-4bbccee923ca/is-there-an-equivalent-to-repositionbars-when-using-cmfctoolbars)
3. 

***************************

���������Լ���CWnd������һ�������ಢ����һ������,
�����Ŀͻ�����Ҫ�������ɸ��Ӵ��ڣ�������ʹ��Щ�Ӵ������еù��ؾ�,
�����ص����������ڵĳߴ����ʱ�����Ӵ�������ʱ�����Լ��ĳߴ��λ��,
ʹ�����Ӵ���֮���λ�ô�С������ϵ���䡣���ƶ�����һ���򼸸��Ӵ���ʱ,
����Ӵ����ܼ�ʱΪ����ƶ��˵��Ӵ�����λ��

����ڸ����ڵĿͻ��������˹�������״̬���ȵ��Ӵ���ʱ,
���Լ��ӽ������Ӵ��ڻ��ܺ���Щmfc�ṩ���Ӵ�����Ǣ�ദ��?
��α�֤����Ӵ��ڲ��Ḳ���Ĵ�ͣ���Ĺ�����?
����������״̬����ʧ������Ӵ�����β���֪��,
�Ա㼰ʱ�����Լ��Ĵ�С�Ӷ����ǹ�������״̬���ڳ��Ŀռ�?
�����ĵ���ͼ���ܵĴ��ڵĿͻ����ڻ��и���ͼ,
���Լ�Ӳ���ϵ��Ӵ����ܲ�����ͼ������������ 

���Ա����˽�mfc�Ĵ��ڹ������Ŀͻ����ķ�������ʵ,
mfc�Ĵ��ڹ������Ŀͻ����ķ����Ƿǳ��򵥵ģ������ڵ���һ������,
�Ӵ�����Ӧһ����Ϣ������ô�ࡣ

**CWnd::RepositionBars������WM_SIZEPARENT��Ϣ**

## 1 MFC �Ĵ���Ϊ�Ӵ��ڷ���ͻ����ռ�Ĺ���

��һ�����Ǹ��������Ӵ��ڹ�ͬЭ����ɵġ����������ṩ���Ŀͻ����ڵ�һ������,
������ʼ��������Ȼ�����һ������`CWnd::RepositionBars( )`�������������,
�����ڰ���Ƭ����ͨ����ϢWM_SIZEPARENT�ύ�����ĵ�һ���Ӵ��ڣ����Ӵ��ھ����Լ�Ҫռ�ö��һ��,
Ȼ���ڿ��������������ռ�ݵĲ��ֻ���ȥ��������������ͱ���ȥ��һ�顣
�������ٰ����ʣ�µĿ�������ͨ��ͬ������Ϣ�ύ���ڶ����Ӵ���,
�ڶ����Ӵ����ٸ����Լ�����Ҫ�е�һ�顣�����㣬ÿ���Ӵ��ڶ���ȥ�Լ������һ�顣
���ʣ�µĿ�������͸������Ӵ���ʹ�á�

���Կ������������һ���Ӵ�����,
�����Ӵ��ڶ���**������Ϣ��Ӧ���������Լ����㷨�������Լ����ڿ���������ռ�ݶ��һ��**,
���һ���Ӵ������ڱ���ѡ�����Բ���Ҫ�������㷨�� 

��ʼ�Ŀ���������һ�����Σ�ÿ�α��и��ʣ�µĿ���������һ������,
�������Ǳ����״�ġ�

WM_SIZEPARENT �����Ϣ�� mfc �Զ���ģ�����windows���еġ� 

### 1.1 CWnd::RepositionBars() 

������������麯�������Ծ��޷�����������ͨ�������������Լ��İ汾��,
ֻ�ܸ㶮���Ĺ��ܣ��Ա������ʹ�á� 

�򵥶��ԣ���������Ĺ����ǽ����õĿͻ���������Ϣ�ŵ���ϢWM_SIZEPARENT����Ϣ������, 
Ȼ��ö�ٱ����ڵ������Ӵ��ڣ���ÿ���Ӵ��� (����һ���ض����Ӵ���,
�൱�������ᵽ�����һ���Ӵ���)�����������Ϣ,
ÿ����Ӧ�����Ϣ���Ӵ��ڶ���ѿ��ÿͻ�����ȥһ�顣
�����Ǹ��ض����Ӵ��ڵĳߴ��λ�õ������պ÷������ʣ�µĿ��������

### 1.2 WM_SIZEPARENT

ÿ�����������ͻ������Ӵ��ڶ�Ҫ��Ӧ�����Ϣ����������Ӵ������Ǹ��ض����Ӵ��ڡ�

��Ӧ�����Ϣ���Ӵ�������Ҫ�������£�
1. �����õĸ����ڿͻ�����ȥ�Լ���ռ�ݵ�һ��
2. ������Ϣ������ָʾ�����Լ��Ĵ�С��λ�õ������պ����ɵ��Լ���ռ�ݵ�������������� 

### 1.3 CWnd::RepositionBars() �Ĳ���

```cpp
void RepositionBars( UINT nIDFirst, UINT nIDLast, 
        UINT nIDLeftOver,
        UINT nFlag = CWnd::reposDefault,
        LPRECT lpRectParam = NULL, 
        LPCRECT lpRectClient = NULL,
        BOOL bStretch = TRUE ); 
```

#### 1.3.1 nIDFirst��nIDLast 

������丸���ڿͻ������Ӵ��ڵ�id��Χ�� 

ÿ��WM_CHILD���Ĵ��ڶ��и�id�������ڴ��ڴ���������ָ����,
����`CWnd::Create()`�ĵ����������������id��
api ���� CreateWindow �� CreateWindowEx ����Ǹ�HMENU���͵Ĳ���,
�����ڵķ������WM_CHILDʱ��������ָ�Ĳ˵���������Ǹô��ڵ�id�� 

nIDFirst��nIDLast����ָ���ˣ����һ���Ӵ��ڵ�idֵ���ڵ���nIDFirst����С�ڵ���nIDLast,
����������вŻ������Ӵ��ڷ��� WM_SIZEPARENT��Ϣ,
����Ӵ��ڲ��ܲ��븸���ڿͻ����ķ��䡣 

#### 1.3.2 nIDLeftOver 

ǰ��˵������һ���ض����Ӵ��ڣ�������ӦWM_SIZEPARENT��Ϣ��ֻ�е��������Ӵ��ڶ���������,
��������ȡ�����ڿͻ�����ʣ�µ��ǿ顣 nIDLeftOver��������Ӵ��ڵ�id��
��Ҳ������ڵ���nIDFirst����С�ڵ���nIDLast�� 

#### 1.3.3 lpRectClient 

����һ��ָ��RECT�ṹ���ݵ�ָ�롣���RECT�ṹ���ŵ����Ǹ����ڿͻ����ĳ�ʼ��������
�����ڸú��������θ������Ӵ��ڷ��� WM_SIZEPARENT��Ϣ��ÿ����Ӧ�����Ϣ���Ӵ��ڶ���
��ȥ�Լ���ռ�ݵĲ��֡����ʣ�µĲ��֣�����idΪnIDLeftOver���Ӵ��ڽ�Ҫռ�ݵ������ˡ�
�����������ΪNULL����ʱ��ʼ�Ŀ�������������������ڿͻ����� 

#### 1.3.4 nFlag��lpRectParam 

��������������һ�𽲱ȽϺá�nFlag�Ǹú����Ĺ��ܱ�־��������������ֵ��reposDefault,
reposQuery ��reposExtra��

- ��nFlag����reposDefaultʱ��RepositionBars�����Ĺ����������ģ����θ�id����nIDFirst
��nIDLast֮�䲢�Ҳ�����nIDLeftOver���Ӵ��ڷ���WM_SIZEPARENT��Ϣ,
ÿ����Ӧ�����Ϣ���Ӵ��ڴ�lpRectClient��ָ�Ľṹ����ȥ�Լ���ռ�ݵĲ���,
���ҽ��Լ��Ĵ�С��λ�õ������Լ���ռ�ݵ�����Ĵ�С,
��� RepositionBars �������� id Ϊ nIDLeftOver
���Ӵ��ڵĴ�С��λ�õ������������Ӵ�����ʣ�Ŀ���������,
ʹ����Ӵ���������ȫ�������Ŀ���������������� lpRectParam ���ã����� ΪNULL�� 

- ��nFlag����reposQuery ʱ��RepositionBars�����Ĺ�����������:
���θ�id����nIDFirst��nIDLast֮�䲢�Ҳ�����nIDLeftOver���Ӵ��ڷ���WM_SIZEPARENT��Ϣ,
ÿ����Ӧ�����Ϣ���Ӵ��ڴ�lpRectClient��ָ�Ľṹ����ȥ�Լ���ռ�ݵĲ���,
�������ǲ��������Լ��Ĵ�С��λ��,
���RepositionBars��������������idΪnIDLeftOver���Ӵ��ڵĴ�С��λ��,
���Ǹ���bStretch��ֵ�������������bStretchΪTRUE����ô RepositionBars
���������ʣ�µĿ������򿽱���lpRectParamָ���RECT�ṹ��; ���bStretchΪFALSE,
��ôRepositionBars���������������Ӵ���ռ�õ��Ŀ�������ĸߺͿ�
(Ҫ���е��Ӵ��ڶ�������һ���γ�һ����ľ���,
���ֵ��������)������ lpRectParam ָ��� RECT �ṹ�� bottom �� right ��Ա��,
��top��left��Ա�����㡣ʹ�����nFlagֵ������ RepositionBars
��Ŀ�Ĳ���Ҫ�����Ӵ��ڣ�����Ҫ���������������Ӵ��ڵĻ�����Щ�Ӵ��ڽ�ռȥ���һ��,
���ʣ�µĿ���������ʲôλ�õȵ���Ϣ�� 
 
- ��nFlag����reposExtraʱ���ú����Ĺ��ܺ�nFlag����reposDefaultʱ��࣬�е�СС������
��ʱ��Ҫ�õ�lpRectParam��ǰ��˵������ nFlag����reposDefaultʱ��RepositionBars
������������idΪnIDLeftOver���Ӵ��ڵĴ�С��λ�õ������������Ӵ�����ʣ�Ŀ���������,
ʹ����Ӵ���������ȫ�������Ŀ������򡣶���nFlag����reposExtraʱ,
RepositionBars�ڵ���idΪnIDLeftOver���Ӵ��ڵĴ�С��λ��ǰ,
��Ҫ�� lpRectParam�������ʣ�µĿ�������������������lpRectָ��������Ŀ�������,
��ô����������������еģ� 
```cpp
lpRect->top     += lpRectParam->top; 
lprect->left    += lpRectParam->left; 
lpRect->right   -= lpRectParam->right; 
lpRect->bottom  -= lpRectParam->bottom; 
```
ͨ������������������ʹ���ʣ�µĿ������򲻱�idΪnIDLeftOver���Ӵ���ռ��,
���ǿճ�һЩ�ط����������á�

#### 1.3.5 bStretch 

������������Ѿ��ᵽһ���������á�����Ҫ���ṩ��������ӦWM_SIZEPARENT��Ϣ���Ӵ����õ�,
�Ӵ������繤������״̬�����ھ����Լ����Ӹ����ڿͻ����Ŀ��ÿռ��ﻮ�߶���ʱ,
�������Ҳ�Ǹ��жϵ����ݡ���ϸ���Բ��Ĺ�������״̬����ӦWM_SIZEPARENT�ĺ���OnSizeParent()�� 


### 1.4 WM_SIZEPARENT �Ĳ���

���Ǹ�mfc�Զ������Ϣ����msdn���TN024��ƪ�����������й��������Ϣ��˵���� 

 

����Ϣ������������wParam���ã�lParam��ָ��һ��AFX_SIZEPARENTPARAMS�ṹ������ָ�룬 

����ṹ��������RepositionBars�����ﶨ��ģ� 

 

AFX_SIZEPARENTPARAMS layout; 

 

AFX_SIZEPARENTPARAMS�ṹ�������£� 

 

struct AFX_SIZEPARENTPARAMS 

{ 

HDWP hDWP; 

RECT rect; 

SIZE sizeTotal; 

BOOL bStretch; 

}; 

����ṹ�����ĳ�Ա����RepositionBars��������д�ģ�����bStretch��Ա����RepositionBars 

�Ĳ���bStretch������sizeTotal��Ա��������Աcx��cy��������Ϊ�㣬����rect��Ա���Ǵ� 

RepositionBars�Ĳ���lpRectClient���������ģ����Ǹ����ڿͻ����ĳ�ʼ���������ÿ�� 

��Ӧ�����Ϣ���Ӵ��ڶ������޸�rect��Ա��ֵ���Ա���ȥ�Լ���ռ�ݵĲ��֡� 

��ԱhDWP��ʲô�����֪������api������BebinDeferWindowPos()��DeferWindowPos()�� 

EndDeferWindowPos()��������api�����������������ô��ڵ�λ�úͳߴ�ġ�BebinDeferWindowPos() 

��֪ͨwindows����һ���������������ڵ�λ�úͳߴ���Ϣ�Ľṹ�������Ƿ�������ṹ��ָ�룬 

���Ƿ��ش�������ṹ�ľ���������������HDWP��Ȼ��ÿ����Ҫ��������λ�úͳߴ�Ĵ��ڶ� 

Ҫ����DeferWindowPos()����(�ú�����Ҫ�Ǹ�HDWP ���͵ľ��Ϊ����)���Ա����Ǹ��ṹ����д 

���ԵĴ���λ�úʹ�С��Ϣ�������ĳ�����ʵ�ʱ�����EndDeferWindowPos()��windows�ͻ� 

�����Ǹ��ṹ�����Ϣ���йصĴ��ڵ�λ�úʹ�Сһ�������úá��������ÿ�����ڷֱ��� 

SetWindowPos()�Ⱥ������������˵�����ַ����ٶȿ졣 

 

���ˣ���RepositionBars���������ǵ�����BebinDeferWindowPos()�����һ��HDWP���͵ľ���� 

�������ͱ���д���������Ǹ��ṹ���� layout�ĳ�ԱhDWP�Ȼ��RepositionBars������ÿ 

�������������Ӵ��ڷ���WM_SIZEPARENT��Ϣ����ÿ����ӦWM_SIZEPARENT��Ϣ���Ӵ����Ҫ 

����DeferWindowPos()������λ�úͳߴ���Ϣ�������е��Ӵ��ڶ���Ӧ���WM_SIZEPARENT��Ϣ 

��RepositionBars�����ٵ��� EndDeferWindowPos()��������һ���������Ǹ�idΪnIDLeftOver 

���Ӵ����⣬���е��Ӵ��ڶ�һ�����ź���λ���ˡ� 

 

���ڸýṹ��sizeTotal��Ա�����壬���ۼ�ÿ���Ӵ�����ռ�ݵ��Ŀ�������ĳ���ߴ�͡�ÿ�� 

�Ӵ�������ӦWM_SIZEPARENT��Ϣʱһ�㶼Ҫ���Լ���ռ�ݵ�����ĸߺͿ�ֱ��ۼӵ�sizeTotal�� 

����cy��cx��Ա�����ʲô�����أ���ÿ���Ӵ�����ռ�ݵ������ǰ���һ���ʱ����� 

sizeTotal�ṹ���������ˣ�����ܴ��ڿ���ʹnFlag����reposQuery��ʹbStretch����FALSE������RepositionBars������RepositionBars������� sizeTotal�ṹ��������Աֵ������lpRectParam 

�����ﷵ�ظ��������(ǰ��Ҳ�ᵽ��)��������������֪�����Ŀͻ����ڵ��Ӵ���ռȥ�˿ͻ��� 

�ڶ���һ��ռ䡣����������ܴ���û�����������Ϣ����ô��ӦWM_SIZEPARENT��Ϣ���Ӵ��� 

�Ϳ��Բ����sizeTotal��Ա�� 

ID�ķ��� 

 

���Կ�����ÿ���Ӵ��ڶ��и�id��ͬһ�������ڵ��Ӵ��ڵ�id�����ظ���mfc��һЩ�ֳɵĿؼ��� 

���ڶ���Ԥ�����id�� 

 

id�� idֵ ���� 

 

AFX_IDW_TOOLBAR 0xE800 // �����ڵĹ�������id 
AFX_IDW_STATUS_BAR 0xE801 // ״̬����id 
AFX_IDW_PREVIEW_BAR 0xE802 // PrintPreview Dialog Bar 
AFX_IDW_RESIZE_BAR 0xE803 // OLE in-place resize bar 
AFX_IDW_REBAR 0xE804 // COMCTL32 "rebar" Bar 
AFX_IDW_DIALOGBAR 0xE805 // CDialogBar 
�������ĵ��������ͼ���ڣ����ĵ�������Ǹ�MDIClient���ڣ��ָ������ڣ����ǵ�idֵ���� 
��������idֵ֮�䣺 
AFX_IDW_PANE_FIRST 0xE900 // 
AFX_IDW_PANE_LAST 0xE9FF 
 

 

��Ҫ�����Լ����Ӵ��ڷ���id�Ļ������������ظ��ˡ�һ�������IDE�Ĳ˵�view/resource 

symbols���������Լ���id�Ļ����ǲ����ظ��ġ��й�id�������Կ���msdn���TN020���£��� 

��ר��id�ġ� 


## 2 ʵ������


## 3 ʵս����


## 4 Tips

��ʵ,������ֻ��������CFrameWnd��ܶ�����ҪView��Doc,
���������Լ����ڱ��ֵ���viewһ���������Ÿ���ͣ�����ڵĴ�С�仯���Զ������Լ�.
��һ������򵥵ķ����������Ǿ���: ���Լ��Ĵ���id����Ϊ: AFX_IDW_PANE_FIRST
