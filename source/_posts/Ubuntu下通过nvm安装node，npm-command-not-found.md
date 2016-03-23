title: Ubuntu下通过nvm安装node，npm command not found
date: 2015-11-05 10:01:56
categories: ["编程开发"]
tags: ["Npm", "Nodejs"]
---
在 Ubuntu 下使用 NVM 管理 node 版本，执行 npm 命令的时候，提示找不到命令，但是通过 where 查找 npm 命令的时候，是可以找到的，同时提示`npm：aliased to sudo npm`，如下图：

![](http://7xkexv.dl1.z0.glb.clouddn.com/vetech/nvm-npm-not-found.jpeg)

根据这个思路查找，找到了解决办法：为当前账户添加node_modules目录读写权限即可。
```
sudo chown -R $(whoami) ~/.npm
```