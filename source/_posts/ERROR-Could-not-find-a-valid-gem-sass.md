title: "ERROR:  Could not find a valid gem 'sass'"
date: 2016-03-01 11:20:30
categories: ["编程开发"]
tags: ["Ruby"]
---
使用gem安装sass时出错，提示找不到该sass，如下

```
C:\>gem install sass
ERROR:  Could not find a valid gem 'sass' (>= 0), here is why:
          Unable to download data from http://ruby.taobao.org/ - bad response Not Found 404 (http://ruby.taobao.org/specs.4.8.gz)
```

打开错误中的链接，确实找不到`specs.4.8.gz`文件

![](http://7xkexv.dl1.z0.glb.clouddn.com/20160301/rubytaobao.jpg)

将`http`协议改成`https`后，提示下载，说明地址正确，于是修改`HOME/.gemrc`，将ruby镜像修改为`https://ruby.taobao.org/`