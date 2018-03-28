title: Git学习笔记(2)-拉取指定文件或目录
date: 2015-09-02 09:20:20
categories:
tags: ["Git"]
photos:
  - "https://images.pexels.com/photos/704856/pexels-photo-704856.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
拉取指定分支下的指定文件或目录

```
$ git init
$ git remote add origin git@github.com:<用户名>/<项目名>.git
$ git fetch
$ git checkout <分支如origin/master> <目录或文件>
```
