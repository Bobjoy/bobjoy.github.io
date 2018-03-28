title: SSH公钥中保存多个git账号
date: 2017-08-15 17:29:27
categories: ['编程开发']
tags: ['Git']
photos:
	- "https://images.pexels.com/photos/370013/pexels-photo-370013.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
## 问题描述

之前生成了GitHub的ssh公钥，可以免登陆提交代码，后来在oschina上也需要生成ssh公钥，发现GitHub的公钥就无法使用了，需要重新生成，但是又会将oschina的公钥覆盖掉。


## 解决办法

1. 创建不同的ssh公钥，修改默认文件路径

	```
	➜  ~ ssh-keygen -t rsa -C "your_email@youremail.com"
	Generating public/private rsa key pair.
	Enter file in which to save the key (/Users/xxx/.ssh/id_rsa): /Users/xxx/.ssh/id_rsa_oschina
	Enter passphrase (empty for no passphrase):
	Enter same passphrase again:
	Your identification has been saved in /Users/xxx/.ssh/id_rsa_oschina.
	Your public key has been saved in /Users/xxx/.ssh/id_rsa_oschina.pub.
	The key fingerprint is:
	SHA256:xVDjp+8X5x6YWx9gaxSpXo3Oj+ra0usZ9IwPtzYv8mk your_email@youremail.com
	The key's randomart image is:
	\+---[RSA 2048]----+
	|        ..o      |
	|         + . .   |
	|          + +    |
	|         . * .   |
	|        S = =    |
	|       . X =.=.  |
	|       .+ X X+o  |
	|      ..o*EX .oo |
	|      .=XXX++oo  |
	\+----[SHA256]-----+
	```

2. 添加生成的公钥

	```
	$ ssh-add ~/.ssh/id_rsa_oschina
	```

	添加之前可以删除缓存的公钥

	```
	$ ssh-add -D
	```

	添加之后查看添加的公钥

	```
	$ ssh-add -l
	```

3. 将对应的ssh公钥添加到git账号上去

	```
	➜  cat ~/.ssh/id_rsa_oschina | pbcopy
	```

4. 验证

	```
	➜  .ssh ssh -T git@git.oschina.net
	Welcome to Git@OSC, xxx!
	```


## 参考

https://gist.github.com/Bobjoy/57d520585565e8afdc61495f7e71c3e6
