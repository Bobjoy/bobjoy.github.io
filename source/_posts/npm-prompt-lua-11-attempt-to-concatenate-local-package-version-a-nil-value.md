title: "npm_prompt.lua:11: attempt to concatenate local 'package_version' (a nil value)"
date: 2016-02-04 09:31:06
categories: ["编程开发"]
tags: ["Nodejs"]
photos:
  - "https://images.pexels.com/photos/859933/pexels-photo-859933.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
问题：

![](http://7xkexv.dl1.z0.glb.clouddn.com/20160204/cmder.png)

解决办法：

方法一、 `package.json`中添加`version`属性

方法二、修改`CMDER_HOME\vendor\clink-completions\npm_prompt.lua`文件

![](http://7xkexv.dl1.z0.glb.clouddn.com/20160204/npm_prompt.png)
