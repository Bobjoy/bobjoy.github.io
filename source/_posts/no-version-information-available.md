title: no version information available
date: 2015-07-27 14:55:20
categories: ["编程开发"]
tags: ["Nodejs"]
photos:
  - "https://images.pexels.com/photos/379944/pexels-photo-379944.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

使用nvm安装nodejs的时候报错了，错误信息如下：

```
vagrant@ubuntu-14:~$ nvm install 0.12.4
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libcrypto.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libcrypto.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libcrypto.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
curl: /home/vagrant/.linuxbrew/lib/libcrypto.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libcurl.so.4)
```

处理办法：`rm /home/vagrant/.linuxbrew/lib/libssl.so.1.0.0`, 同理删除libcrypto
