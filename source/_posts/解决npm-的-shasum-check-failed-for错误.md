title: 解决npm 的 shasum check failed for错误
date: 2015-07-16 16:39:09
tags: ["Nodejs"]
---
使用npm安装一些包失败了的看过来（npm国内镜像介绍）  
镜像使用方法（三种办法任意一种都能解决问题，建议使用第三种，将配置写死，下次用的时候配置还在）:  

1.通过config命令

```
npm config set registry http://registry.cnpmjs.org
npm info underscore （如果上面配置正确这个命令会有字符串response）
```

2.命令行指定

```
npm --registry http://registry.cnpmjs.org info underscore
```

3.编辑 ~/.npmrc 加入下面内容

```
registry = http://registry.cnpmjs.org
```

[搜索镜像](http://cnpmjs.org)  
[建立或使用镜像](https://github.com/fenmgk2/cnpmjs.org)
