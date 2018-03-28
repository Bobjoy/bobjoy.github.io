title: JavaWeb文件下载知识整理
date: 2017-12-28 11:49:16
categories: ["编程开发"]
tags: ["Java"]
photos:
  - "https://images.pexels.com/photos/179908/pexels-photo-179908.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

## 中文文件名乱码

JAVA文件下载时乱码有两种情况：

1. 下载时中文文件名乱码

解决方法：

```java
String userAgent = request.getHeader("User-Agent");
String fileName = "中文文件名称";

// 针对IE或者以IE为内核的浏览器：
if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
	fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
} else {
	// 非IE浏览器的处理：
	fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
}
response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", fileName + ".xls"));
response.setContentType("application/vnd.ms-excel;charset=utf-8");
response.setCharacterEncoding("UTF-8");
```


2. 下载时因为路径中包含中文文件名乱码，提示找不到文件

解决方法：修改Tomcat配置文件 `${CATLINA_HOME}/conf/server.xml` ，如下内容

```xml
<Connector port="8080"
           protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           URIEncoding="UTF-8" />
```


## Content-Disposition的作用以及attachment、inline的区别

* `Content-Disposition` 是 MIME 协议的扩展，MIME 协议指示 MIME 用户代理如何显示附加的文件。当浏览器接收到头时，它会激活文件下载对话框，它的文件名框自动填充了头中指定的文件名。

* 服务端向客户端游览器发送文件时，如果是浏览器支持的文件类型，一般会默认使用浏览器打开，比如txt、jpg等，会直接在浏览器中显示，如果需要提示用户保存，就要利用 `Content-Disposition` 进行一下处理，关键在于一定要加上 `attachment` ：

```
response.setHeader("Content-Disposition", "attachment;filename=FileName.txt");
```

  备注：这样浏览器会提示保存还是打开，即使选择打开，也会使用相关联的程序比如记事本打开，而不是IE直接打开了。

* Java Web中下载文件时,我们一般设置 `Content-Disposition` 告诉浏览器下载文件的名称,是否在浏览器中内嵌显示.

* `Content-Disposition: inline;filename=foobar.pdf` 表示浏览器内嵌显示一个文件，`Content-Type` 值为 `application/octet-stream` 除外

* `Content-Disposition: attachment;filename=foobar.pdf` 表示会下载文件,如火狐浏览器中
