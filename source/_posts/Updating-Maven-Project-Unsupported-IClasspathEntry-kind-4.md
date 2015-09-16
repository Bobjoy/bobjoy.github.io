title: 'Updating Maven Project, Unsupported IClasspathEntry kind=4'
date: 2015-09-16 17:52:23
categories:
tags: ["Maven"]
---
1. Eclipse项目上鼠标右键，选择Maven，禁用'Maven Nature'
    ![](http://7xkexv.dl1.z0.glb.clouddn.com/15-9-16/53303238.jpg)

2. 在项目目录中，cmd窗口运行`mvn eclipse:clean`命令
3. Eclipse项目，启用“Maven Nature”，右键选择'Configure'-> 'Convert to Maven Project'
    ![](http://7xkexv.dl1.z0.glb.clouddn.com/15-9-16/59722437.jpg)

