title: Windows7升级git到2.5版本后，hexo无法发布文章
date: 2015-09-17 09:40:39
categories:
tags: ["Git", "Hexo"]
---

Windows7，系统升级git最新版后

```
> git --version
> git version 2.5.2.windows.2
```

`hexo d -g`无法发布文章，出现如下错误：
```
On branch master
nothing to commit, working directory clean
bash: /dev/tty: No such device or address
error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': Invalid argument
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: bash: /dev/tty: No such device or address
error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': Invalid argument

    at ChildProcess.<anonymous> (E:\BFL\workspaces\blog\node_modules\hexo-deployer-git\node_modules\hexo-util\lib\spawn.js:42:17)
    at emitTwo (events.js:87:13)
    at ChildProcess.emit (events.js:172:7)
    at maybeClose (internal/child_process.js:817:16)
    at Socket.<anonymous> (internal/child_process.js:319:11)
    at emitOne (events.js:77:13)
    at Socket.emit (events.js:169:7)
    at Pipe._onclose (net.js:469:12)
```

后来重新安装git老版本后，问题才得以解决

```
git --version
git version 1.9.5.msysgit.0
```