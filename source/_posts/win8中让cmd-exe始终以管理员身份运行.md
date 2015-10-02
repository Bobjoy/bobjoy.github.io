title: win8中让cmd.exe始终以管理员身份运行
date: 2015-09-17 08:57:43
categories:
tags: ["随笔"]
---

通过一下方法可以让cmd.exe(或者其他程序)以管理员身份来运行：

**方法一：**

1. Win+R -- regedit
2. 找到以下位置`HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`
3. 新建一个字符串值，命名为`C:\Windows\System32\cmd.exe`
4. 然后右键--修改 -- 数值数据写入“RUNASADMIN”，确定

**方法二：**
```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers]
"C:\\Windows\\System32\\cmd.exe"="RUNASADMIN"
```
打开记事本，复制粘贴入以上代码，另存为runas.reg，然后双击导入注册表即可。

