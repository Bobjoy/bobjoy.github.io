title: SonarQube安装Windows服务后，无法启动服务
date: 2016-02-19 14:22:56
categories:
tags: ["Sonar"]
---
手动安装SonarQube的windows服务后，启动报错，如下：

```
--> Wrapper Started as Service
Launching a JVM...
Unable to execute Java command.  系统找不到指定的文件。 (0x2)
...
```

解决办法：修改 `SONAR_安装目录\conf\wrapper.conf`文件，如下

```
wrapper.java.command=java
# 修改为
wrapper.java.command=JAVA_安装目录\bin\java.exe

```

再次启动，仍然无法启动，错误如下：

```
--> Wrapper Started as Service
Launching a JVM...
Wrapper (Version 3.2.3) http://wrapper.tanukisoftware.org
  Copyright 1999-2006 Tanuki Software, Inc.  All Rights Reserved.


WrapperSimpleApp: Encountered an error running main: java.lang.IllegalStateException: Temp directory is not writable: C:\Windows\system32\config\systemprofile\AppData\Local\Temp\
java.lang.IllegalStateException: Temp directory is not writable: C:\Windows\system32\config\systemprofile\AppData\Local\Temp\
	at org.sonar.process.MinimumViableSystem.checkWritableDir(MinimumViableSystem.java:60)
	at org.sonar.process.MinimumViableSystem.checkWritableTempDir(MinimumViableSystem.java:52)
	at org.sonar.process.MinimumViableSystem.check(MinimumViableSystem.java:45)
	at org.sonar.application.App.main(App.java:112)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:606)
	at org.tanukisoftware.wrapper.WrapperSimpleApp.run(WrapperSimpleApp.java:240)
	at java.lang.Thread.run(Thread.java:745)
Caused by: java.io.IOException: 系统找不到指定的路径。
	at java.io.WinNTFileSystem.createFileExclusively(Native Method)
	at java.io.File.createNewFile(File.java:1006)
	at java.io.File.createTempFile(File.java:1989)
	at org.sonar.process.MinimumViableSystem.checkWritableDir(MinimumViableSystem.java:57)
	... 9 more
<-- Wrapper Stopped
```

解决办法：同样修改 wrapper.conf 文件，如下

```
wrapper.java.additional.1=-Djava.awt.headless=true
# 修改为
wrapper.java.additional.1=-Djava.awt.headless=true -Djava.io.tmpdir=../../temp
```
