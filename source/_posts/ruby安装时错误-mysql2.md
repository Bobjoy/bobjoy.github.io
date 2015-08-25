title: ruby安装时错误-mysql2
date: 2015-08-03 12:45:34
tags: ["Ruby"]
---
执行`bundle install`时，控制台报错：  
![](http://7xkexv.dl1.z0.glb.clouddn.com/15-8-3/98718111.jpg)

解决:`sudo gem install mysql2 -v '0.3.16'`，如果还不行，则

`sudo apt-get install libmysqlclient-dev`,安装后再运行上边的命令