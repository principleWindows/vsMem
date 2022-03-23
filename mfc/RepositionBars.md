# `CWnd::RepositionBars` 函数和 `WM_SIZEPARENT` 消息

1. [CWnd::RepositionBars函数和WM_SIZEPARENT消息](https://blog.csdn.net/qiuchengw/article/details/6255459)
2. [Is there an equivalent to RepositionBars() when using CMFCToolBars?](https://social.msdn.microsoft.com/forums/en-US/fa4de71b-826f-429b-af89-4bbccee923ca/is-there-an-equivalent-to-repositionbars-when-using-cmfctoolbars)
3. 

***************************

假如我们自己从CWnd类派生一个窗口类并生成一个窗口,
在它的客户区里要生成若干个子窗口，我们想使这些子窗口排列得规规矩矩,
互不重叠，当父窗口的尺寸变了时各个子窗口能适时调整自己的尺寸和位置,
使各个子窗口之间的位置大小比例关系不变。当移动其中一个或几个子窗口时,
别的子窗口能及时为这个移动了的子窗口让位。

如果在父窗口的客户区里有了工具栏，状态条等等子窗口时,
你自己加进来的子窗口还能和这些mfc提供的子窗口融洽相处吗?
如何保证你的子窗口不会覆盖四处停靠的工具栏?
当工具栏和状态条消失后你的子窗口如何才能知道,
以便及时调整自己的大小从而覆盖工具栏和状态条腾出的空间?
基于文档视图构架的窗口的客户区内还有个视图,
你自己硬加上的子窗口能不和视图窗口争地盘吗？ 

所以必须了解mfc的窗口管理它的客户区的方法。其实,
mfc的窗口管理它的客户区的方法是非常简单的：父窗口调用一个函数,
子窗口响应一个消息，就这么多。

**CWnd::RepositionBars函数和WM_SIZEPARENT消息**

## 1 MFC 的窗口为子窗口分配客户区空间的过程

这一过程是父窗口与子窗口共同协调完成的。父窗口先提供它的客户区内的一块区域,
叫做起始可用区域。然后调用一个函数`CWnd::RepositionBars( )`，在这个函数里,
父窗口把这片区域通过消息WM_SIZEPARENT提交给它的第一个子窗口，该子窗口决定自己要占用多大一块,
然后在可用区域里把它将占据的部分划出去，这样可用区域就被切去了一块。
父窗口再把这块剩下的可用区域通过同样的消息提交给第二个子窗口,
第二个子窗口再根据自己的需要切掉一块。如此这般，每个子窗口都切去自己所需的一块。
最后剩下的可用区域就给最后的子窗口使用。

可以看出，除了最后一个子窗口外,
其它子窗口都得**在其消息响应函数里有自己的算法来决定自己将在可用区域里占据多大一块**,
最后一个子窗口由于别无选择，所以不需要这样的算法。 

初始的可用区域是一个矩形，每次被切割后剩下的可用区域还是一个矩形,
不可能是别的形状的。

WM_SIZEPARENT 这个消息是 mfc 自定义的，不是windows自有的。 

### 1.1 CWnd::RepositionBars() 

这个函数不是虚函数，所以就无法在派生类里通过覆盖来编制自己的版本了,
只能搞懂它的功能，以便能灵活使用。 

简单而言，这个函数的功能是将可用的客户区区域信息放到消息WM_SIZEPARENT的消息参数里, 
然后枚举本窗口的所有子窗口，给每个子窗口 (除掉一个特定的子窗口,
相当于上文提到的最后一个子窗口)都发送这个消息,
每个响应这个消息的子窗口都会把可用客户区切去一块。
最后把那个特定的子窗口的尺寸和位置调整到刚好放在最后剩下的可用区域里。

### 1.2 WM_SIZEPARENT

每个欲参与分配客户区的子窗口都要响应这个消息，除非这个子窗口是那个特定的子窗口。

响应这个消息的子窗口至少要做两件事：
1. 将可用的父窗口客户区切去自己所占据的一块
2. 根据消息参数的指示，将自己的大小和位置调整到刚好容纳到自己所占据的区域里或不做调整 

### 1.3 CWnd::RepositionBars() 的参数

```cpp
void RepositionBars( UINT nIDFirst, UINT nIDLast, 
        UINT nIDLeftOver,
        UINT nFlag = CWnd::reposDefault,
        LPRECT lpRectParam = NULL, 
        LPCRECT lpRectClient = NULL,
        BOOL bStretch = TRUE ); 
```

#### 1.3.1 nIDFirst和nIDLast 

参与分配父窗口客户区的子窗口的id范围。 

每个WM_CHILD风格的窗口都有个id，这是在窗口创建过程中指定的,
函数`CWnd::Create()`的第六个参数就是这个id。
api 函数 CreateWindow 和 CreateWindowEx 里的那个HMENU类型的参数,
当窗口的风格里有WM_CHILD时，它不是指的菜单句柄，而是该窗口的id。 

nIDFirst和nIDLast参数指明了：如果一个子窗口的id值大于等于nIDFirst并且小于等于nIDLast,
在这个函数中才会给这个子窗口发送 WM_SIZEPARENT消息,
这个子窗口才能参与父窗口客户区的分配。 

#### 1.3.2 nIDLeftOver 

前面说过，有一个特定的子窗口，它不响应WM_SIZEPARENT消息。只有当其它的子窗口都分配完了,
它才来捡取父窗口客户区里剩下的那块。 nIDLeftOver正是这个子窗口的id。
它也必须大于等于nIDFirst并且小于等于nIDLast。 

#### 1.3.3 lpRectClient 

这是一个指向RECT结构数据的指针。这个RECT结构里存放的正是父窗口客户区的初始可用区域。
随着在该函数里依次给各个子窗口发送 WM_SIZEPARENT消息，每个响应这个消息的子窗口都会
切去自己所占据的部分。最后剩下的部分，就是id为nIDLeftOver的子窗口将要占据的区域了。
这个参数可以为NULL，这时初始的可用区域就是整个父窗口客户区。 

#### 1.3.4 nFlag和lpRectParam 

这两个参数放在一起讲比较好。nFlag是该函数的功能标志，它可以有三个值：reposDefault,
reposQuery 和reposExtra。

- 当nFlag等于reposDefault时，RepositionBars函数的功能是这样的：依次给id介于nIDFirst
和nIDLast之间并且不等于nIDLeftOver的子窗口发送WM_SIZEPARENT消息,
每个响应这个消息的子窗口从lpRectClient所指的结构里切去自己所占据的部分,
并且将自己的大小和位置调整到自己所占据的区域的大小,
最后 RepositionBars 函数还将 id 为 nIDLeftOver
的子窗口的大小和位置调整到被其他子窗口切剩的可用区域内,
使这个子窗口正好完全覆盖最后的可用区域。这种情况下 lpRectParam 不用，可以 为NULL。 

- 当nFlag等于reposQuery 时，RepositionBars函数的功能是这样的:
依次给id介于nIDFirst和nIDLast之间并且不等于nIDLeftOver的子窗口发送WM_SIZEPARENT消息,
每个响应这个消息的子窗口从lpRectClient所指的结构里切去自己所占据的部分,
但是他们并不调整自己的大小和位置,
最后RepositionBars函数并不调整将id为nIDLeftOver的子窗口的大小和位置,
而是根据bStretch的值来做动作：如果bStretch为TRUE，那么 RepositionBars
函数把最后剩下的可用区域拷贝到lpRectParam指向的RECT结构里; 如果bStretch为FALSE,
那么RepositionBars函数把所有其他子窗口占用掉的可用区域的高和宽
(要所有的子窗口都紧排在一起，形成一个大的矩形,
这个值才有意义)拷贝到 lpRectParam 指向的 RECT 结构的 bottom 和 right 成员里,
其top和left成员被置零。使用这个nFlag值来调用 RepositionBars
的目的不是要重排子窗口，而是要看看，假如重排子窗口的话，这些子窗口将占去多大一块,
最后剩下的可用区域在什么位置等等信息。 
 
- 当nFlag等于reposExtra时，该函数的功能和nFlag等于reposDefault时差不多，有点小小的区别。
此时需要用到lpRectParam。前面说过，当 nFlag等于reposDefault时，RepositionBars
函数将在最后把id为nIDLeftOver的子窗口的大小和位置调整到被其他子窗口切剩的可用区域内,
使这个子窗口正好完全覆盖最后的可用区域。而当nFlag等于reposExtra时,
RepositionBars在调整id为nIDLeftOver的子窗口的大小和位置前,
还要用 lpRectParam来对最后剩下的可用区域做修正。假设lpRect指向的是最后的可用区域,
那么这个修正是这样进行的： 
```cpp
lpRect->top     += lpRectParam->top; 
lprect->left    += lpRectParam->left; 
lpRect->right   -= lpRectParam->right; 
lpRect->bottom  -= lpRectParam->bottom; 
```
通过这样的修正，可以使最后剩下的可用区域不被id为nIDLeftOver的子窗口占满,
而是空出一些地方来留作他用。

#### 1.3.5 bStretch 

这个参数上面已经提到一点它的作用。它主要是提供给各个响应WM_SIZEPARENT消息的子窗口用的,
子窗口例如工具栏，状态条等在决定自己将从父窗口客户区的可用空间里划走多少时,
这个参数也是个判断的依据。详细可以参阅工具栏和状态条响应WM_SIZEPARENT的函数OnSizeParent()。 


### 1.4 WM_SIZEPARENT 的参数

这是个mfc自定义的消息。在msdn里的TN024这篇技术文章里有关于这个消息的说明。 

 

该消息的两个参数中wParam不用，lParam是指向一个AFX_SIZEPARENTPARAMS结构变量的指针， 

这个结构变量是在RepositionBars函数里定义的： 

 

AFX_SIZEPARENTPARAMS layout; 

 

AFX_SIZEPARENTPARAMS结构定义如下： 

 

struct AFX_SIZEPARENTPARAMS 

{ 

HDWP hDWP; 

RECT rect; 

SIZE sizeTotal; 

BOOL bStretch; 

}; 

这个结构变量的成员是在RepositionBars函数里填写的：它的bStretch成员就是RepositionBars 

的参数bStretch，它的sizeTotal成员的两个成员cx和cy都被设置为零，它的rect成员就是从 

RepositionBars的参数lpRectClient里拷贝过来的，就是父窗口客户区的初始可用区域嘛。每个 

响应这个消息的子窗口都必须修改rect成员的值，以便切去自己所占据的部分。 

成员hDWP是什么？这得知道三个api函数：BebinDeferWindowPos()，DeferWindowPos()和 

EndDeferWindowPos()。这三个api函数是用来成批设置窗口的位置和尺寸的。BebinDeferWindowPos() 

先通知windows分配一个将用来存贮窗口的位置和尺寸信息的结构，它不是返回这个结构的指针， 

而是返回代表这个结构的句柄，句柄的类型是HDWP。然后每个需要重新设置位置和尺寸的窗口都 

要调用DeferWindowPos()函数(该函数需要那个HDWP 类型的句柄为参数)，以便往那个结构里填写 

各自的窗口位置和大小信息。最后，在某个合适的时候调用EndDeferWindowPos()，windows就会 

根据那个结构里的信息把有关的窗口的位置和大小一次性设置好。比起针对每个窗口分别用 

SetWindowPos()等函数逐个设置来说，这种方法速度快。 

 

好了，在RepositionBars函数里正是调用了BebinDeferWindowPos()，获得一个HDWP类型的句柄， 

这个句柄就被填写到了上面那个结构变量 layout的成员hDWP里。然后RepositionBars函数给每 

个符合条件的子窗口发送WM_SIZEPARENT消息。在每个响应WM_SIZEPARENT消息的子窗口里，要 

调用DeferWindowPos()来设置位置和尺寸信息。当所有的子窗口都响应完毕WM_SIZEPARENT消息 

后，RepositionBars函数再调用 EndDeferWindowPos()函数，这一来，除了那个id为nIDLeftOver 

的子窗口外，所有的子窗口都一次性排好了位置了。 

 

至于该结构的sizeTotal成员的意义，它累计每个子窗口所占据掉的可用区域的长宽尺寸和。每个 

子窗口在响应WM_SIZEPARENT消息时一般都要把自己所占据的区域的高和宽分别累加到sizeTotal结 

构的cy和cx成员里。这有什么意义呢？当每个子窗口所占据的区域都是挨在一起的时候，这个 

sizeTotal结构就有意义了，主框架窗口可以使nFlag等于reposQuery，使bStretch等于FALSE来调用RepositionBars函数，RepositionBars函数会把 sizeTotal结构的两个成员值拷贝到lpRectParam 

参数里返回给主框架类(前面也提到过)，这样主框架类就知道它的客户区内的子窗口占去了客户区 

内多大的一块空间。如果你的主框架窗口没有利用这个信息，那么响应WM_SIZEPARENT消息的子窗口 

就可以不理睬sizeTotal成员。 

ID的分配 

 

可以看到，每个子窗口都有个id，同一个父窗口的子窗口的id不能重复。mfc的一些现成的控件子 

窗口都有预定义的id： 

 

id名 id值 意义 

 

AFX_IDW_TOOLBAR 0xE800 // 主窗口的工具栏的id 
AFX_IDW_STATUS_BAR 0xE801 // 状态栏的id 
AFX_IDW_PREVIEW_BAR 0xE802 // PrintPreview Dialog Bar 
AFX_IDW_RESIZE_BAR 0xE803 // OLE in-place resize bar 
AFX_IDW_REBAR 0xE804 // COMCTL32 "rebar" Bar 
AFX_IDW_DIALOGBAR 0xE805 // CDialogBar 
还有象单文档程序的视图窗口，多文档程序的那个MDIClient窗口，分隔条窗口，他们的id值介于 
下面两个id值之间： 
AFX_IDW_PANE_FIRST 0xE900 // 
AFX_IDW_PANE_LAST 0xE9FF 
 

 

你要给你自己的子窗口分配id的话，别和上面的重复了。一般如果用IDE的菜单view/resource 

symbols项来加入自己的id的话，是不会重复的。有关id，还可以看看msdn里的TN020文章，那 

是专讲id的。 


## 2 实例分析


## 3 实战演练


## 4 Tips

其实,假如你只是想利用CFrameWnd框架而不想要View和Doc,
而又想让自己窗口表现得像view一样可以随着各个停靠窗口的大小变化而自动调整自己.
有一个极其简单的方法可以用那就是: 把自己的窗口id设置为: AFX_IDW_PANE_FIRST
