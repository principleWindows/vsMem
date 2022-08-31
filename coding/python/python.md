# VS Python

- [Multithreading in Python](https://www.scaler.com/topics/multithreading-in-python/)
- [python��װ�Լ��Ĵ��뵽site-packages](https://blog.csdn.net/kang389110772/article/details/80766344)
- [python��װ���������İ�װ·����dist-packages��site-packages����](https://halen.blog.csdn.net/article/details/90080103)
- [https://docs.microsoft.com/en-us/visualstudio/python/quickstart-05-python-visual-studio-open-folder?view=vs-2022](https://docs.microsoft.com/en-us/visualstudio/python/quickstart-05-python-visual-studio-open-folder?view=vs-2022)

*****************************

## Index

0. [Overview](#overview) \
   [0.1 ��װ](#installation) \
   [0.2 dist-packages��site-packages����](#dist_n_site)
1. [Python Packages](#Python-Packages) \
   [1.1 Creating Package](#Creating-Package) \
   [1.2 Understanding `__init__.py`](#Understanding) \
   [1.3 Import Modules from a Package](#Import-Modules-from-a-Package)
2. [pythonģ�鰲װ��Site-packages�̳�](#install-modules) \
   [2.1 ��������](#create-setup) \
   [2.2 ��װ����](#install-setup)
3. [��������Ŀ](#create-project)


## 0 Overview

pythonĬ�Ͻ�������ģ�鰲װ��site-packages, ����python��ִ�е�ʱ����������path��

- **package**: ����__init__.py��Ŀ¼, ��һ�����Ҫ
- **module**: ����py�ļ�

### 0.1 ��װ <span id="installation"></span>

setup.py:
```python
from setuptools import setup, find_packages

setup(
    name="python_learning",
    version="1.0",
    keywords="request util",
    description="request",
    long_description="description",
    license="MIT Licence",

    author="kevin",
    packages=find_packages(exclude=['cn.kevin.database', 'cn.kevin.es', 'cn.kevin.github', 'cn.kevin.deploy']),
    include_package_data=True,
    platforms="mac",
    install_requires=['requests'],
)
```

[Back to index](#index)


### 0.2 dist-packages��site-packages���� <span id="dist_n_site"></span>

����˵
�����ϵͳ�Դ���python����ʹ��dist-packagesĿ¼��

������ֶ���װpython������ֱ��ʹ��Ŀ¼site-packages��

����������������װ���뿪����

dist-packages��ϵͳ�Դ���python

site-packages���Լ���װ��python

Python�İ��İ�װ·������

1��ϵͳ�Դ�python
ϵͳ�Դ������������װ�� ģ�齫����װ�� dist-packages


/usr/lib/python2.7/dist-packages/
�� easy_install �� pip (ע�� ��python����������䣬python������������) ʹ�ã�����Ҳʹ�� dist-packages,����·���ǣ�

/usr/local/lib/python2.7/dist-packages/


2���Լ���װ�������������python
python��װ���������·���ǣ�

/usr/lib/python2.7/site-packages/
�� easy_install �� pip ��װ�ĵ������ⰲװ·���ǣ�

/usr/local/lib/python2.7/site-packages/

3����root�û����� easy_install �� pip��װ��������İ�װ·����

~/.local/lib/python2.7/site-packages
��ʱ����Ҫ�����������·���Ƿ��ڣ�����������������һ���ӣ�����·������ĳ���⣬����import�Ҳ�����ֻ��ָ������Ķ�Ӧ�Ŀ⣩

~/.local/lib/python2.7/site-packages/external/protobuf/python

[Back to index](#index)


## 1 Python Packages

<https://www.geeksforgeeks.org/python-packages/>
---------------

We usually organize our files in different folders and subfolders based on some 
criteria, so that they can be managed easily and efficiently. For example, we 
keep all our games in a Games folder and we can even subcategorize according to 
the genre of the game or something like this. The same analogy is followed by 
the Python package. 

A Python module may contain several classes, functions, variables, etc. whereas 
a Python package can contains several modules. In simpler terms a package is 
folder that contains various modules as files.


### 1.1 Creating Package

Let's create a package named mypckg that will contain two modules mod1 and mod2. 
To create this module follow the below steps �C 

- Create a folder named mypckg.
- Inside this folder create an empty Python file i.e. `__init__.py`
- Then create two modules mod1 and mod2 in this folder.

Mod1.py
```python
def gfg():
    print("Welcome to GFG")
```

Mod2.py
```python
def sum(a, b):
    return a+b
```

The hierarchy of the our package looks like this �C 
```batch
mypckg
|
|
---__init__.py
|
|
---mod1.py
|
|
---mod2.py
```

[Back to index](#index)


### 1.2 Understanding `__init__.py` <span id="Understanding"></span>

__init__.py helps the Python interpreter to recognise the folder as package. It also 
specifies the resources to be imported from the modules. If the __init__.py is empty 
this means that all the functions of the modules will be imported. We can also specify 
the functions from each module to be made available.

For example, we can also create the __init__.py file for the above module as �C 

`__init__.py`
```python
from .mod1 import gfg
from .mod2 import sum
```

This `__init__.py` will only allow the gfg and sum functions from the mod1 and mod2 
modules to be imported.

[Back to index](#index)


### 1.3 Import Modules from a Package

We can import these modules using the from��import statement and the dot(.) operator. 

Syntax:
```python
import package_name.module_name
```

#### Example: Import Module from package

We will import the modules from the above created package and will use the functions 
inside those modules.
```python
from mypckg import mod1
from mypckg import mod2
 
mod1.gfg()
res = mod2.sum(1, 2)
print(res)
```

Output:
```batch
Welcome to GFG
3
```

[Back to index](#index)


## 2 pythonģ�鰲װ��Site-packages�̳� <span id="install-modules"></span>
------------------------------------
��ο� <https://www.jianshu.com/p/10532e6fa9ca>

��ʹ�� python ��������У�������Ҫ�����Լ���ģ�顣�� Python �ı�׼���ǲ�����չ�ģ�
Ϊ�����ǿ��Բ��� Python �� Site-packages ���ڴ�λ�������Ӻ�ɾ���Լ��Ļ������ģ�顣���ڽ��� ��Python 
ģ�鰲װ�� Site-packages �Ĳ��衣


### 2.1 �������� <span id="create-setup"></span>

#### step 1 ������װ�ļ� setup.py

���Ͻ��е� mypckg ��Ϊ���ӣ����������� setup.py �ļ�������Ƭ����������
```python
from setuptools import setup    # ��"setuptools"ģ��������"setup" ����

setup(  # ����һ��"setup"�������ã����ǰ����Ĳ��������ڶ�����
    name="python_learning",         # package ������
    version="1.0",
    keywords="gfg sum",
    description="package install",
    long_description="description",
    license="MIT Licence",

    author="whu",
    author_mail='someone@somewhere.com'
    url='https://www.somewhere.com',
    platforms="mac",
    py_modules=['gfg,sum'],
)
```

#### step 2 ���ɷ���

��Ҫ�� mypckg �ļ��д����һ�������ļ���

Powershell��mypckg�ļ���,
```batch
py  -3  setup.py  sdist
```

![](pix/setup.py.run.png)


### 2.2 ��װ���� <span id="install-setup"></span>

```batch
py -3 -m pip install python_learning-1.0.tar.gz
```

���Ұ�װλ�ã����� python ���������У�
```batch
import site; site.getsitepackages()
```

�õ���
```shell
>>> import site; site.getsitepackages()
['D:\\Program Files (x86)\\Microsoft Visual Studio\\Shared\\Python39_64', 
'D:\\Program Files (x86)\\Microsoft Visual Studio\\Shared\\Python39_64\\lib\\site-packages']
```

����װʱδʹ�ù���ԱȨ�ޣ����ŵ������ļ��е�������Ӧλ��
```shell
C:\Users\jiche\AppData\Roaming\Python\Python39\site-packages
```

[Back to index](#index)


## 3 ��������Ŀ <span id="create-project"></span>

new python windows project


[Back to index](#index)




