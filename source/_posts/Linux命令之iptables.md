title: Linux命令之iptables
date: 2016-06-21 16:47:49
categories: ["Linux"]
tags: ["Linux"]
photos:
  - "https://images.pexels.com/photos/46274/pexels-photo-46274.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
### 一、iptable介绍

Netfilter包含有三种表，三种表下共包含有五种链，链下面包含各种规则。即表包含若干链，链包含若干规则。

#### （一） 三种表为：filter、nat、mangle


1. filter:处理与本机有关的数据包，是默认表，包含有三种链：input、output、forward；

2. nat表：与本机无关。主要处理源与目的地址IP和端口的转换。有三种链：prerouting、postrouting、output；

3. mangle表：用于高级路由信息包，如包头内有更改（如tos改变包的服务类型，ttl包的生存时间，mark特殊标记）。有两种链：prerouting、output  （kernel  2.4.18后又加了两种链：input forward）这种表很少使用；


#### （二） 五种链

1. prerouting:进入netfilter后的数据包在进入路由判断前执行的规则。改变包。

2. Input：当经过路由判断后，要进入本机的数据包执行的规则。

3. output:由本机产生，需向外发的数据包执行的规则。

4. forward:经过路由判断后，目的地不是本机的数据包执行的规则。与nat 和 mangle表相关联很高，与本机没有关联。

