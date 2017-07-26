title: Java读取INI文件时返回空
date: 2017-07-26 15:48:51
categories: ['Java']
tags: ['Java', 'INI']
---
## 问题描述

Java 读取 INI配置 文件时，返回内容为空，也没有报错，配置内容如下

```ini
[base_auth]
/static/**  = anon
/u/**       = anon
/open/**    = anon
/user/**    = kickout,simple,login
```

## 解决方法

去除配置文件中每一行 '=' 号两边的空格