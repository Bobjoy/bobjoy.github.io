title: '使用hexo generate生成文章时报错JS-YAML: can not read a block mapping entry'
date: 2015-07-28 09:42:13
tags: ["Hexo"]
---

在使用`hexo generate`生成静态文章时报错了，错误内容如下

```
ERROR Process failed: _posts/vagrant-reload命令报错-UndefinedConversionError.md
JS-YAML: can not read a block mapping entry; a multiline key may not be an implicit key at line 4, column 1:

    ^
```

错误原因是在`tags:["vagrant", "ruby"]`中tag:后面必须要有空格(半角)