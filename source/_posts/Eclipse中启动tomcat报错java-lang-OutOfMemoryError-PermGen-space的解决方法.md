title: 'Eclipse中启动tomcat报错java.lang.OutOfMemoryError: PermGen space的解决方法'
date: 2016-01-20 14:33:49
categories: ["编程开发"]
tags: ["Java", "Eclipse"]
photos:
  - "https://images.pexels.com/photos/547557/pexels-photo-547557.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
>
原文地址：http://outofmemory.cn/java/OutOfMemoryError/outofmemoryerror-permgen-space-in-tomcat-with-eclipse

有的项目引用了太多的jar包，或者反射生成了太多的类，异或有太多的常量池，就有可能会报java.lang.OutOfMemoryError: PermGen space的错误， 我们知道可以通过jvm参数 -XX:MaxPermSize=256m来配置这部分堆内存的大小。

在eclipse中如何配置tomcat的内存大小呢？

首先需要双击tomcat server，如下图所示：

![](http://outofmemory.cn/j/java/OutOfMemoryError/outofmemoryerror-permgen-space-in-tomcat-with-eclipse/imgs/eclipse-tomcat.png)

双击上图后会出现，tomcat配置的界面：

![](http://outofmemory.cn/j/java/OutOfMemoryError/outofmemoryerror-permgen-space-in-tomcat-with-eclipse/imgs/tomcat-launch-configuration.png)

然后再点击上图的，红色矩形框的链接，会弹出tomcat参数配置的节面，要选择Arguments参数框：

![](http://outofmemory.cn/j/java/OutOfMemoryError/outofmemoryerror-permgen-space-in-tomcat-with-eclipse/imgs/tomcat-argument-permgen.png)

如上图在VM arguments文本框内设置 -XX:MaxPermSize=256m的值即可, 当然此处还可以添加其他jvm参数，比如最大内存，最小内存等。
