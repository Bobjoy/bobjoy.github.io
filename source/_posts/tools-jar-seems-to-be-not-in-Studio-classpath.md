title: "'tools.jar' seems to be not in Studio classpath"
date: 2015-10-31 14:44:06
categories:
tags: ["Android"]
---

Q: Mac 启动 Android Studio 时，无法启动，错误如下：

![](http://7xkexv.dl1.z0.glb.clouddn.com/vetech/android-studio-lunch-error.jpeg)

A: 将 `$JAVA_HOME/lib/tools` 拷贝到 `ANDROID_STUDIO_ROOT/lib/` 下, 可执行如下命令

`
sudo cp $JAVA_HOME/lib/tools.jar /Applications/Android\ Studio.app/Contents/lib
`

