title: "karma start Cannot find module 'jasmine-core'"
date: 2016-02-03 11:11:25
categories: ["编程开发"]
tags: ["Karma", "Nodejs", "测试"]
photos:
  - "https://images.pexels.com/photos/241558/pexels-photo-241558.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
执行 `karma start my.conf.js` 时出现错误，如下：

![](http://7xkexv.dl1.z0.glb.clouddn.com/20160202%2Fkarma.jpg)

解决办法：全局安装 `jasmine-core`, 命令`npm install -g jasmine-core`
