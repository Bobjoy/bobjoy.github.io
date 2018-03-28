title: Java-SpringMVC请求json，客户端显示406状态码
date: 2018-03-28 13:39:31
categories: ["编程开发"]
tags: ["Java", "SpringMVC", "Ajax", "406"]
---

## 问题描述

* 主要配置：

  ```xml
  <mvc:message-converters register-defaults="true">
      <!-- StringHttpMessageConverter编码为UTF-8，防止乱码 -->
      <bean class="org.springframework.http.converter.StringHttpMessageConverter">
          <constructor-arg value="UTF-8"/>
          <property name = "supportedMediaTypes">
              <list>
                  <value>text/plain;charset=UTF-8</value>
                  <value>text/html;charset=UTF-8</value>
              </list>
          </property>
      </bean>
      <!-- 避免IE执行AJAX时,返回JSON出现下载文件 -->
      <bean id="fastJsonHttpMessageConverter" class="com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter">
          <property name="supportedMediaTypes">
              <list>
                  <value>application/json;charset=UTF-8</value>
              </list>
          </property>
      </bean>
  </mvc:message-converters>
  ```

* 主要方法：

  ```java
  /**
   * 新增
   */
  @RequestMapping(value = "ajaxCreate", method = RequestMethod.POST)
  @ResponseBody
  public AjaxResponse ajaxCreate(@Valid @ModelAttribute("m") Sample m, BindingResult result) throws AjaxException {
  
      if (permissionList != null) {
          this.permissionList.assertHasCreatePermission();
      }
  
      if (hasError(m, result)) {
          return AjaxResponse.fail(getErrors(result));
      }
  
      baseService.save(m);
      return AjaxResponse.ok("新增成功");
  }
  ```

* 客户端请求：

  - 请求方法

  ```javascript
  $.ajax({
      url: '/showcase/sample/ajaxCreate',
      type: 'POST',
      date: form,
      dateType: 'json',
      success: function(ret) {
          // ...
      }
  })
  ```

  ![](http://7xkexv.dl1.z0.glb.clouddn.com/18-3-28/82236650.jpg)

  ![](http://7xkexv.dl1.z0.glb.clouddn.com/18-3-28/34804039.jpg)


## 解决过程

1. 这个406错误码几乎没有碰到过，都不知道是什么意思，[搜索][1]了解释：

  > 
  HTTP 错误 406 
  406 不可接受 
  根据此请求中所发送的“接受”标题，此请求所标识的资源只能生成内容特征为“不可接受”的响应实体。 
  如果问题依然存在，请与服务器的管理员联系。 

2. 顿时懵逼了，不知如何下手，于是谷歌半天，查到如下解决方案

  - ~~由于使用的是fastjson，所以在官网[github][2]上找到了相应的[办法][3]~~
  - ~~[Spring4 MVC json问题(406 Not Acceptable)][4]~~
  - ......

3. 网络上查询到的解决方案大致都是一样的思路，然而在我的项目中并不起作用，折腾了一下午，解决思路都是围绕着后台，最好我尝试着重请求端去查找问题，于是我比对了以下正常请求与该请求，发现了一个不同：

  ![](http://7xkexv.dl1.z0.glb.clouddn.com/18-3-28/81972710.jpg)

  ![](http://7xkexv.dl1.z0.glb.clouddn.com/18-3-28/82236650.jpg)

  圈红框的地方就是不同之处，正常的请求头比异常的少了一块 `Accept: application/json, text/javascript, */*; q=0.01`，试着从此处入手，修改了ajax请求，添加了Accept头：

  ```javascript
  $.ajax({
      url: '/showcase/sample/ajaxCreate',
      type: 'POST',
      date: form,
      dateType: 'json',
      headers: {
          Accept: 'application/json; charset=utf-8'
      },
      success: function(ret) {
          // ...
      }
  })
  ```

  ![](http://7xkexv.dl1.z0.glb.clouddn.com/18-3-28/15231607.jpg)

  问题解决了


## 总结

有时候解决问题不能太局限了，一开始是围绕着SpringMVC后台去查找问题，各种谷歌、StackOverflow的搜索，也尝试了找到的解决方案，由于每个人的场景肯不一样，所以找到的答案并不一定可以解决你的问题，所以这个时候就需要换个思路去想问题，既然406这个状态码是客户端请求错误，那么可以重客户端请求方面查找问题！


[1]: https://www.cnblogs.com/ylei11/p/6375862.html
[2]: https://github.com/alibaba/fastjson/issues/55
[3]: http://yingzhuo.iteye.com/blog/1602545
[4]: https://blog.csdn.net/woshiwanxin102213/article/details/37521303