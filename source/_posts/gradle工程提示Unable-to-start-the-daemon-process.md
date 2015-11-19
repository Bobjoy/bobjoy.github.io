title: gradle工程提示Unable to start the daemon process
date: 2015-11-19 16:35:00
categories:
tags: ["Gradle"]
---

Eclipse中使用Gradle 管理项目依赖时，提示错误，如下
```
Unable to start the daemon process.
This problem might be caused by incorrect configuration of the daemon.
For example, an unrecognized jvm option is used.
Please refer to the user guide chapter on the daemon at http://gradle.org/docs/2.4/userguide/gradle_daemon.html
Please read the following process output to find out more:
-----------------------
Unrecognized VM option 'MaxPermSize=256m'
Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit.

Could not fetch model of type 'EclipseProject' using Gradle installation '/Users/bao/Desktop/BFL/programs/gradle/gradle-2.4'.
```

解决办法如下：

在操作系统当前用户的.gradle文件夹下：$HOME/.gradle 设置gradle.properties，若无就新增, 并在文件中添加如下配置信息：
```
org.gradle.daemon=true
org.gradle.jvmargs=-Xmx512m
```