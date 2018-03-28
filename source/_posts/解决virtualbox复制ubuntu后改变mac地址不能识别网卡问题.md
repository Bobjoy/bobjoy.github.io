title: 解决virtualbox复制ubuntu后改变mac地址不能识别网卡问题
date: 2016-03-26 16:15:50
categories: ["Linux学习"]
tags: ["Linux"]
photos:
  - "https://images.pexels.com/photos/590701/pexels-photo-590701.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
在vbox里面安装了一个ubuntu server 12.04，利用自带的复制功能，完成
3台虚拟服务器的搭建。为了更好的模拟局域网环境，为了保证mac不一样，
所以刷新mac地址，登陆时ifconfig发现eth0不翼而飞，自然也不能连通网络。

最后发现是`/etc/udev/rules.d/70-persistent-net.rules`文件保存了原始虚
拟机网卡的mac地址，这时候利用vbox刷新mac地址，自然匹配不了，ubuntu就
识别不出网卡。

解决 办法是删除这个文件，然后重启下虚拟机，就可以用了。
