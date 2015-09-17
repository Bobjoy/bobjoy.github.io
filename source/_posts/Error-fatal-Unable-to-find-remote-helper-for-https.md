title: "Error: fatal: Unable to find remote helper for 'https'"
date: 2015-09-17 09:21:04
categories:
tags: ["git", "hexo"]
---

执行命令`hexo d -g`发布文章时，报错：

```
On branch master
nothing to commit, working directory clean
fatal: Unable to find remote helper for 'https'
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: fatal: Unable to find remote helper for 'https'

    at ChildProcess.<anonymous> (E:\BFL\workspaces\blog\node_modules\hexo-deployer-git\node_modules\hexo-util\lib\spawn.js:42:17)
    at emitTwo (events.js:87:13)
    at ChildProcess.emit (events.js:172:7)
    at maybeClose (internal/child_process.js:817:16)
    at Process.ChildProcess._handle.onexit (internal/child_process.js:211:5)

```

解决办法：将原来环境变量PATH中配置的git安装目录`<GIT_INSTALL_DIR>`或者：`<GIT_INSTALL_DIR>\bin`，修改为`<GIT_INSTALL_DIR>\cmd`