title: Failed to build gem native extension - cannot load such file -- mkmf(LoadError)
date: 2015-07-23 19:22:39
categories: ["编程开发"]
tags: ["Nodejs", "Ruby", "Rails"]
---
在Ubuntu Server上利用Gitlab搭建git服务器的时候，执行`sudo bundle install --deployment --without development test postgres aws`报一下错误

```
Don't run Bundler as root. Bundler can ask for sudo if it is needed, and installing your bundle as root will break
this application for all non-root users on this machine.
Fetching gem metadata from http://ruby.taobao.org/........
Fetching version metadata from http://ruby.taobao.org/..
Using rake 10.4.2
Using CFPropertyList 2.3.1
Installing RedCloth 4.2.9 with native extensions

Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.

        /usr/bin/ruby1.9.1 extconf.rb
/usr/lib/ruby/1.9.1/rubygems/custom_require.rb:36:in `require': cannot load such file -- mkmf (LoadError)
	from /usr/lib/ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
	from extconf.rb:1:in `<main>'


Gem files will remain installed in /home/git/gitlab/vendor/bundle/ruby/1.9.1/gems/RedCloth-4.2.9 for inspection.
Results logged to /home/git/gitlab/vendor/bundle/ruby/1.9.1/gems/RedCloth-4.2.9/ext/redcloth_scan/gem_make.out
An error occurred while installing RedCloth (4.2.9), and Bundler cannot continue.
Make sure that `gem install RedCloth -v '4.2.9'` succeeds before bundling.
```

最终baidu寻找到解决办法  
http://stackoverflow.com/questions/13767725/unable-to-install-gem-failed-to-build-gem-native-extension-cannot-load-such

```
There is similar questions:

`require': no such file to load -- mkmf (LoadError)
Failed to build gem native extension (mkmf (LoadError)) - Ubuntu 12.04
The solution is:

sudo apt-get install ruby-dev
Or, if that doesn't work, depending on your ruby version, run something like:

sudo apt-get install ruby1.9.1-dev
Should fix your problem.

Still not working? Try the following after installing ruby-dev:

sudo apt-get install make

```