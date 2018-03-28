title: "解决在Ubuntu14.04中 'Cannot Add PPA' 的错误"
date: 2016-03-27 17:50:37
categories: ["Linux学习"]
tags: ["Linux"]
photos:
  - "https://images.pexels.com/photos/775998/pexels-photo-775998.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
![](http://itsfoss.com/wp-content/uploads/2014/05/PPA_Error_Ubuntu.jpeg)

```
➜  ~  > sudo add-apt-repository ppa:openjdk-r/ppa
Cannot add PPA: 'ppa:openjdk-r/ppa'.
Please check that the PPA name or format is correct.
```

首先检查DNS设置，查看`/etc/resolv.conf`，如未配置DNS，则配置DNS，如果还是无效，则按以下思路来解决。

如果你在Ubuntu中添加PPA出现显示的错误时，不要着急。这是一个在添加PPA时出现的一个普遍的错误，也很容易解决。

解决在Ubuntu中无法添加PPA的错误

主要有两个原因会出现这种错误。要么是你系统中的CA证书损坏，或者是你的网络设置了代理。

我们首先重装CA证书：

```
sudo apt-get install --reinstall ca-certificates
```

如果上面的命令无效的话，可能是设置了代理。可以通过E选项绕过系统代理，如下：

```
sudo -E add-apt-repository ppa:openjdk-r/ppa
```
