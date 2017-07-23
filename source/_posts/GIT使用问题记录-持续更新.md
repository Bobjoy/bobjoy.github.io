title: GIT使用问题记录(持续更新)
date: 2017-07-23 18:48:06
categories: ['Git']
tags: ['Git']
---
## Git submodule add: “a git directory is found locally” issue

### 问题描述

```shell
git submodule add https://github.com/iissnan/hexo-theme-next.git themes/next --branch master
A git directory for 'themes/next' is found locally with remote(s):
  origin        https://github.com/XXX/hexo-theme-next.git
If you want to reuse this local git directory instead of cloning again from
  https://github.com/iissnan/hexo-theme-next.git
use the '--force' option. If the local git directory is not the correct repo
or you are unsure what this means choose another name with the '--name' option.
```

### 解决方法

1. `git rm –-cached themes/next`

2. 删除 `.gitmodules` 文件中如下内容:

```yml
[submodule "themes/next"]
	path = themes/next
	url = https://github.com/XXX/hexo-theme-next.git
```

3. 删除 `.git/config` 文件中如下内容:

```yml
[submodule "path_to_submodule"]
    url = https://github.com/XXX/hexo-theme-next.git
```

4. 运行 `rm -rf .git/modules/themes/next`

5. 重新添加子模块 `git submodule add https://github.com/iissnan/hexo-theme-next.git`

### 参考文章

* https://stackoverflow.com/questions/20929336/git-submodule-add-a-git-directory-is-found-locally-issue


## git中不记录子模块中文件的修改

### 问题描述

在自己的git项目中添加了外部的git项目，有时候需要修改子模块中的文件，但是执行 `git status` 时又不想看到子模块文件的修改

### 解决办法

在 `.gitmodules` 中添加 `ignore = dirty` 设置，如下

```
[submodule "themes/next"]
	path = themes/next
	url = https://github.com/iissnan/hexo-theme-next.git
	branch = master
	ignore = dirty
```