5. postrouting:经过路由判断后，发送到网卡接口前。即数据包准备离开netfilter时执行的规则。
<!--more-->
![](http://7xkexv.dl1.z0.glb.clouddn.com/2016062101/iptables.png)

上图中，运行中的守护进程，是指本机。Input的包都会发到本机。本机处理后再经output 发出去。


#### （三）数据包进入netfilter后的经过图：

1. 数据包进入linux服务器入接口，接口把数据包发往netfilter，数据包就此进入netfilter；

2. 经prerouting处理，（如是否需要更改数据包的源IP地址等）；

3. 数据包到路由，路由通过路由表判断数据包的目的地。如果目的地是本机，就把数据包转给intput处理后进入本机。如果目的地不是本机，则把数据包转给forward处理；

4. 数据包通过forward处理后，再转给postrouting处理，（是否有目标地址需要改变等），处理后数据包就出了netfilter，到linux服务器出接口，就出了linux服务器；

5. 如果数据包进了本机后经过处理需要外发数据包，或本机自身有数据包需要外发，就把数据包发给output链进行处理后，转给postrouting处理后，出linux服务器。进入外面的花花世界；


#### （四）规则的执行顺序

- 当数据包进入netfilter，就会和里面的规则进行对比。规则是有顺序的。

- 先和规则1对比，如果和规则1相匹配，被规则1接受（accept），则数据将不再和后面的规则进行对比。如果不匹配，则按顺序和后面的规则进行对比，直到被接受。如果所有的规则都不匹配，则进行默认策略操作，以决定数据包的去向。所以规则的顺序很重要。


### 二、iptable语法及参数

```
iptables [-t table] command [chain] [match][-j target]
```

注释：iptables [-t 表名] -命令 [链接] [匹配] [-j 动作/目标]

#### （一） table(表)

1. filter表：默认用filter表执行所有的命令。只操作与本机有关的数据包。

2. nat表：主要用于NAT地址转换。只有数据流的第一个数据包被这个链匹配，后面的包会自动做相同的处理。
  * 分为:DNAT（目标地址转换）、SNAT（源地址转换）、MASQUERADE
    - (1) DNAT操作主要用在这样一种情况，你有一个合法的IP地址，要把对防火墙的访问 重定向到其他的机子上（比如DMZ）。也就是说，我们改变的是目的地址，以使包能重路由到某台主机。
    - (2) SNAT 改变包的源地址，这在极大程度上可以隐藏你的本地网络或者DMZ等。内网到外网的映射。
    - (3) MASQUERADE 的作用和SNAT完全一样，只是计算机的负荷稍微多一点。因为对每个匹配的包，MASQUERADE都要查找可用的IP地址，而不象SNAT用的IP地址是配置好的。当然，这也有好处，就是我们可以使用通过PPP、 PPPOE、SLIP等拨号得到的地址，这些地址可是由ISP的DHCP随机分配的。

3. mangle表：用来改变数据包的高级特性，一般不用。

#### （二） command(命令）详解

1. -A或者--append     //将一条或多条规则加到链尾

2. -D或者--delete     //从链中删除该规则

3. -R或者--replace   //从所选链中替换一条规则

4. -L或者--list       //显示链的所有规则

5. -I或者--inset     //根据给出的规则序号，在链中插入规则。按序号的顺序插入，如是 “1”就插入链首

6. -X或者--delete-chain  //用来删除用户自定义链中规则。必须保证链中的规则都不在使用时才能删除链。如没有指定链，将删除所有自定义链中的规则。

7. -F或者--flush        //清空所选链中的所有规则。如指定链名，则删除对应链的所有规则。如没有指定链名，则删除所有链的所有规则。

8. -N或者--new-chain      //用命令中所指定的名字创建一个新链。

9. -P或者--policy        //设置链的默认目标，即策略。 与链中任何规则都不匹配的信息包将强制使用此命令中指定的策略。

10. -Z或者--zero        //将指定链中的所有规则的包字节计数器清零。

#### (三） match 匹配

分为四大类：通用匹配、隐含匹配、显示匹配、针对非正常包的匹配

##### 1. 通用匹配

无论我们使用何种协议，装入何种扩展，通用匹配都可以使用。不需要前提条件

  * (1). -p(小写）或--protocol
    - 用来检查某些特定协议。协议有TCP\UDP\ICMP三种。可用逗号分开这三种协议的任何组合。也可用“！”号进行取反，表示除该协议外的剩下的协议。也可用all表示全部协议。默认是all，但只代表tcp\udp\icmp三种协议。

    ```
    $ iptables -A INPUT -p TCP,UDP
    $ iptables -A INPUT -p ! ICMP     //这两种表示的意思为一样的。
    ```

  * (2). -s 或 --source
    - 以Ip源地址匹配包。根据源地址范围确定是否允许或拒绝数据包通过过滤器。可使用 “！”符号。    默认是匹配所有ip地址。
    - 可是单个Ip地址，也可以指定一个网段。  如： 192.168.1.1/255.255.255.255  表示一个地址。  192.168.1.0/255.255.255.0  表示一个网段。

  * (3). -d  或 --destination
    - 用目的Ip地址来与它们匹配。与  source 的格式用法一样

  * (4). -i
    - 以包进入本地所使用的网络接口来匹配包。只能用INPUT \ FORWARD \PREROUTING 三个链中。用在其他任何链中都会出错。
    - 可使用“+”  “！”两种符号。
    - 只用一个“+"号，表示匹配所有的包，不考虑使用哪个接口。如： iptables -A INPUT  -i +  //表匹配所有的包。
    - 放在某类接口后面，表示所有此类接口相匹配。如：    iptables  -A INPUT -i eth+   //表示匹配所有ethernet 接口。

  * (5). -o
    - 以数据包出本地所使用的网络接口来匹配包。与-i一样的使用方法。
    - 只能用OUTPUT \ FORWARD \POSTROUTING 三个链中。用在其他任何链中都会出错。
    - 可使用“+”  “！”两种符号。

  * (6). -f  (或  --fragment )
    - 用来匹配一个被分片的包的第二片或以后的部分。因一个数据包被分成多片以后，只有第一片带有源或目标地址。后面的都不带 ，所以只能用这个来匹配。可防止碎片攻击。

##### 2. 隐含匹配

这种匹配是隐含的，自动的载入内核的。如我们使用 --protocol tcp  就可以自动匹配TCP包相关的特点。

分三种不同协议的隐含匹配:tcp、udp、icmp

2.1 tcp match

tcp match 只能隐含匹配TCP包或流的细节。但必须有  -p tcp 作为前提条件。

（2.1.1） TCP --sport

基于tcp包的源端口匹配包  ，不指定此项则表示所有端口。

```
iptables -A INPUT -p  TCP  --sport   22:80    //TCP源端口号22到80之间的所有端口。
iptables -A INPUT -p  TCP  --sport   22:      //TCP源端口号22到65535之间的所有端口。
```

（2.1.2） TCP --dport

基于tcp包的目的端口来匹配包。   与--sport端口用法一样。

（2.1.3） TCP --flags

匹配指定的TCP标记。

```
iptables  -p  TCP --tcp-flags  SYN,FIN,ACK   SYN
```

2.2   UDP match

（2.1.1）  UDP --sport

基于UDP包的源端口匹配包  ，不指定此项则表示所有端口。

（2.1.1）  UDP --dport

基于UDP包的目的端口匹配包  ，不指定此项则表示所有端口。

2.3 icmp match

icmp --icmp-type

根据ICMP类型包匹配。类型 的指定可以使用十进制数或相关的名字，不同的类型，有不同的ICMP数值表示。也可以用“！”取反。

例: `iptables  -A INPUT  -p icmp-imcp-type 8`

##### 3、显示匹配

显示匹配必须用  -m装 载。

（1）limit match

必须用 -m limit 明确指出。  可以对指定的规则的匹配次数加以限制。即，当某条规则匹配到一定次数后，就不再匹配。也就是限制可匹配包的数量。这样可以防止DOS攻击。

限制方法： 设定对某条规则 的匹配最大次数。设一个限定值 。 当到达限定值以后，就停止匹配。但有个规定，在超过限制次数后，仍会每隔一段时间再增加一次匹配次数。但增加的空闲匹配数最大数量不超过最大限制次数。

--limit rate

  最大平均匹配速率：可赋的值有'/second', '/minute', '/hour', or '/day'这样的单位，默认是3/hour。

--limit-burst number

  待匹配包初始个数的最大值:若前面指定的极限还没达到这个数值,则概数字加1.默认值为5

iptables -A INPUT -m limit --limt 3/hour    //设置最大平均匹配速率。也就是单位时间内，可匹配的数据包个数。   --limt 是指定隔多 长时间发一次通行证。

iptables -A INPUT  -m limit --limit-burst 5  //设定刚开始发放5个通行证，也最多只可匹配5个数据包。

（2） mac match

只能匹配MAC源地址。基于包的MAC源地址匹配包

iptables -A  INPUT -m mac  --mac-source   00:00:eb:1c:24     //源地址匹配些MAC地址

（3） mark match

以数据包被 设置的MARK来匹配包。这个值由  MARK TARGET 来设置的。

（4） multiport match

这个模块匹配一组源端口或目标端口,最多可以指定15个端口。只能和-p tcp 或者 -p udp 连着使用。


多端口匹配扩展让我们能够在一条规则里指定不连续的多个端口。如果没有这个扩展，我们只能按端口来写规则了。这只是标准端口匹配的增强版。不能在一条规则里同时用标准端口匹配和多端口匹配。

三个选项：--source-port、--destination-port、--port

```
iptables  -A INPUT  -p TCP   -m  multiport  --source-port 22,28,115
iptables  -A INPUT  -p TCP   -m  multiport  --destination-port 22,28,115
iptables  -A INPUT  -p TCP   -m  multiport  --port 22,28,115
```

（5） state match

状态匹配扩展要有内核里的连接跟踪代码的协助。因为是从连接跟踪机制得到包的状态。这样不可以了解所处的状态。

（6） tos match

根据TOS字段匹配包，用来控制优先级。

（7） ttl match

根据IP头里的TTL字段来匹配包。

用来更改包的TTL，有些ISP根据TTL来判断是不是有多台机器共享连接上网。

```
iptables -t mangle -A PREROUTING -i eth0 -j TTL --ttl-set 64
iptables -t mangle -A PREROUTING -i eth0 -j TTL --ttl-dec 1
# 离开防火墙的时候实际上TTL已经-2了，因为防火墙本身要-1一次。
iptables -t mangle -A PREROUTING -i eth0 -j TTL --ttl-inc 1
# 离开防火墙的时候不增不减，tracert就不好用了，呵呵。
```

（8） owner match

基于包的生成者（即所有者或拥有者）的ID来匹配包。

owner 可以是启动进程的用户的ID，或用户所在的级的ID或进程的ID，或会话的ID。此只能用在OUTPUT 中。

此模块设为本地生成包匹配包创建者的不同特征。而且即使这样一些包（如ICMP ping应答）还可能没有所有者，因此永远不会匹配。

--uid-owner userid

  如果给出有效的user id，那么匹配它的进程产生的包。

--gid-owner groupid

  如果给出有效的group id，那么匹配它的进程产生的包。

--sid-owner seessionid

  根据给出的会话组匹配该进程产生的包。

#### （四） targets/jump

指由规则指定的操作，对与规则匹配的信息包执行什么动作。

1、accept

这个参数没有任何选项。指定 -j accept 即可。

一旦满足匹配不再去匹配表或链内定义的其他规则。但它还可能会匹配其他表和链内的规则。即在同一个表内匹配后就到上为止，不往下继续。

2、drop

-j drop   当信息包与规则完全匹配时，将丢弃该 包。不对它做处理。并且不向发送者返回任何信息。也不向路由器返回信息。

3、reject

与drop相同的工作方式，不同的是，丢弃包后，会发送错误信息给发送方。

```
iptables -A FORWARD -p TCP --dport 22 -j REJECT --reject-with icmp-net-unreachable
```

4、DNAT

用在prerouting链上。

做目的网络地址转换的。就是重写目的的IP地址。

如果一个包被匹配，那么和它属于同一个流的所有的包都会被自动转换。然后可以被路由到正确的主机和网络。

也就是如同防火墙的外部地址映射。把外部地址映射到内部地址上。

```
iptables -t nat   -A PREROUTING   -d 218.104.235.238 -p TCP  --dport 110,125    -j DNAT --to-destination  192.168.9.1
//把所有访问218.104.235.238地址  110.125端口的包全部转发到 192.168.9.1上。
--to-destination   //目的地重写
```

5、SNAT

用在nat 表的postrouting链表。这个和DNAT相反。是做源地址转换。就是重写源地址IP。 常用在内部网到外部网的转换。

--to-source

```
iptables -t nat POSTROUTING  -o eth0 -p tcp  -j SNAT --to-source 218.107.248.127  //从eth0接口往外发的数据包都把源地址重写为218.107.248.127
```

```
iptables -t nat -A PREROUTING -p tcp -d 15.45.23.67 --dport 80 -j DNAT --to-destination 192.168.1.9
# 将所有的访问15.45.23.67:80端口的数据做DNAT发到192.168.1.9:80
```

如果和192.168.1.9在同一内网的机器要访问15.45.23.67，防火墙还需要做设置，改变源IP为防火墙内网IP 192.168.1.1。否则数据包直接发给内网机器，对方将丢弃。

```
iptables -t nat -A POSTROUTING -p tcp --dst 15.45.23.67 --dport 80 -j SNAT --to-source 192.168.1.1
# 将所有的访问15.45.23.67:80端口的数据包源IP改为192.168.1.1
```

如果防火墙也需要访问15.45.23.67:80，则需要在OUTPUT链中添加，因为防火墙自己发出的包不经过PREROUTING。

```
iptables -t nat -A OUTPUT --dst 15.45.23.67 --dport 80 -j DNAT --to-destination 192.168.1.9
```

6、MASQUERADE

masquerade 的作用和 SNAT的作用是一样的。 区别是，他不需要指定固定的转换后的IP地址。专门用来设计动态获取IP地址的连接的。

MASQUERADE的作用是，从服务器的网卡上，自动获取当前ip地址来做NAT

如家里的ADSL上网，外网的IP地址不是固定的，你无法固定的设定NAT转换后的IP地址。这时就需要用masquerade来动态获取了。

```
iptables -t nat -A POSTROUTING  -s 192.168.1.0/24 -j masquerade      //即把192.168.1.0 这个网段的地址都重写为动态的外部IP地址。
```

7、REDIRECT

只能在NAT表中的PREROUTING  OUTPUT 链中使用

在防火墙所在的机子内部转发包或流到另一个端口。比如，我们可以把所有去往端口HTTP的包REDIRECT到HTTP proxy（例如squid），当然这都发生在我们自己的主机内部。

--to-ports

```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
```

不使用这个选项，目的端口不会被改变。

指定一个端口，如--to-ports 8080

指定端口范围，如--to-ports 8080-8090

8、RETURN

顾名思义，它使包返回上一层，顺序是：子链——>父链——>缺省的策略。具体地说，就是若包在子链中遇到了RETURN，则返回父链的下一条规则继续进行条件的比较，若是在父链（或称主链，比如INPUT）中遇到了RETURN，就要被缺省的策略（一般是ACCEPT或DROP）操作了。（译者注：这很象C语言中函数返回值的情况）

9、MIRROR

颠倒IP头中的源地址与目的地址，再转发。

10、LOG

在内核空间记录日志，dmesg等才能看。

11、ULOG

在用户空间记录日志。

#### （五）IP转发功能

打开转发IP功能（IP forwarding）：

```
echo "1" > /proc/sys/net/ipv4/ip_forward
```

如果使用PPP、DHCP等动态IP，需要打开：

```
echo "1" > /proc/sys/net/ipv4/ip_dynaddr
```
