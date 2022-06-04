from setuptools import setup    # 从"setuptools"模块中引入"setup" 函数

setup(  # 这是一个"setup"函数调用，我们把它的参数分列在多行上
    name="python_learning",         # package 的名称
    version="1.0",
    keywords="gfg sum",
    description="package install",
    long_description="description",
    license="MIT Licence",

    author="whu",
    author_mail='someone@somewhere.com',
    url='https://www.somewhere.com',
    platforms="mac",
    py_modules=['gfg,sum'],
)
