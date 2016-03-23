title: 'SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed'
date: 2016-03-23 12:51:12
categories:
tags: ["Ruby"]
---
执行`gem install`命令时，报错如下：

```
OpenSSL::SSL::SSLError (SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed):
  app/controllers/users_controller.rb:37:in `update'
```

解决办法：

1. 下载证书：http://curl.haxx.se/ca/cacert.pem
2. 在windows添加环境变量：`SSL_CERT_FILE`, 值为`{证书路径}/cert.pem`

>
参考链接：http://stackoverflow.com/questions/4528101/ssl-connect-returned-1-errno-0-state-sslv3-read-server-certificate-b-certificat