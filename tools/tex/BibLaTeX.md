# bibliography

- [Basic bibliography with biber](https://riptutorial.com/latex/example/12683/basic-bibliography-with-biber)
- [使用 biblatex 进行参考文献管理](https://blog.csdn.net/xovee/article/details/109894721)
- [biblatex宏包使用后端bibtex和biber的区别](https://blog.csdn.net/xenonhu/article/details/87899868)
- [tex中的文件输出](https://blog.csdn.net/xenonhu/article/details/84895568)
- [LaTeX教程1](https://blog.csdn.net/weixin_41790863/article/details/120642780)
- [LaTeX学习 |（14）LaTex中的参考文献BibLaTex](https://blog.csdn.net/qq_40276310/article/details/110499291)
- [Troubleshooting for biber](https://newbedev.com/troubleshooting-for-biber)
- [How to use Biber with BibLaTeX from the command line](https://tex.stackexchange.com/questions/268463/how-to-use-biber-with-biblatex-from-the-command-line)


The year field should only ever contain a (four-digit) year. For fancy 
things like date ranges or full dates you should use the date field, 
which accepts ISO8601 input (see §2.3.8 Date and Time Specifications, 
esp. Tables 3, 4 and 5 of the 
[biblatex](http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf) 
[manual](http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf)
).


```batch
texdoc biblatex
```

*****************************************

To start a bibliography you need to define your sources. Create a 
`database file` (like `sources.bib`) and include some content:

```batch
@book{Doe1993,
    Author = {John Doe},
    Publisher = {Earth University},
    Title = {Creating a bibliography with biber},
    Year = {1993}}
```

You can then include your database file in your main document and 
cite the new source (`Doe1993`).

```cpp
\documentclass{article}

% Include the biblatex package and tell it to use biber as a backend.
% Without specifying the backend, it assumes biber.
\usepackage[backend=biber]{biblatex}

% Define where biber can find your sources
\addbibresource{sources.bib}

\begin{document}
"Biber isn't that difficult." \cite{Doe1993}
% Use \cite{source-ID} to generate a citation

% Print the bibliography
\printbibliography
\end{document}
```

To compile the document, you will need to run 3 commands in sequence:

- pdflatex to create an auxiliary file which tells biber what sources 
are needed
- biber to create an auxiliary file with all the sources which can be 
used by pdflatex
- pdflatex to include the auxiliary file and create the PDF

