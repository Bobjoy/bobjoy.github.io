title: 'vagrant reload命令报错:UndefinedConversionError'
date: 2015-07-28 09:39:44
categories: ["Linux学习"]
tags: ["vagrant", "Ruby"]
photos:
	- "https://images.pexels.com/photos/131699/pexels-photo-131699.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
修改了Vagrantfile文件后，运行`vagrant reload`命令，控制台直接报错了，错误如下

```
/opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:28:in `encode': "\xE4" from ASCII-8BIT to UTF-8 (Encoding::UndefinedConversionError)
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:28:in `block in initialize'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:28:in `each'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:28:in `initialize'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:22:in `new'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb:22:in `execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/plugins/providers/virtualbox/driver/base.rb:404:in `block in raw'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/busy.rb:19:in `busy'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/plugins/providers/virtualbox/driver/base.rb:403:in `raw'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/plugins/providers/virtualbox/driver/base.rb:342:in `block in execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/retryable.rb:17:in `retryable'
	from /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/plugins/providers/virtualbox/driver/base.rb:337:in `execute'
	......
```

回头仔细检查了一下Vagrantfile文件，只是修改了一下网络为public_network和IP，并没有什么问题，后来想了一下，该box是我重Windows上打包，然后在导入Mac系统中的，vagrant的源码使用Ruby实现的，Ruby 转码的方法：encode 有转码兼容，GBK转码为UTF-8不兼容，所以报错

解决方法：
思路：将参数用 force_encoding方法 强制转换成GBK编码即可
方法：找到报错的目录/opt/vagrant/embedded/gems/gems/vagrant-1.7.2/lib/vagrant/util/subprocess.rb文件找到line 26,将代码
![](http://7xkexv.dl1.z0.glb.clouddn.com/15-7-28/19499244.jpg)
修改为：
![](http://7xkexv.dl1.z0.glb.clouddn.com/15-7-28/10956742.jpg)
然后vagrant reload 没有报错，重启成功，代码同步成功。这是vagrant的一个bug。
