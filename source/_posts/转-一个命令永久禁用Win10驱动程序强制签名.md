title: '[转]一个命令永久禁用Win10驱动程序强制签名'
date: 2017-07-23 17:43:39
categories:
tags:
photos:
  - "https://images.pexels.com/photos/229014/pexels-photo-229014.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
> 原文地址：https://www.ithome.com/html/win10/196402.htm

在Win10中，未经签名的驱动程序不能使用，这会导致部分硬件出现问题，此时就需要手动关闭Windows10的默认驱动验证。好在这个永久关闭验证的方法很简单，只需一个命令就可以搞定。

![](https://img.ithome.com/newsuploadfiles/2015/12/20151223_124038_710.png)

▲要关闭强制验证只需执行第一个命令

步骤如下：

1. 在开始按钮点击右键，选择“命令提示符（管理员）”

2. 执行以下命令（复制后，在命令提示符中单击鼠标右键即可完成粘贴，然后按回车键执行）：

```shell
bcdedit.exe /set nointegritychecks on
```

3. 命令瞬间执行完毕，若想恢复默认验证，执行如下命令即可：

```
bcdedit.exe /set nointegritychecks off
```

如果你有未签名的硬件驱动需要使用，不妨尝试运行一下第一个命令，也许由此引发的问题就可以暂时解决。不过微软的驱动强制签名政策也是出于安全考虑，如果你没遇到类似问题，还是别关闭签名验证为好。
