# latex

调用ctex处理中文文稿，要用XeLaTeX编译；而用CJK处理中文文稿时，要采用pdfLaTeX编译。

## Index

1. [如何拆分源文件并且分别编译](#sep_comp)
2. [Management in a large project](#management-in-a-large-project) \
   [2.1 Inputting and including files](#inputting-and-including-files) \
   [2.2 Preamble in a separate file](#preamble-in-a-separate-file) \
   [2.3 Using the import package](#using-the-import-package)
3. [References](#references)


## 1. 如何拆分源文件并且分别编译 {#sep_comp}

**这一章的方法在将路径改为绝对路径后才取得成功，怀疑在VS环境中task.vs.json中任务其当前路径非文件所在路径**

当处理很大的文档时，经常将文件分成若干个部分分别进行编译，这时我们可以使用`LATEX`所提供的命令:
- \input
- \include
- \includeonly

**\input{texfile}**\
文件名只需指定基本名，不需加扩展名`.tex`，它等价于直接将文件“文件名.tex”中的内容输入到命令
`\input`所处的位置.

**样例参见文件夹samples/1/中的main1.tex等**

此命令可以放在文档的任何地方(导言区或正文区)，而且可以相互嵌套。

您可以将经常使用的导言放在单独的一个文件中，使用时置于源文件之首。

在\begin{document}....\end{document}之间加入多个`\input`命令，导言区加入`\listfiles`
可以得到读入文件的清单。

**\include{texfile}**\
使用`\input`命令的缺点是，通过`\input`命令合并起来的文章(不管那部分) 每经过一次修改，
所有的文件都要被重新读入和处理。若用`\input`命令仅加载那个特定的文件，那么所有的页码、章节、
插图和公式等的自动编号都从1开始，这会使交叉引用产生混乱。更好的办法是采用`\include`命令。

它只能放在文档的正文区，不能嵌套，且与命令`\includeonly{文件清单}`结合使用。

文件清单列出当前正在处理的文件(其中的文件名不需要加后缀`.tex`，各文件名用逗号隔开)。若`\input`
命令后的文件名在文件清单中，则此命令等价于
```shell
\clearpage\input{文件名}\clearpage
```
否则相当于换页。因此文档应该在新页开始(如章与章之间)分割。`\include`命令可以帮助我们省去很多宝贵
的编译时间。它的主要好处是页面、章节和公式编号的附加信息可以由`\includeonly`命令提供，
因此交叉引用这类命令，如`\ref`和`pageref`命令等能生成正确的结果。此命令可多次使用，
所需的导言区仅有一个。

样例：编辑一本由8章组成的书籍：
```shell
\documentclass{book}
导言区
\includeonly{.....}
\begin{document}
\frontmatter
\include{toc}
\mainmatter
\include{chapt1}
...
\include{chapt8}
\backmatter
\printindex
\end{document}
```
通过在`\includeonly`命令中添加适当的项，如`\includeonly{toc,chapt8}` 
就可以选择性地处理各章(这里为第8章)。

[Back to index](#index)


## 2 Management in a large project

In large projects, such as books, keeping parts of your document in several .tex 
files makes the task of correcting errors and making further changes easier. It's 
simpler to locate a specific word or element in a short file. For this purpose 
this Chapter explains how to manage big projects.

[Back to index](#index)

### 2.1 Inputting and including files

The standard tools to insert a LATEX file into another are \input and \include.

#### input command
`\input{filename}`

Use this command in the document body to insert the contents of another file named 
filename.tex; this file should not contain any LATEX preamble code (i.e. no 
`\documentclass`, `\begin{document}` or `\end{document}` ). LATEX won't start a 
new page before processing the material in filename.tex. `\input` allows you to 
nest `\input` commands, in files that are already being inputted by the root file.

#### include command
`\include{filename}`

Use this command in the document body to insert the contents of another file named 
filename.tex; again this file should not contain any LATEX preamble. LATEX will start 
a new page before processing the material input from filename.tex. Make sure not to 
include the extension .tex in the filename, as this will stop the file from being 
input (the extension can optionally be included with input and import). It is not 
possible to nest include commands. Each file that gets `\include`d has its own `.aux` 
file storing information of created labels and contents for the table of contents, 
list of figures, etc. You can use `\includeonly` with a comma separated list of file 
names (**make sure that there are no leading or trailing spaces**). If you do this LATEX 
will only process the files contained in that list. This can be used to enhance 
compilation speed if you're only working on a small part of a bigger document. Page 
numbers and cross references will however still work, as the `.aux` files of left 
out files will still be processed.

[Back to index](#index)


### 2.2 Preamble in a separate file

If the preamble of your document has many user-defined commands or term definitions 
for the glossary, you can put it in a separate file. The right way is to create a 
custom package, which is a file with the `.sty` extension. Let's see an example:
```ruby
\ProvidesPackage{example}

\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage[latin1]{inputenc}
\usepackage[spanish, english]{babel}
\usepackage{graphicx}
\usepackage{blindtext}
\usepackage{textcomp}
\usepackage{pgfplots}

\pgfplotsset{width=10cm,compat=1.9}

%Header styles
\usepackage{fancyhdr}
\setlength{\headheight}{15pt}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}{}}
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[RE]{\textbf{\textit{\nouppercase{\leftmark}}}}
\fancyhead[LO]{\textbf{\textit{\nouppercase{\rightmark}}}}
\fancypagestyle{plain}{ %
\fancyhf{} % remove everything
\renewcommand{\headrulewidth}{0pt} % remove lines as well
\renewcommand{\footrulewidth}{0pt}}

%makes available the commands \proof, \qedsymbol and \theoremstyle
\usepackage{amsthm}

%Ruler
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

%Lemma definition and lemma counter
\newtheorem{lemma}{Lemma}[section]

%Definition counter
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]

%Corolary counter
\newtheorem{corolary}{Corolary}[section]

%Commands for naturals, integers, topology, hull, Ball, Disc, Dimension, boundary and a few more
\newcommand{\E}{{\mathcal{E}}}
\newcommand{\F}{{\mathcal{F}}}
...

%Example environment
\theoremstyle{remark}
\newtheorem{examle}{Example}

%Example counter
\newcommand{\reiniciar}{\setcounter{example}{0}}
```
All the commands in this file could have been put in the preamble, but the main file 
would have become confusing because of this large amount of code, and to locate the 
actual body of the document in such large file would be a cumbersome task.

This file could also be put in a normal `.tex` file and imported with the command 
import (see the next section), but a `.sty` file prevents possible errors if the file 
is accidentally imported more than once.

Notice that the first line of the example is

`\ProvidesPackage{example}`
this means that we have to import this package as example in the main file, i.e. with 
the command
```ruby
\usepackage{example}
```
as shown in the introduction.

**Note**: A `.sty` file is far more flexible, it can be used to define your own macros 
and optional parameters can be passed, see 
[Writing your own package](https://www.overleaf.com/learn/latex/Writing_your_own_package).

[Back to index](#index)


### 2.3 Using the import package

#### 重要事项 1
> **When you use the import package (which provides the `\import` command), you must use 
slashes `/` in your path.**
> \
> **E.g.**
```ruby
\import{/Users/Public/Documents/}{subfile}
```
> **Also, be sure that you put `/` at the end of the path.**

#### 重要事项 2
> In short, you need to use `\import` (**absolute paths**) or `\subimport` 
> (**relative paths**) if you want to nest imports, and want the imported file 
> (first level) to use its own path as the base for further imports (second level). 
> If your TikZ picture doesn't make further imports, you don't need to use \import. 

#### 正文
As mentioned above The standard tools to insert a LATEX file into another are 
`\input` and `\include`, but these are prone to errors if nested file importing 
is needed. For this reason you may want to consider the package import.

Below is an example of a book whose sections and user-defined commands are stored 
in separate files, and where the image files for each chapter are stored in separate 
folders along with the `.tex` file for each chapter.
```ruby
\documentclass[a4paper,11pt]{book}
\usepackage{import}
\usepackage{example}

\usepackage{makeidx}
\makeindex

\begin{document}

\frontmatter
\import{./}{title.tex}

\clearpage
\thispagestyle{empty}

\tableofcontents

\mainmatter
\chapter{First chapter}
\import{sections/}{section1-1.tex}
\import{sections/}{section1-2.tex}

\chapter{Additional chapter}
\import{sections/}{section2-1.tex}

\chapter{Last chapter}
\import{sections/}{section3-1.tex}

\backmatter

\import{./}{bibliography.tex}

\end{document}
```
As you see, the example is a book with three chapters and several sections in a 
neat main file that pulls external files to generate the final document. The 
command `\frontmatter` in the book document class is used for the first pages of 
the document, the page numbering style is set to Roman numerals by this command; 
the command `\mainmatter` resets the page numbering and changes the style to Arabic, 
`\backmatter` disables the chapter numbering (suitable for the bibliography and 
appendices).

```ruby
\chapter{First chapter}
\import{sections/}{section1-1.tex}
\import{sections/}{section1-2.tex}
```

First, add this line to the preamble of your document:
```ruby
\usepackage{import}
```

Then use `\import{ }{ }`. The first parameter inside braces is the directory where 
the file is located, it can be relative to the current working directory or absolute. 
The second parameter is the name of the file to be imported

There is also available the command `\subimport` that has the same syntax, but if 
used in one of the files that are imported in the main file, the path will be 
relative to that sub-file. For instance, below is the contents of the file 
"section1-1.tex" that was imported in the previous example:
```ruby
\section{First section}

Below is a simple 3d plot

\begin{figure}[h]
\centering
\subimport{img/}{plot1.tex}
\caption{Caption}
\label{fig:my_label}
\end{figure}

[...]
```
As you see, this file imports a pgf plot file called "plot1.tex" that creates a 3d 
plot. This file is imported by
```ruby
\subimport{img/}{plot1.tex}
```
from the "img" folder, contained in the folder "sections".

If `\import` were used instead, the path `img/` would be relative to the main file, 
instead of the folder "sections" where "section1-1.tex" is saved.

[Back to index](#index)


## 3 References

1. [【LaTeX】自用简洁模板（五）：课程作业](https://zhuanlan.zhihu.com/p/381769429?utm_medium=social&utm_oi=1196798803867680768)
2. [LaTex 常用语法](https://blog.csdn.net/SmartLab307/article/details/123268896)
3. [Latex插入项目符号和编号](https://blog.csdn.net/u012947821/article/details/45196695?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-45196695-blog-105123190-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-45196695-blog-105123190-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&utm_relevant_index=1)
4. [LaTex数学符号表（数学中最常用的所有符号）](https://blog.csdn.net/God_68/article/details/81667943)
5. [LaTeX 公式篇](https://zhuanlan.zhihu.com/p/110756681)
6. [LaTeX数学符号大全](https://blog.csdn.net/LCCFlccf/article/details/89643585)
7. [Writing your own package](https://www.overleaf.com/learn/latex/Writing_your_own_package)
8. [Management in a large project](https://www.overleaf.com/learn/latex/Management_in_a_large_project)
9. [Multi-file LaTeX projects](https://www.overleaf.com/learn/latex/Multi-file_LaTeX_projects)
10. [LaTeX 黑魔法（一）：tcolorbox 宏包简明教程](https://liam.page/2016/07/22/using-the-tcolorbox-package-to-create-a-new-theorem-environment/)
11. [Latex文件如何拆分进行独立编译？](https://blog.csdn.net/tsingke/article/details/105961046)
12. [How to use the import package?](https://tex.stackexchange.com/questions/58465/how-to-use-the-import-package/58485#58485)
13. [Import specific section from another tex file](https://stackoverflow.com/questions/56218371/import-specific-section-from-another-tex-file)
14. [What are the alternatives to catchfilebetweentags?](https://tex.stackexchange.com/questions/582353/what-are-the-alternatives-to-catchfilebetweentags)
15. [Using `\input` to insert a section of a document into another](https://newbedev.com/index.php/using-input-to-insert-a-section-of-a-document-into-another)
16. [Catchfilebetweentags not working](https://tex.stackexchange.com/questions/477585/catchfilebetweentags-not-working)
17. [Import specific section from another tex file](https://stackoverflow.com/questions/56218371/import-specific-section-from-another-tex-file)
18. [【杂记】（二）latex](https://zhuanlan.zhihu.com/p/145470121)
19. [【干货】LaTeX代码样式](https://www.bilibili.com/read/cv14216857)
20. [LaTeX编译C语言,LaTeX分文件编译教程](https://blog.csdn.net/weixin_36200503/article/details/117143058)
21. [关于分开编写多个LaTeX文件的一点微小的总结](https://www.cnblogs.com/mashiqi/p/6033323.html)
22. [LaTeX多文件编译的方法总结](https://www.136.la/tech/show-342955.html)
23. [Latex的分段编译(input,includeonly,include的使用)](https://blog.csdn.net/x_1203/article/details/105615355?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&utm_relevant_index=2)
24. [LaTeX技巧如何拆分源文件并且分别编译](https://blog.csdn.net/garfielder007/article/details/51606670)
25. [LaTeX_fleqn参数时，多行公式对齐居中的同时选择性的加编号](https://www.cnblogs.com/mashiqi/p/5979446.html)
26. [LATEX 公式编号、子公式编号方法](https://zhuanlan.zhihu.com/p/99406531)
27. [Latex特殊符号大全(高清)](https://blog.csdn.net/begant/article/details/119240508)


[Back to index](#index)

