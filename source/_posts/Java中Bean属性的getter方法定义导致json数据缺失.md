title: Java中Bean属性的getter方法定义导致json数据缺失
date: 2018-03-22 17:53:03
categories: ["编程开发"]
tags: ["Java", "JSON"]
---

## 问题描述

手头上有一个项目，使用的是 `jsp` 写的，数据都是使用 `jsp` 标签来处理的，现在想使用 `ajax` 请求。有一个页面用到了zTree，数据是用 `c:forEach` 标签封装的，如下：

```
var zNodes =[
    <c:forEach items="${trees}" var="m">
    { id:${m.id}, pId:${m.pId}, name:"${m.name}", iconSkin:"${m.iconSkin}", open: true, root : ${m.root},isParent:${m.isParent}},
    </c:forEach>
];
```

javaBean如下：

```
public class ZTree<ID extends Serializable> implements Serializable {
    private ID id;
    private ID pId;
    private String name;
    private String iconSkin;
    private boolean open;
    private boolean root;
    private boolean isParent;
    private boolean nocheck = false;

    public ID getId() {
        return id;
    }

    public void setId(ID id) {
        this.id = id;
    }

    public ID getpId() {
        return pId;
    }

    public void setpId(ID pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIconSkin() {
        return iconSkin;
    }

    public void setIconSkin(String iconSkin) {
        this.iconSkin = iconSkin;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isRoot() {
        return root;
    }

    public void setRoot(boolean root) {
        this.root = root;
    }

    public boolean isIsParent() {
        return isParent;
    }

    public void setIsParent(boolean isParent) {
        this.isParent = isParent;
    }

    public boolean isNocheck() {
        return nocheck;
    }

    public void setNocheck(boolean nocheck) {
        this.nocheck = nocheck;
    }

}
```

后台使用 `ajax` 异步请求该 `javaBean` 列表，发现 `json` 有一个属性 `pId` 始终没有返回，，在返回对象前都有数据，但是到了页面就没有了。


## 解决办法

检查了配置文件，调试了半天，只能从源头查找问题，看到bean，看到 `pId`，突然想起来getter、setter方法大小写的问题，试着将getter、setter方法修改如下：

```
public ID getPId() {
    return pId;
}

public void setPId(ID pId) {
    this.pId = pId;
}
```

再ajax请求，数据原样返回来了。

> 2018-03-23 后来发现使用的 `fastjson` 的版本太低了，只需要更新 `fastjson` 的版本，无须修改bean，同样可以解决问题


## 问题原因

### javaBean规范

javabean规范文档：http://download.oracle.com/otndocs/jcp/7224-javabeans-1.01-fr-spec-oth-JSpec/，里面的有以下两个章节降到了具体的命名规则：

> 
* 8.3.1 Simple properties
* 8.3.2 Boolean properties
* 8.8 Capitalization of inferred names.

这个文档里面说明了，从getter和setter方法名如何推倒出propertyName：

    一般情况，把除去get或者is（如果是boolean类型）后的部分首字母转成小写即可，比如：getFoo –> foo
    如果除去get和is后端的部分，首字母和第二个字母都是大写，不作转换即可，比如：getXPath –> XPath

例如：

```
private String getepath    -->    getGetepath()
private String getEpath    -->    getGetEpath()
private String epath       -->    getEpath()     
private String ePath       -->    getePath()    // 首字母不用大写
private String Epath       -->    getEpath()    // 和epath的getter方法是一样的
private String EPath       -->    getEPath()
private boolean isenable   -->    isIsenable()
private boolean isEnable   -->    isEnable()    // 不是把首字母大写并在前面加is，其结果和enable的getter方法相同
private boolean enable     -->    isEnable()
private boolean eNable     -->    iseNable()    // 首字母不用大写
private boolean Enable     -->    isEnable()    // 和enable的getter方法相同
private boolean ENable     -->    isENable()    //
```

### 什么时候你需要关注getter和setter方法的生成规则？

* 想要序列化为json对象时，如果你使用gson的话，基本没啥问题，但要是你使用了低版本的fastjson，那么可能会中枪了
* 要自己写代码拼装出getter和setter方法名，以此来通过反射查找Method时


### 编码规范

* 属性的前两个都以小写开头
* boolean类型不要用is开头


> 参考文章：http://rongmayisheng.com/post/java%E4%B8%AD%E5%9D%91%E7%88%B9%E7%9A%84getter%E3%80%81setter%E6%96%B9%E6%B3%95%E7%9A%84%E6%BD%9C%E8%A7%84%E5%88%99