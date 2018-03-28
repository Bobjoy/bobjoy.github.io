title: Eclipse远程调试Tomcat配置
date: 2016-05-05 12:25:17
categories: ["Eclipse", "Java"]
tags: ["Java"]
photos:
  - "https://images.pexels.com/photos/211707/pexels-photo-211707.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
当项目在服务器上单独部署的时候没有，因为服务器上不可能给你装IDE的工具。但是项目在本地运行很好，就是部署到服务器上的时候就出现一堆的错误，想想又没有IDE，没办法在服务器的本地进行调试。这时候就用到了Tomcat远程调试 JVM的JPDA框架。而Tomcat默认是不启用JPDA的，需要我们手动开启。

Eclpse远程调试Tomcat的配置步骤：

### 第一步、配置tomcat

#### 一、在windows系统中：

打开%CATALINE_HOME%/bin下的文件catalina.bat，加入下面这行：

```bash
set CATALINA_OPTS=-server -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
```

#### 二、在非windows系统中：

还需要把`%CATALINE_HOME%/bin/startup.sh`中的最后一行`exec "$PRGDIR"/"$EXECUTABLE" start "$@"`中的`start`改成`jpda start`。由于默认的端口是8000，所以如果8000端口已有他用的话，还需在catalina.sh文件中设 置：`JPDA_ADDRESS=8000`。

输入命令`startup.sh`或者`catalina.sh jpda start`就可启动tomcat。

在linux下出现错误时

```
ERROR: Cannot load this JVM TI agent twice, check your java command line for duplicate jdwp options.
```
<!-- more -->
将`-Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n`去掉。

### 三、启动后效果

![](http://7xkexv.dl1.z0.glb.clouddn.com/2016050501/remote-tomcat.png)

### 第二步、配置Eclpse

在Eclipse中选择Run Debug，在弹出对话框中右击Remote Java Application新建一个远程调试项，如下所示：

![](http://7xkexv.dl1.z0.glb.clouddn.com/2016050502/eclipse-remote-tomcat.png)

在 “Name”输入框中输入远程调试的名称，在“Project”中选择要调试的项目，在“Host”中输入需要远程调试项目的IP，也就是tomcat所在的IP，在“Port”中输入设置的端口号，比如上面设置的8000，然后钩选“Allow termination of remote VM”，点击“Apply”即可。

设置完后就可以开始调试了，大概分一下几步：

1. 启动tomcat（远程），如在控制台输出`Listening for transport dt_socket at address: 8000`，即说明在tomcat中设置成功；
2. 在本机设置断点;
3. 进入上图界面，选择要调试的项，点击“Debug”即可进行远程调试；
4. 访问你的测试页面即可看到久违的调试界面。
5.
但每次做上述操作非常烦，不如写个批处理，如取名为Tomcat debug.bat，在这个文件中加入下面几行：

```bash
cd %CATALINE_HOME%/bin
set JPDA_ADDRESS=8000
set JPDA_TRANSPORT=dt_socket
set CATALINA_OPTS=-server -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
startup
```

将此脚本保存到tomcat/bin目录下，然后发个快捷方式在桌面

这样需要远程调试时，运行debug.bat即可；不需要远程调试时，还是运行startup.bat文件
