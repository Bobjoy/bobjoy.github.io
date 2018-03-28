title: 'git提示warning: LF will be replaced by CRLF'
date: 2015-09-17 16:48:50
categories:
tags: ["Git"]
photos:
  - "https://images.pexels.com/photos/15384/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

**问题描述：**

执行`git add .`指令，命令行出现如下错误：

```
warning: LF will be replaced by CRLF in nodejs-in-action/yeoman/mytodo/.editorconfig.
The file will have its original line endings in your working directory.
```

**原因分析：**

CRLF（Carriage-Return Line-Feed）回车换行就是回车(CR, ASCII 13, \r) 换行(LF, ASCII 10, \n)。

这两个ACSII字符不会在屏幕有任何输出，但在Windows中广泛使用来标识一行的结束。而在Linux/UNIX系统中只有换行符。
也就是说在windows中的换行符为 CRLF， 而在linux下的换行符为：LF

使用git提交更改时，文件中的换行符为LF， 当执行`git add .`时，系统提示：LF 将被转换成 CRLF

**解决方法：**

```
$ git config --global core.autocrlf false
```

这样系统就不会去进行换行符的转换了,最后重新执行

```
$ git add .
```

系统即可正常运行！
