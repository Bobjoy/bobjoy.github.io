title: Git学习笔记(4)-导出新修改的文件
date: 2018-02-27 09:52:14
categories:
tags:
photos:
  - "https://images.pexels.com/photos/388830/pexels-photo-388830.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

在 `bash` 窗口中执行以下命令

```
git archive -o update.zip HEAD $(git diff --name-only HEAD)
```
