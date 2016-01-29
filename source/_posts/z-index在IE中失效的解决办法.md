title: z-index在IE中失效的解决办法
date: 2016-01-25 11:32:22
categories:
tags: ["CSS"]
---
IE6、7都存在着z-index失效的bug，万恶的IE，对于每一个美工来说，IE都不怎么招人待见。但是又无法不照顾到它，毕竟它还占有强大的市场份额。我们不能期望它做出什么改变，我们就要学会找到方法去迎合它。

z-index是让元素漂浮起来的一个属性，在IE6、7中无论你把Z-INDEX的级别设置的有多高，它就是不漂浮起来。在CSS中，要让z-index起作用有个小小前提，就是元素的position属性要是relative，absolute或是fixed。

1. 第一种情况（z-index无论设置多高都不起作用情况）：这种情况发生的条件有三个：

    1. 父标签 position属性为relative；
    2. 问题标签无position属性（不包括static）；
    3. 问题标签含有浮动(float)属性。
   
    eg:z-index层级不起作用，浮动会让z-index失效

    ```html
    <div style="position:relative; z-index:9999;">
        <img style="float:left;" src="http://www.jacoobs.com/image/logo.jpg" />
    </div>   
    ```

    解决办法有三个（任一即可）：
        1、position:relative改为position:absolute；
        2、浮动元素添加position属性（如relative，absolute等）；
        3、去除浮动。
   

2. 第二种情况

    IE6下，层级的表现有时候不是看子标签的z-index多高，而要看整个DOM tree（节点树）的第一个relative属性的父标签的层级。

    eg:IE7与IE6有着同样的bug，原因很简单，虽然图片所在div当前的老爸层级很高(1000)，但是由于老爸的老爸不顶用，可怜了9999如此强势的孩子没有出头之日啊！

    ```html
    <div style="position:relative;">
        <div style="position:relative; z-index:1000;">
            <div style="position:absolute; z-index:9999;">
                <img src="http://www.jacoobs.com/image/logo.jpg" />
            </div>
        </div>
    </div>
    ```

    解决办法： 在第一个relative属性加上一个更高的层级（z-index:1）

    ```html
    <div style="position:relative; z-index:1;">
        <div style="position:relative; z-index:1000;">
            <div style="position:absolute; z-index:9999;">
                 <img src="http://www.jacoobs.com/image/logo.jpg" />
            </div>
        </div>
    </div>
    ```

z-index这玩意深不可测，里面所蕴含的知识不是 CSS手册上的那点东西，那只是冰山一角。这涉及到border及background的堆叠模型，涉及到同层级的显示问题，以及浏览器显示的些机制等， 这是很深的一潭水。