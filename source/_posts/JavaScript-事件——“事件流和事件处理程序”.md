title: ' JavaScript 事件——“事件流和事件处理程序”'
date: 2016-01-11 13:52:46
categories:
tags: ["JavaScript"]
---
## 事件流

事件流描述的是从页面中接收事件的顺序。IE的事件流是事件冒泡流，而Netscape Communicator的事件流是事件捕获流。

### 事件冒泡

即事件开始时由最具体的元素接收，然后逐级向上传播到较为不具体的节点。如：

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>
  <div>Click</div>
</body>
</html>
```

当点击了页面中的div元素，那么这个click事件会按照如下顺序传播：

- div元素
- body元素
- html元素
- document对象

### 事件捕获

事件捕获的思想是最具体的节点应该最后接收到事件。事件捕获的用意在于事件到达目标之前捕获它。
<!--more-->
当点击了页面中的div元素，那么这个click事件则会按照如下顺序传播：

- document对象
- html标签
- body标签
- div标签

虽然规范要求事件应该从document对象开始传播，但浏览器一般都是从window对象开始捕获事件的。因为老版本浏览器不支持，所以一般都使用事件冒泡。

## DOM事件流

“DOM2级事件”规定的事件流包括三个阶段：事件捕获阶段、处于目标阶段和事件冒泡阶段。

在DOM事件流中，实际的目标在捕获阶段不会接收事件。就是说在 捕获阶段，事件从document到html再到body后就停止了。 下一个阶段是“处于目标”阶段，于是事件在div中发生，并在事件处理中被看成是冒泡阶段的一部分。然后，冒泡阶段发生。IE8及更早的版本不支持DOM事件流，浏览器在捕获阶段触发事件对象上的事件，结果就是有两个机会在目标对象上面操作事件。

### 事件处理程序

事件就是用户或浏览器自身执行的某种动作；事件处理程序（或事件侦听器）就是响应某个事件的函数。事件处理程序的名字以“on”开头，如onload、onclick等。

### HTML事件处理程序

若要在按钮被单击时执行一些js代码，可以这样编写：

```html
<div onclick="alert('Clicked')">Click</div>
```

注意：不能在其中使用未经转义的HTML语法字符。

也可以调用在页面中其他地方定义的脚本：

```html
<script>
function showMessage() {
  document.write("fdas");
}
</script>
<input type="button" value="Click Me" onclick="showMessage()" />
```

事件处理程序中的代码在执行时，有权访问全局作用域中的任何代码。

这样使用会创建一个封装着的元素属性值的函数。这个函数有一个局部变量 event ，也就是事件对象：

```html
<input type="button" value="Click Me" onclick="alert(event.type)" />
```

其中， this 值等于事件的目标元素，如：

```html
<input type="button" value="Click Me" onclick="alert(this.value)" />
```

HTML事件处理程序存在众多问题，所以应该使用js指定的事件处理程序 DOM0级事件处理程序
要使用js指定事件处理程序，首先必须取得一个要操作的对象的引用。

每个元素都有自己的事件处理程序属性，这些属性通常全部小写，如onclick。如：

```html
<input type="button" value="Click Me" id="btn" />
<script>
document.querySelector("#btn").onclick = function() {
  console.log("hello");
}
</script>
```

使用DOM0级方法指定的事件处理程序被认为是元素的方法。因此，这时候的事件处理程序是在元素的作用域中运行的；也就是this引用当前元素：

```html
<input type="button" value="Click Me" id="btn" />
<script>
document.querySelector("#btn").onclick = function() {
  console.log(this.type);
}
</script>
```

以上述这种方式添加的事件处理程序会在事件流的冒泡阶段被处理。

删除通过DOM0级方法指定的事件处理程序：

btn.onclick = null; DOM2级事件处理程序 addEventListener()
该方法接收三个参数：要处理的事件名、事件处理程序函数和布尔值；布尔值如果是true，表示在捕获阶段调用事件处理程序；如果是false，表示在冒泡阶段调用事件处理程序。如：

```javascript
var btn = document.getElementById("btn");
btn.addEventListener("click", function () {
  console.log(this.id);
})
```

还可以为该按钮添加多个事件处理程序，如：

```javascript
var btn = document.getElementById("btn");

btn.addEventListener("click", function() {
  console.log(this.id);
});

btn.addEventListener("click", function() {
  console.log(this.value);
});

removeEventListener();

var btn = document.getElementById("btn");

function info () {
  console.log(this.value);
}

btn.addEventListener("click", info);

btn.addEventListener("click", function () {
  console.log(this.id);
});

btn.addEventListener("click", function valueAndId () {
  console.log(this.value + " " + this.id);
});

btn.removeEventListener("click", info); // succ

btn.removeEventListener("click", function () {
  console.log(this.id);
}); // no effect

btn.removeEventListener("click", valueAndId); // error
```

大多数情况下，都是将事件处理程序添加到事件流的冒泡阶段，这样就可以最大限度地兼容各种浏览器。

> 原文地址：http://www.codesec.net/view/244340.html