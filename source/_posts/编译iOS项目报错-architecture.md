title: 编译iOS项目报错-architecture
date: 2015-07-16 09:33:57
tags: ["iOS", "Objective C"]
---
### 1.错误代码：missing required architecture x86_64 in file

#### 解决方法：

```
targets ->build setting 下的
architectures 设置为 standard architetures(armv7,armv7s)
vaild architectures 设置为armv7,armv7s
```

### 2.错误代码：No architectures to compile for (ONLY_ACTIVE_ARCH=YES, active arch=x86_64, VALID_ARCHS=armv7 armv7s)

#### 解决方法：

```
In Build Settings are:
Architectures: Starndard (armv7, armv7s)
Base SDK: Latest iOS (iOS 6.0)
Build Active Architecture Only: Debug Yes, Release No
Valid Architectures: armv7 armv7s
After I change Build Active Architecture Only = No, then the build was BUILD SUCCEEDED.
```

如图：Build Active Architecture Only  
![Build Active Architecture Only = No](http://7xkexv.dl1.z0.glb.clouddn.com/2015071602.png)
