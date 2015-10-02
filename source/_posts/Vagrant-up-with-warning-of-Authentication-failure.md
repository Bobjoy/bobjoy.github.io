title: Vagrant up with warning of Authentication failure
date: 2015-10-01 21:49:15
categories:
tags:
---
当`vagrant up`启动虚拟机的时候，到最后一直提示如下:

```
......
default: Warning: Remote connection disconnect. Retrying...
default: Warning: Authentication failure. Retrying...
default: Warning: Authentication failure. Retrying...
```

最终找到解决办法，很简单，删除虚拟机的私有密钥即可，命令如下：

```
rm .vagrant/machines/core-01/virtualbox/private_key
```

> 参考地址：http://dockone.io/article/339
