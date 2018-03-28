title: "CocoaPod 出现 Unable to satisfy the following requirements:required by 'Podfile'"
date: 2015-10-22 13:16:05
categories: ["移动开发"]
tags: ["iOS"]
photos:
  - "https://images.pexels.com/photos/12875/pexels-photo-12875.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
Q：通过 pod 更新iOS 第三方库时报错，错误如下：

```
$ pod update --verbose --no-repo-update

......

Resolving dependencies of `Podfile`
[!] Unable to satisfy the following requirements:

- `AFNetworking (~> 2.6.0)` required by `Podfile`
```

A：通过网络搜索，找到解决办法如下：

1. 删除本地缓存`sudo rm -fr ~/.cocoapods/repos/master`
2. 然后运行`pod setup`

注：如果出现下面错误

```
git clone error: RPC failed; result=56, HTTP code = 200
```

错误解决

```
git config --global http.postBuffer 524288000（尽量大）
```
