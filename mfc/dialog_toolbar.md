# Adding a Toolbar to a Dialog-Based Application

<https://www.codeguru.com/windows/adding-a-toolbar-to-a-dialog-based-application/>

<https://www.codeguru.com/cplusplus/how-to-display-tooltips-for-a-toolbar-in-a-dialog/>

************************

Annoying as it is, the MFC does not provide
an automatic Toolbar for Dialog Classes. Many of the Apps I
create are Dialog based. I enjoy providing the user with the
prototypical MS toolbar for starting events.

I realize this article may be simplistic, however,
many of the readers (I include myself in this category) often are
starting from scratch on a project and require some easy code to
accomplish a small task. So why re-invent the wheel.

## What to do

### First:

In the Resource Editor insert a new toolbar
resource. Create the Buttons on the Toolbar and assign each
button a unique ID (as you would for a normal MFC Doc/View
project); For our case we will call this resource `IDC_TOOLBAR1`

### Second:

Declare a vraiable in the proteted section of the CDialog Class.
```cpp
CToolBar m_wndToolBar;
```

### Third:

In the `CDialog::OnInitDialog` member function add the following code:

**Note: In order to add the toolbar we need to expand the Client Window size to
accomodate the Toolbar.**

```cpp
// Create the Toolbar and attach the resource
if( !m_wndToolBar.Create(this)
    || !m_wndToolBar.LoadToolBar(IDR_TOOLBAR1) )
{
    TRACE0("Failed to Create Dialog Toolbarn");
    EndDialog(IDCANCEL);
}

CRect	rcClientOld;        // Old Client Rect
CRect	rcClientNew;        // New Client Rect with Tollbar Added
GetClientRect(rcClientOld); // Retrive the Old Client WindowSize

// Called to reposition and resize control bars in the client 
// area of a window. The reposQuery FLAG does not really draw the 
// Toolbar. It only does the calculations. And puts the new 
// ClientRect values in rcClientNew so we can do the rest of the 
// Math.
RepositionBars( AFX_IDW_CONTROLBAR_FIRST,
    AFX_IDW_CONTROLBAR_LAST, 0, reposQuery, rcClientNew);

// All of the Child Windows (Controls) now need to be moved so 
// the Tollbar does not cover them up. Offest to move all child 
// controls after adding Tollbar
CPoint  ptOffset(rcClientNew.left-rcClientOld.left,
            rcClientNew.top-rcClientOld.top);

CRect	rcChild;

// Handle to the Dialog Controls
CWnd*	pwndChild = GetWindow(GW_CHILD);
while(pwndChild) // Cycle through all child controls
{
    pwndChild->GetWindowRect(rcChild); // Get the child control RECT
    ScreenToClient(rcChild);

    // Changes the Child Rect by the values of the claculated offset
    rcChild.OffsetRect(ptOffset);
    pwndChild->MoveWindow(rcChild,FALSE); // Move the Child Control
    pwndChild   = pwndChild->GetNextWindow();
}

CRect	rcWindow;
GetWindowRect(rcWindow); // Get the RECT of the Dialog

// Increase width to new Client Width
rcWindow.right += rcClientOld.Width() - rcClientNew.Width();

// Increase height to new Client Height
rcWindow.bottom += rcClientOld.Height() - rcClientNew.Height();

MoveWindow(rcWindow,FALSE); // Redraw Window

// Now we REALLY Redraw the Toolbar
RepositionBars(AFX_IDW_CONTROLBAR_FIRST,
 AFX_IDW_CONTROLBAR_LAST,0);
```

That's it. It's not dockable, but it sure beats trying to put a lot of
little buttons on the Dialog.

Several people requested a demo and how to handle
the buttons. Attached is a samll sample demo. Doesn't really do
much. What needs to be done to add functionality. When you add
the toolbar. Click on each button and add an ID (I used IDM_A,
IDM_B, etc). Then from the Class Wizard. Select the ID and Add
the function ON_COMMAND. Since I have not been able to get the
CMDUI update function working, I simply added a pointer to the
toolbar and retrieved the info for the specific button, then
changed the button style and reset the button either enabling (0)
or disabling(TBBS_DISABLED) the button. Hope this helps...

[Downloads](dlgtoolbar.zip)
