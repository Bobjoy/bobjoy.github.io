title: 'extjs菜单树在IE9下不能加载，报SCRIPT5007: 无法获取未定义或 null 引用的属性“ui”'
date: 2016-01-19 18:01:13
categories:
tags: ["ExtJS"]
---
extjs菜单树在IE10下不能加载，报SCRIPT5007: 无法获取未定义或 null 引用的属性“ui” 

在ext-all.js下找这个getAttributeNS 方法，把判断ie的代码注释掉就好了;

```javascript
getAttributeNS : (Ext.isIE 
    && !(/msie 9/.test(navigator.userAgent.toLowerCase()) && document.documentMode===9)
    && !(/msie 10/.test(navigator.userAgent.toLowerCase())&&document.documentMode===10))?
    function(ns, name){
        var d=this.dom;
        var type = typeof d[ns+":"+name];
        if( type != 'undefined' && type != 'unknown' ){
            return d[ns+":"+name];
        }
        return d[name];
    } : function(ns, name){
        var d = this.dom;
        return d.getAttributeNS(ns, name) || d.getAttribute(ns+":"+name) || d.getAttribute(name) || d[name];
    }
```

原文地址：http://www.lxway.com/910062484.htm