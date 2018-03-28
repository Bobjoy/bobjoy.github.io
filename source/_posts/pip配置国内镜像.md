title: pip配置国内镜像
date: 2015-09-07 14:19:40
categories: ["编程开发"]
tags: ["Python"]
photos:
  - "https://images.pexels.com/photos/69969/pexels-photo-69969.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
在安装python包的过程中，经常会出现如下错误：

```python
Downloading/unpacking ...
Cleaning up...
Exception:
Traceback (most recent call last):

  ...

SSLError: The read operation timed out
```
这个主要是墙的问题，但是又无法代理又无法翻~~一墙，被逼着想到了使用镜像的方法了，一些公共的网站在国内总有一些镜像，使用这些镜像地址来安装就可以了

有了目的性搜索很快就搜索到了两个有效的镜像：
```
https://pypi.tuna.tsinghua.edu.cn/simple/
http://pypi.v2ex.com/simple/
```

使用镜像的方法可以在每次执行pip的时候加上参数`-i http://pypi.v2ex.com/simple`即可，或者也可以在本地配置，这样就不用每次都加上参数了：

使用pip的用户可以如下配置：

* 在unix和macos，配置文件为：$HOME/.pip/pip.conf
* 在windows上，配置文件为：%HOME%\pip\pip.ini

需要在配置文件内加上：

```
[global]
index-url=http://mirrors.tuna.tsinghua.edu.cn/pypi/simple
```

还有一个小技巧，就是把所有要安装的包写在一个文件里面，比如requirement.txt(每个包写一行，顶行头写)，然后pip安装的时候只需要加参数"-r  requirement.txt"即可。
