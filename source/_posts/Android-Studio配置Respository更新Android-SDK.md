title: Android Studio配置Respository更新Android SDK
date: 2015-10-31 15:53:36
categories:
tags: ["Android"]
---

1. 首先关闭 Android Studio 启动SDK 版本检测

    Android Studio 安装后启动后一直停止在 Checking for updated SDK components，定位到 Android studio 安装目录的bin子目录，找到 idea.properties 文件。在 idea.properties 文件的最后增加一行代码：
    
    ```
    disable.android.first.run=true
    ```
    
    这行的作用就是让Android studio 在启动过程不进行SDK的版本检测。再次启动 Android studio，就可以进入开发界面了。
    
2. 打开 Android Studio 配置界面

    ![](http://7xkexv.dl1.z0.glb.clouddn.com/vetech/android-studio-repository.jpeg)

    添加 东软信息学院开源镜像 Repository
    
    ```
    http://mirrors.neusoft.edu.cn/android/repository/addon.xml
    ```

3. 更新 SDK Tools

    ![](http://7xkexv.dl1.z0.glb.clouddn.com/vetech/android-studio-update-sdk.jpeg)
    
    选中需要更新的项，点击右下角的 Apply