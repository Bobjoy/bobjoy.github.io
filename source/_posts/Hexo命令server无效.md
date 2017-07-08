title: Hexo命令server无效
date: 2017-06-28 16:37:35
categories: ['Hexo']
tags: ['Hexo']
---

按照好 `hexo-cli` 后， `hexo new` 创建一篇文章，然后 `hexo server` 本地运行调试，但是试了好几次都没反应，控制台直接打印帮助文档，然后命令帮助中也没有发现 `server` 命令，然后各种google，发现hexo3中 server 模块已经独立出来需要单独安装。 `npm install hexo-server` 安装后再运行 `hexo server` ，然鹅并没有什么卵用，继续google，发现一些hexo问题中提到plugins的配置，于是抱着试一试的态度将 `_config.yml` 中的plugins配置注释掉

```yml
#plugins:
#- hexo-generator-feed
#- hexo-generator-sitemap
```

再这运行，O啦

> 2017-07-08 18:15 更新

如果出现如下错误

```shell
...
TypeError: Cannot set property 'lastIndex' of undefined
    at highlight (/home/rapiz/Blog/node_modules/highlight.js/lib/highlight.js:514:35)
... 
```

则需要将 `_config.yml` 中的以下配置

```yml
highlight:
  auto_detect: true
```

修改为

```yml
highlight:
  auto_detect: false
```