# Control Bars

<https://docs.microsoft.com/en-us/cpp/mfc/tn031-control-bars>

**********************************************

## 1 CControlBar

A `ControlBar` is a `CWnd`-derived class that:

- Is aligned to the top or bottom of a frame window.
- May contain child items that are either HWND-based controls (for example, 
`CDialogBar`) or non-`HWND` based items (for example, `CToolBar`, `CStatusBar`).

Control bars support the additional styles:

- CBRS_TOP (The default) pin the control bar to the top.
- CBRS_BOTTOM Pin the control bar to the bottom.
- CBRS_NOALIGN Do not reposition the control bar when the parent resizes.

Classes derived from `CControlBar` provide more interesting implementations:

- `CStatusBar` A status bar, items are status bar panes containing text.
- `CToolBar` A toolbar, items are bitmap buttons aligned in a row.
- `CDialogBar` A toolbar-like frame containing standard windows controls 
(created from a dialog template resource).
- `CDockBar` A generalized docking area for other `CControlBar` derived 
objects. The specific member functions and variables available in this class 
are likely to change in future releases.

All control bar objects/windows will be child windows of some parent frame 
window. They are usually added as a sibling to the client area of the frame 
(for example, an MDI Client or view). The child window ID of a control bar is 
important. The default layout of control bar only works for control bars with 
IDs in the range of AFX_IDW_CONTROLBAR_FIRST to AFX_IDW_CONTROLBAR_LAST. Note 
that even though there is a range of 256 control bar IDs, the first 32 of these 
control bar IDs are special since they are directly supported by the print 
preview architecture.

The `CControlBar` class gives standard implementation for:

- Aligning the control bar to the top, bottom, or either side of the frame.
- Allocating control item arrays.
- Supporting the implementation of derived classes.

C++ control bar objects will usually be embedded as members of a `CFrameWnd` 
derived class, and will be cleaned up when the parent `HWND` and object are 
destroyed. If you need to allocate a control bar object on the heap, you can 
simply set the *m_bAutoDestruct* member to TRUE to make the control bar 
"delete this" when the HWND is destroyed.


### 1.1 Control Bar Layout Algorithm

The control bar layout algorithm is very simple. The frame window sends a 
message WM_SIZEPARENT to all children in the control bar range. Along with 
this message, a pointer to the parent's client rectangle is passed. This 
message is sent to children in Z-order. The control-bar children use this 
information to position themselves and to decrease the size of the parent's 
client area. The final rectangle that is left for the normal client area 
(less control bars) is used to position the main client window (usually an 
MDI client, view or splitter window).

See `CWnd::RepositionBars` and `CFrameWnd::RecalcLayout` for more details.

MFC private Windows messages, including WM_SIZEPARENT, are documented in 
[Technical Note 24](https://docs.microsoft.com/en-us/cpp/mfc/tn024-mfc-defined-messages-and-resources).


## 2 CStatusBar

[CStatusBar Class](https://github.com/MicrosoftDocs/cpp-docs/blob/master/docs/mfc/reference/cstatusbar-class.md#:~:text=CStatusBar%3A%3ASetIndicators%20Sets%20each%20indicator%27s%20ID%20to%20the%20value,string.%20BOOL%20SetIndicators%20%28const%20UINT%2A%20lpIDArray%2C%20int%20nIDCount%29%3B)

********************

A status bar is a control bar that has a row of text output panes. There are 
two common ways to use text output panes:

- As a message line\
(for example, the standard menu help message line). These are usually accessed 
by a 0-based indexed

- As status indicators\
(for example, the CAP, NUM and SCRL indicators). These are usually accessed by 
string/command ID.

The font for the status bar is 10-point MS Sans Serif (dictated by the Windows 
Interface Application Design Guide or the font mappers best match of a 10-point 
Swiss proportional font). On certain versions of Windows, such as the Japanese 
edition, the fonts selected are different.

The colors used in the status bar are also consistent with the recommendation 
of the Windows Interface Application Design Guide. These colors are not hard 
coded and are changed dynamically in response to user customization in Control 
Panel.

### 2.1 CCmdUI Support for CStatusBar

The way indicators are usually updated is through the ON_UPDATE_COMMAND_UI 
mechanism. On idle time, the status bar will call the ON_UPDATE_COMMAND_UI 
handler with the string ID of the indicator pane.

The ON_UPDATE_COMMAND_UI handler can call:

- `Enable`: To enable or disable the pane. A disabled pane looks exactly like an 
enabled pane but the text is invisible (that is, turns off the text indicator).
- `SetText`: To change the text. Be careful if you use this because the pane will 
not automatically resize.

Refer to class [CStatusBar](https://docs.microsoft.com/en-us/cpp/mfc/reference/cstatusbar-class) 
in the Class Library Reference for details about `CStatusBar` creation and 
customization APIs. Most customization of status bars should be done before 
the status bar is initially made visible.

The status bar supports only one stretchy pane, usually the first pane. The 
size of that pane is really a minimum size. If the status bar is bigger than the 
minimum size of all the panes, any extra width will be given to the stretchy pane. 
The default application with a status bar has right-aligned indicators for CAP, 
NUM and SCRL since the first pane is stretchy.


## 3 CToolBar

1. [MFC������(CToolBar)�ؼ���������](https://blog.csdn.net/zcx515545/article/details/24544857)
2. [How to display tooltips for a toolbar in a dialog](https://www.codeguru.com/cplusplus/how-to-display-tooltips-for-a-toolbar-in-a-dialog/)

******************************

�������ؼ��ڿؼ������û�ж�Ӧ��ѡ�ͼ�꣩������һ���������ؼ���CToolBar,
�����������Ҫ����һ���������ؼ�����ʾ�ڴ�����Ļ���ֻ���ô�������ɡ���ʵ���κ�һ�ֿؼ����������ô��봴����
�� CButton ��ť�࣬�־�һ���ô��봴����ť�ؼ�����ʾ�ڴ���������ӡ�

`CButton` ��� `Create` ��Ա�������Դ���һ����ť�ؼ�����������ĸ�ʽ���£�
```cpp
BOOL CButton::Create(
    LPCTSTR     lpszCaption,    // ��ť��ʾ���ı�
    DWORD       dwStyle,        // ��ť��ʽ
    const RECT& rect,           // ��ť�ؼ���ʾ�����򣨴�С������ڸ�����
    CWnd *      pParentWnd,     // ��ť�ĸ�����(��ť�����ĸ����ڣ�
    UINT        nID             // ָ����ť�ؼ�ID��
);
```
��������ĵڶ������� `dwStyle` �ǰ�ť�ؼ�����ʽ��Ҳ�����ڿ��ӻ���Ӱ�ť�ؼ�ʱ���һ���ť�ؼ���ѡ�����ԣ�
֮��ᵯ��һ���Ի�������Ի�����һ����ʽ��ѡ��ò�������Ӧ�����ʽ��


### 3.1 Create a toolbar in a dialog



**δ�꣬������������� yabeePlatform �� CControlCenterDlg �Ĵ������˵��**


## 4 CDialogBar

