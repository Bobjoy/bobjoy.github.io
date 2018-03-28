title: node-sass模块安装失败
date: 2016-05-08 09:46:30
categories: ["Nodejs"]
tags: ["Nodejs", "Sass"]
photos:
	- "https://images.pexels.com/photos/843266/pexels-photo-843266.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
### 一、下载对应平台二进制文件

node-sass 3.4.2 版本二进制文件下载地址：[https://github.com/sass/node-sass/releases/tag/v3.4.2]()
或者：[https://github.com/sass/node-sass-binaries]()

### 二、设置环境变量

安装时执行：

* windows

	```
	set SASS_BINARY_PATH=[FILE_PATH]\win32-x64-47_binding.node
	```

* linux

	```
	SASS_BINARY_PATH=/path/to/win32-x64-47_binding.node
	```

或者添加到系统环境变量：设置变量 SASS_BINARY_PATH 为二进制文件地址，

* windows

	环境变量SASS_BINARY_PATH, 值为文件路径， 如：`E:\Programs\nodejs\win32-x64-47_binding.node`

* linux

	修改用户目录下的`.bashrc`文件，添加如下代码`SASS_BINARY_PATH=/path/to/win32-x64-47_binding.node`
<!-- more -->

### 三、检查

* windows

	```
	echo %SASS_BINARY_PATH%
	```

* linux

	```
	echo $SASS_BINARY_PATH
	```

### 四、安装

* windows

	```
	npm install node-sass --save-dev
	```

* linux

	```
	sudo npm install node-sass --save-dev
	```

> 参考地址：https://github.com/luqin/blog/issues/9
