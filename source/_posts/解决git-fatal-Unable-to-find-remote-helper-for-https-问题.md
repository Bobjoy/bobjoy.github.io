title: "解决git fatal: Unable to find remote helper for 'https'问题"
date: 2016-07-29 09:49:29
categories: ["编程开发"]
tags: ["Git"]
---
登陆到远程linux服务器上，使用git, clone的时候报“fatal: Unable to find remote helper for 'https'”错，没管，绕过，使用git clone git://....协议download下来项目。


但是到提交完要push回服务器的时候，必须得用https，搜了一下问题，是系统中没有curl，都是要装curl的，比如：

```
$ yum install curl-devel
```

或者apt-get等

 

但是问题来了，远程服务器上没有sudo到root的权限怎么办？

得自己安装curl，从http://curl.haxx.se/download.html下载到最新的curl包：

```
curl-7.41.0.tar.gz
```

解压，然后make并安装：

```
$ ./configure --prefix=/home/{username}/curl/

$ make

$ make install
```

安装好后，再尝试`git push`，还是报一样的错。

想到应该需要重新编译并安装git，执行：

```
./configure --prefix=/usr/local/git/ --with-curl=/usr/local/curl/
```

注意这里一定要使用`--with-curl`参数，指定到上面安装的curl目录，git只有与curl库做link之后，才能使用https功能。

再次`make & make install`

`git push`成功。

本次解决问题的经验教训：

实际上是重新编译时先使用`./configure --prefix=/usr/local/git/`未果后才思考的，执行`./configure --prefix=/usr/local/git/ &> config.log`，把log重定向到这个文件里打开，搜curl，发现curl的状态是no，表明这个configure没有找到curl，那么自然后面在make的时候也就无法完成link，然后`./configure -h`，看到`--with-curl`参数，想起需要指定，才搞定问题。


> 参考链接：http://stackoverflow.com/questions/8329485/git-clone-fatal-unable-to-find-remote-helper-for-https