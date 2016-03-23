title: hexo发布内容时提示No such deive or address错误
date: 2016-03-23 13:21:50
categories:
tags: ["git", "hexo"]
---
利用hexo发布文章时，控制台出错，如下：

```
INFO  Deploying: git
INFO  Clearing .deploy folder...
INFO  Copying files from public folder...
On branch master
nothing to commit, working directory clean
bash: /dev/tty: No such device or address
error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': No error
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: bash: /dev/tty: No such device or address
error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': No error

    at ChildProcess.<anonymous> (E:\BFL\blog\node_modules\hexo-deployer-git\node_modules\hexo-util\lib\spawn.js:42:17)
    at emitTwo (events.js:87:13)
    at ChildProcess.emit (events.js:172:7)
    at maybeClose (internal/child_process.js:821:16)
    at Process.ChildProcess._handle.onexit (internal/child_process.js:211:5)

```

git版本

```
$ git --version
git version 2.5.0.windows.1
```

网上找了各种办法,都无法解决，最终，只能又安装了git1.9.5版本的

```
E:\BFL\blog>git --version
git version 1.9.5.msysgit.0
```

使用该版本后，可以发布文章了