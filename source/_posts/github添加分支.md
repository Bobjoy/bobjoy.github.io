title: github添加分支
date: 2015-08-26 08:05:56
tags: ["git"]
---
使用git在本地创建/删除一个分支的过程

```
$ git init            				//初始化 
$ touch README
$ git add README        			//更新README文件
$ git commit -m 'first commit' 		//提交更新，并注释信息“first commit”
$ git remote add origin git@github.com:<用户名>/<项目名>.git     //连接远程github项目
$ git branch <分支名称>			//在本地新建一个分支
$ git checkout <分支名称>		//切换到你的新分支
$ git push origin <分支名称>		//将新分支发布在github上
$ git branch -d <分支名称>		//在本地删除一个分支
$ git push origin :<分支名称>  		//在github远程端删除一个分支 (分支名前的冒号代表删除)
```