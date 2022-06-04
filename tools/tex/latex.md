# latex

����ctex���������ĸ壬Ҫ��XeLaTeX���룻����CJK���������ĸ�ʱ��Ҫ����pdfLaTeX���롣

## Index

1. [��β��Դ�ļ����ҷֱ����](#sep_comp)
2. [Management in a large project](#management-in-a-large-project) \
   [2.1 Inputting and including files](#inputting-and-including-files) \
   [2.2 Preamble in a separate file](#preamble-in-a-separate-file) \
   [2.3 Using the import package](#using-the-import-package)
3. [References](#references)


## 1. ��β��Դ�ļ����ҷֱ���� {#sep_comp}

**��һ�µķ����ڽ�·����Ϊ����·�����ȡ�óɹ���������VS������task.vs.json�������䵱ǰ·�����ļ�����·��**

������ܴ���ĵ�ʱ���������ļ��ֳ����ɸ����ֱַ���б��룬��ʱ���ǿ���ʹ��`LATEX`���ṩ������:
- \input
- \include
- \includeonly

**\input{texfile}**\
�ļ���ֻ��ָ�����������������չ��`.tex`�����ȼ���ֱ�ӽ��ļ����ļ���.tex���е��������뵽����
`\input`������λ��.

**�����μ��ļ���samples/1/�е�main1.tex��**

��������Է����ĵ����κεط�(��������������)�����ҿ����໥Ƕ�ס�

�����Խ�����ʹ�õĵ��Է��ڵ�����һ���ļ��У�ʹ��ʱ����Դ�ļ�֮�ס�

��\begin{document}....\end{document}֮�������`\input`�������������`\listfiles`
���Եõ������ļ����嵥��

**\include{texfile}**\
ʹ��`\input`�����ȱ���ǣ�ͨ��`\input`����ϲ�����������(�����ǲ���) ÿ����һ���޸ģ�
���е��ļ���Ҫ�����¶���ʹ�������`\input`����������Ǹ��ض����ļ�����ô���е�ҳ�롢�½ڡ�
��ͼ�͹�ʽ�ȵ��Զ���Ŷ���1��ʼ�����ʹ�������ò������ҡ����õİ취�ǲ���`\include`���

��ֻ�ܷ����ĵ���������������Ƕ�ף���������`\includeonly{�ļ��嵥}`���ʹ�á�

�ļ��嵥�г���ǰ���ڴ�����ļ�(���е��ļ�������Ҫ�Ӻ�׺`.tex`�����ļ����ö��Ÿ���)����`\input`
�������ļ������ļ��嵥�У��������ȼ���
```shell
\clearpage\input{�ļ���}\clearpage
```
�����൱�ڻ�ҳ������ĵ�Ӧ������ҳ��ʼ(��������֮��)�ָ`\include`������԰�������ʡȥ�ܶ౦��
�ı���ʱ�䡣������Ҫ�ô���ҳ�桢�½ں͹�ʽ��ŵĸ�����Ϣ������`\includeonly`�����ṩ��
��˽����������������`\ref`��`pageref`�������������ȷ�Ľ����������ɶ��ʹ�ã�
����ĵ���������һ����

�������༭һ����8����ɵ��鼮��
```shell
\documentclass{book}
������
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
ͨ����`\includeonly`����������ʵ������`\includeonly{toc,chapt8}` 
�Ϳ���ѡ���Եش������(����Ϊ��8��)��

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

#### ��Ҫ���� 1
> **When you use the import package (which provides the `\import` command), you must use 
slashes `/` in your path.**
> \
> **E.g.**
```ruby
\import{/Users/Public/Documents/}{subfile}
```
> **Also, be sure that you put `/` at the end of the path.**

#### ��Ҫ���� 2
> In short, you need to use `\import` (**absolute paths**) or `\subimport` 
> (**relative paths**) if you want to nest imports, and want the imported file 
> (first level) to use its own path as the base for further imports (second level). 
> If your TikZ picture doesn't make further imports, you don't need to use \import. 

#### ����
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

1. [��LaTeX�����ü��ģ�壨�壩���γ���ҵ](https://zhuanlan.zhihu.com/p/381769429?utm_medium=social&utm_oi=1196798803867680768)
2. [LaTex �����﷨](https://blog.csdn.net/SmartLab307/article/details/123268896)
3. [Latex������Ŀ���źͱ��](https://blog.csdn.net/u012947821/article/details/45196695?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-45196695-blog-105123190-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-45196695-blog-105123190-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&utm_relevant_index=1)
4. [LaTex��ѧ���ű���ѧ����õ����з��ţ�](https://blog.csdn.net/God_68/article/details/81667943)
5. [LaTeX ��ʽƪ](https://zhuanlan.zhihu.com/p/110756681)
6. [LaTeX��ѧ���Ŵ�ȫ](https://blog.csdn.net/LCCFlccf/article/details/89643585)
7. [Writing your own package](https://www.overleaf.com/learn/latex/Writing_your_own_package)
8. [Management in a large project](https://www.overleaf.com/learn/latex/Management_in_a_large_project)
9. [Multi-file LaTeX projects](https://www.overleaf.com/learn/latex/Multi-file_LaTeX_projects)
10. [LaTeX ��ħ����һ����tcolorbox ��������̳�](https://liam.page/2016/07/22/using-the-tcolorbox-package-to-create-a-new-theorem-environment/)
11. [Latex�ļ���β�ֽ��ж������룿](https://blog.csdn.net/tsingke/article/details/105961046)
12. [How to use the import package?](https://tex.stackexchange.com/questions/58465/how-to-use-the-import-package/58485#58485)
13. [Import specific section from another tex file](https://stackoverflow.com/questions/56218371/import-specific-section-from-another-tex-file)
14. [What are the alternatives to catchfilebetweentags?](https://tex.stackexchange.com/questions/582353/what-are-the-alternatives-to-catchfilebetweentags)
15. [Using `\input` to insert a section of a document into another](https://newbedev.com/index.php/using-input-to-insert-a-section-of-a-document-into-another)
16. [Catchfilebetweentags not working](https://tex.stackexchange.com/questions/477585/catchfilebetweentags-not-working)
17. [Import specific section from another tex file](https://stackoverflow.com/questions/56218371/import-specific-section-from-another-tex-file)
18. [���Ӽǡ�������latex](https://zhuanlan.zhihu.com/p/145470121)
19. [���ɻ���LaTeX������ʽ](https://www.bilibili.com/read/cv14216857)
20. [LaTeX����C����,LaTeX���ļ�����̳�](https://blog.csdn.net/weixin_36200503/article/details/117143058)
21. [���ڷֿ���д���LaTeX�ļ���һ��΢С���ܽ�](https://www.cnblogs.com/mashiqi/p/6033323.html)
22. [LaTeX���ļ�����ķ����ܽ�](https://www.136.la/tech/show-342955.html)
23. [Latex�ķֶα���(input,includeonly,include��ʹ��)](https://blog.csdn.net/x_1203/article/details/105615355?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1.pc_relevant_default&utm_relevant_index=2)
24. [LaTeX������β��Դ�ļ����ҷֱ����](https://blog.csdn.net/garfielder007/article/details/51606670)
25. [LaTeX_fleqn����ʱ�����й�ʽ������е�ͬʱѡ���Եļӱ��](https://www.cnblogs.com/mashiqi/p/5979446.html)
26. [LATEX ��ʽ��š��ӹ�ʽ��ŷ���](https://zhuanlan.zhihu.com/p/99406531)
27. [Latex������Ŵ�ȫ(����)](https://blog.csdn.net/begant/article/details/119240508)


[Back to index](#index)

