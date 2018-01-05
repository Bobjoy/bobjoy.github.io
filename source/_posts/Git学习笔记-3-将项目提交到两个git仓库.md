title: Git学习笔记-3-将项目提交到两个git仓库
date: 2018-01-04 15:06:50
categories: ["编程开发"]
tags: ["Git"]
---

## 方案一: git remote add

* 查看远程主机

  ```
  $ git remote -v
  origin    https://github.com/username/repository.git (fetch)
  origin    https://github.com/username/repository.git (push)
  ```

* 添加远程主机

  ```
  $ git remote add oschina https://git.oschina.net/username/repository.git
  ```

* 查看远程主机

  ```
  $ git remote -v
  origin    https://github.com/username/repository.git (fetch)
  origin    https://github.com/username/repository.git (push)
  oschina    https://git.oschina.net/username/repository.git (fetch)
  oschina    https://git.oschina.net/username/repository.git (push)
  ```

* 推送到远程主机

  ```
  $ git add .
  $ git commit -m 'test'
  $ git push -u origin master
  $ git push -u oschina master
  ```


## 方案二: git remote set-url

* 查看远程主机

  ```
  $ git remote -v
  origin    https://github.com/username/repository.git (fetch)
  origin    https://github.com/username/repository.git (push)
  ```

* 使用 `git remote set-url` 命令

  ```
  $ git remote set-url --add origin https://git.oschina.net/username/repository.git
  ```

* 查看远程主机

  ```
  $ git remote -v
  origin    https://github.com/username/repository.git (fetch)
  origin    https://github.com/username/repository.git (push)
  origin    https://git.oschina.net/username/repository.git (push)
  ```


> 参考 http://feitianbenyue.iteye.com/blog/2376791