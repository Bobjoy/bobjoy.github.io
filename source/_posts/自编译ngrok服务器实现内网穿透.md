title: 自编译ngrok服务器实现内网穿透
date: 2015-11-25 09:09:42
categories:
tags: ["Ngrok", "Linux"]
---

### 一. 首先安装GO环境

1. Linux 下安装

	- Centos下使用epel源安装：
	
    ```
    yum install golang
    ```
    - Centos/Linux下源码安装golang：
    
    ```	
    wget https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.4.1.linux-amd64.tar.gz
    mkdir $HOME/go
    echo 'export GOROOT=/usr/local/go' >> ~/.bashrc 
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc 
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc 
    source $HOME/.bashrc 
    ```
    - 安装go get工具：

    ```
    yum install mercurial git bzr subversion
    ```
<!--more-->
2. Windows 下安装：
    - 下载https://storage.googleapis.com/golang/go1.4.1.windows-386.zip
    - 设置环境变量：
    
    ```
    setx GOOS windows
    setx GOARCH 386
    setx GOROOT "D:\Program Files\go"
    setx GOBIN "%GOROOT%\bin"
    setx PATH %PATH%;D:\Program Files\go\bin"
    ```

### 二. 编译安装 NGROK

1. 下载 NGROK源码

    ```
    cd /usr/local/src/
    git clone https://github.com/inconshreveable/ngrok.git
    export GOPATH=/usr/local/src/ngrok/
    export NGROK_DOMAIN="haiyun.me"
    ```
2. 生成自签名SSL证书，ngrok为ssl加密连接：

	```
	cd ngrok
	openssl genrsa -out rootCA.key 2048
	openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
	openssl genrsa -out device.key 2048
	openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
	openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
	cp rootCA.pem assets/client/tls/ngrokroot.crt
	cp device.crt assets/server/tls/snakeoil.crt 
	cp device.key assets/server/tls/snakeoil.key
	GOOS=linux GOARCH=386
	make clean
	make release-server release-client
	```

	如果在安装yaml的时候不能下载，无反应：
	
	```
	go get gopkg.in/yaml.v1
	```
	
	原因git版本太低，需>= 1.7.9.5，通过RPMForge源安装最新版本git解决：
	
	```
	yum --enablerepo=rpmforge-extras install git
	```
	
### 三. 启动SERVER：

1. 启动 Server

	```
	bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":8000"
	```

2. 交叉编译windows客户端，最好安装最新版本Golang，使用yum安装的一直编译不通过。

	```
	cd /usr/local/go/src/
	GOOS=windows GOARCH=386 CGO_ENABLED=0 ./make.bash
	cd -
	GOOS=windows GOARCH=386 make release-server release-client
	```

3. 客户端配置：

	```
	server_addr: "haiyun.me:4443"
	trust_host_root_certs: false
	tunnels:
  		http:
    		subdomain: "example"
    		auth: "user:12345"
    		proto:
      			http: "80"
 
  		ssh:
    		remote_port: 2222
    		proto:
      			tcp: "22"
	```

4. 启动客户端：

	```
	bin/ngrok -config ngrok.conf start http ssh
	```

**注意所有domain要一致，不然会出现证书错误：**

```
Failed to read message: remote error: bad certificate
```

原文地址：http://www.haiyun.me/archives/1012.html