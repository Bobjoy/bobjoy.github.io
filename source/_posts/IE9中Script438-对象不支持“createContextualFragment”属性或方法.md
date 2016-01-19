title: 'IE9中Script438: 对象不支持“createContextualFragment”属性或方法'
date: 2016-01-19 18:07:25
categories:
tags: ["ExtJS"]
---

这个问题在Extjs的官网有人讨论，详见 http://www.sencha.com/forum/showthread.php?125869-Menu-shadow-probolem-in-IE9&p=579336

至于解决办法也很简单，只要在网页什么地方加上

```javascript
if ((typeof Range !== "undefined") && !Range.prototype.createContextualFragment)
{
	Range.prototype.createContextualFragment = function(html)
	{
		var frag = document.createDocumentFragment(), 
		div = document.createElement("div");
		frag.appendChild(div);
		div.outerHTML = html;
		return frag;
	};
}
```

正对IE8提示 Range 未定义，可以在最前面添加如下

```javascript
var Range = window.Range || function(){};
```

参考链接：http://www.cnblogs.com/m1234/p/3325705.html