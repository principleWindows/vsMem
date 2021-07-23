# Linter

<https://wikimili.com/en/Lint_(software)>

<https://www.testim.io/blog/what-is-a-linter-heres-a-definition-and-quick-start-guide/>

<https://hyperleap.com/topic/Stephen_C._Johnson>

<https://www.ibm.com/garage/method/practices/code/tool_lint>

<https://developerexperience.io/practices/linting>

<https://laptrinhx.com/why-you-should-always-use-a-linter-3798048761/>

<https://prettier.io/docs/en/index.html>

编辑工具应该能够自动以不同的编码风格显示源代码，而无需程序员遵从相同的代码规范（命名规范除外）

******************************************

Lint, or a linter, is a static code analysis tool used to flag programming errors, bugs, 
stylistic errors and suspicious constructs. The term originates from a Unix utility that 
examined C language source code. 

What is a linter? In short, a linter is a tool to help people improve their codes. 
The majority of people trying to learn about linters are interested in the ones that 
target dynamically-typed languages.

Here in this page we start by defining the term “linter.” 
Then, we talk about the benefits of linters and proceed to talk about the different types 
of checks they offer.
Finally, we show you several examples of linters at your disposal, give some practical tips 
on how to get started, and wrap-up with a few final considerations.

## 1 What Is a Linter? A Brief Overview

A linter is a tool to help you improve your code. But in what ways does it do that? 
The answer is: by analyzing your source code looking for problems.

The term linter comes from a tool originally called “lint” that analyzed C source code. 
The computer scientist Stephen C. Johnson developed this utility in 1978 when he worked 
at Bell Labs.

Both the original lint tool, as well as earlier similar utilities, had the goal of analyzing 
source code to come up with compiler optimizations. Over time, lint-like tools started adding 
many other types of checks and verification.

However, linters aren’t restricted to compiled languages. On the contrary: we could say that 
linters are way more valuable for interpreted languages since there’s no compiler to detect 
errors during development time.

## 2 Advantages of Linting

In more practical terms, what are the benefits that this type of tool can provide? Here are some:

* **Fewer errors** in production. 
Linters help to diagnose and fix technical issues, e.g. code smells—in the code. 
As a result, fewer defects make their way to production.
* **Readable**, **maintainable**, and **more consistent** code. 
Linters can help teams achieve a more readable and consistent style, through the enforcement 
of its rules.
* **Fewer discussions about code style and aesthetic choices during code reviews**. 
Code review discussions shouldn’t be riddled with endless arguments about stylistic preferences. 
Linters can take those topics out of the way.
* **Objective measurement of code quality**. Discussions about code quality often veer into 
subjectivity. Linters provide an objective and measurable assessment of code quality.
* **More secure and performant code**. Not all linters analyze source code regarding its 
performance and safety, but some do.
* **Education about code quality reaches more developers**. Linters can help 
developers — particularly the most inexperienced ones — to learn about code quality.

The next section covers some of the types of verifications that linters provide. After 
reading it, you’ll understand how linters provide the benefits above.


## 3 Types of Checks Linters Provide

As you’ve just read, the original lint tool analyzed code to enable optimizations for 
compilers, but over time, more advanced and complete tools were released. Nowadays, we have 
myriad different linters, which provide many types of checks. Let’s quickly go through some 
of them.

### 3.1 Syntax Errors

The most basic and more vital type of checks that a linter can provide are syntax error 
verifications when it comes to JavaScript and other interpreted languages. Developers 
shouldn’t even push code to the mainline without it passing syntax verifications.

One way to accomplish this is to use pre-commit hooks that prevent users from pushing 
their code when the linter verification indicates there are issues with the code.

### 3.2 Code Standards Adherence

Another vital type of check that linters provide is adherence to coding standards. Some 
people might dismiss this as a purely aesthetic concern, but they’d be wrong. Having a single 
consistent coding style is beneficial for decreasing the cognitive load of reading, 
understanding, and maintaining code. A codebase that has a consistent code style will be 
easier to understand, and the developers that use it will be less likely to introduce bugs.

That’s why there are linters that specialize in verifying codebases for adherence to code 
styles. Some tools are opinionated, i.e. they come with a pre-defined set of rules and 
conventions that can’t be changed. On the other hand, there are tools that can be highly 
configurable, allowing the user to adapt the tool to their preferred coding styles.

### 3.3 Potential Problems (a.k.a. Code Smells)

Code smells are signs that something might be wrong with your code. It’s amazingly useful to 
have a tool to detect those signs automatically, so you can investigate them further, 
if necessary.

For instance, many people consider long functions to be a code smell. So, you could configure 
your linter to detect functions that are longer than a given number of lines.

Another often cited code smell is code that is too complex. But we’re not talking about 
complexity in a subjective way, but a very objective one. Cyclomatic complexity is a useful 
code metric that represents the number of possible execution paths inside a function. Linters 
can calculate the cyclomatic complexity of your functions and flag those that are higher than 
a certain threshold.

### 3.4 Security Checks

Last, but not least, we have security, which is, without a doubt, the most critical facet of 
a modern application, especially a web app. Get it wrong, and the consequences can be 
catastrophic, not only in regards to money and reputation but even legal ones (think GDPR 
and similar regulations.)

Fortunately, this is another area where linters can be of help since there are tools that 
provide important security verifications.


## 4 Understanding Static Analysis

We’ve explained what linters are and why they’re useful. Also, we’ve covered the main types 
of linters. You’re now ready to learn about some examples of linting tools for a variety of 
uses and target programming languages.

Before we get there, though, let’s take a brief digression to talk about static analysis, 
since this term appears in the next section, and we haven’t defined it yet.

So, what’s static analysis? You can think of static analysis as a pre-run debug. Static 
analysis consists of using tools that analyze your source code looking for errors, lack of 
adherence to rules or conventions, or other potential problems.

The next section shows examples of linters categorized according to the type of verification 
they perform. Entries categorized under static analysis refer mostly to the first and third 
types of linters listed in the above section.


## 5 Examples of Linters

Let’s now briefly mention some examples of linters. We’ll show examples for different 
programming languages, categorized by the type of checking they provide. Keep in mind that 
some tools might offer more than one type of verification, so that’s the reason some tools 
appear in more than one category.

### 5.1 Linters for Static Analysis

* StandardJS for JavaScript
* PHPMD for PHP
* StyleCop for C#

### 5.2 Linters for Security

* Gosec for Go
* Bandit for Python
* LGTM for several languages, including JavaScript, Python, and C#

### 5.3 Linters for Coding Conventions / Coding Formatting

* Prettier for JavaScript
* Rubocop for Ruby
* StyleCop for C#
