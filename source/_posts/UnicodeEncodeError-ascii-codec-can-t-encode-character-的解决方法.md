title: "UnicodeEncodeError: 'ascii' codec can't encode character...的解决方法"
date: 2015-09-15 14:42:55
categories: ["编程开发"]
tags: ["Python"]
photos:
  - "https://images.pexels.com/photos/587737/pexels-photo-587737.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
在python2.7下，因为想从数据库中读出来分类名进行写入到文件,提示
```
Traceback (most recent call last):
  File "test.py", line 28, in <module>
    fp.write("%d:%s\r\n"%(sClassid,sClassName))
UnicodeEncodeError: 'ascii' codec can't encode character u'\uff08' in position 12: ordinal not in range(128
```

不用fp.write，用print打印却正常，这到底是怎么回来呢？

```
#! /usr/bin/python
# -*- coding: utf-8 -*-
import sys
print sys.getdefaultencoding();
```
运行上面的程序提示

```
ascii
```

原来如此，在程序的头部加上

```
import sys

reload(sys)
sys.setdefaultencoding('utf-8')
```

再次运行，错误消息。

总结一下，python2.7是基于ascii去处理字符流，当字符流不属于ascii范围内，就会抛出异常（ordinal not in range(128)）
