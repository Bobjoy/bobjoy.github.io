title: 运行java，提示找不到或无法加载主类
date: 2015-08-10 11:45:32
categories: ["编程开发"]
tags: ["Java"]
toc: false
---
在`javac`编译java文件，成功编译，`java`运行class文件，一直提示找不到或无法加载主类，检查java文件，定义了标准的main方法，无赖一直无法运行，检查环境变量，发现添加了classpath环境变量，才想起是在测试时添加的，classpath的值为`E:\java`,解决办法，将classpath的值改为`.;E:\java`，或者删除classpath环境变量