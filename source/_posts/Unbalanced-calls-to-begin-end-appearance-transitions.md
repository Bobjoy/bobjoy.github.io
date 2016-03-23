title: Unbalanced calls to begin/end appearance transitions
date: 2015-07-15 09:40:45
categories: ["移动开发"]
tags: ["iOS","Swift"]
toc: false
---
问题：Unbalanced calls to begin/end appearance transitions for <uivewcontroller> 

原因：原因就是上次动画还没结束，然后又开始了新的动画。  这样就导致不能成功切换页面，而是一个白色无内容的页面。 

出现unbalanced calls to begin/end appearance transitions for uiviewcontroller这样的log，其原因就是在容器类的UIViewController（如，UINavigationController, UITabBarController）中动画没做完，然后又开始新的动画.。解决办法就是让动画完后再做新的动画。 

解决方法1：去掉动画 
解决方法2：监听当前view的动画是否完成
解决方法3：将要执行的动作放在viewDidAppear方法中执行