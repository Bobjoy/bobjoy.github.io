title: Git学习笔记(2)-拉取指定文件或目录
date: 2015-09-02 09:20:20
categories:
tags: ["git"]
---
拉取指定分支下的指定文件或目录

```
$ git init            				//初始化 
$ git remote add origin git@github.com:<用户名>/<项目名>.git     //连接远程github项目
$ git fetch origin/master <文件或目录> // origin/master对应分支
```