title: "Context namespace element 'annotation-config' and its parser class [org.springframework.context.annotation.AnnotationConfigBeanDefinitionParser]"
date: 2016-06-14 17:10:51
categories:
tags:
---
### 环境

* 系统：Windows Server 2003
* Java： 1.6.0_45（后来安装了jre1.8.0_91）
* Spring：2.5.5
* Tomcat：7.0.27

### 问题

Tomcat是绿色版，通过`service.bat`安装服务，启动后打开浏览器测试，发现页面一片空白，通过查看Tomcat日志，发现有一处异常，如下：

```
严重: Exception sending context initialized event to listener instance of class org.springframework.web.context.ContextLoaderListener
org.springframework.beans.factory.BeanDefinitionStoreException: Unexpected exception parsing XML document from class path resource [applicationContext.xml]; nested exception is java.lang.IllegalStateException: Context namespace element 'annotation-config' and its parser class [org.springframework.context.annotation.AnnotationConfigBeanDefinitionParser] are only available on JDK 1.5 and higher
    at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.doLoadBeanDefinitions(XmlBeanDefinitionReader.java:420)
<!--more-->
    at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.loadBeanDefinitions(XmlBeanDefinitionReader.java:342)
    at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.loadBeanDefinitions(XmlBeanDefinitionReader.java:310)
    at org.springframework.beans.factory.support.AbstractBeanDefinitionReader.loadBeanDefinitions(AbstractBeanDefinitionReader.java:143)
    at org.springframework.beans.factory.support.AbstractBeanDefinitionReader.loadBeanDefinitions(AbstractBeanDefinitionReader.java:178)
    at org.springframework.beans.factory.support.AbstractBeanDefinitionReader.loadBeanDefinitions(AbstractBeanDefinitionReader.java:149)
    at org.springframework.web.context.support.XmlWebApplicationContext.loadBeanDefinitions(XmlWebApplicationContext.java:124)
    at org.springframework.web.context.support.XmlWebApplicationContext.loadBeanDefinitions(XmlWebApplicationContext.java:92)
    at org.springframework.context.support.AbstractRefreshableApplicationContext.refreshBeanFactory(AbstractRefreshableApplicationContext.java:123)
    at org.springframework.context.support.AbstractApplicationContext.obtainFreshBeanFactory(AbstractApplicationContext.java:422)
    at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:352)
    at org.springframework.web.context.ContextLoader.createWebApplicationContext(ContextLoader.java:255)
    at org.springframework.web.context.ContextLoader.initWebApplicationContext(ContextLoader.java:199)
    at org.springframework.web.context.ContextLoaderListener.contextInitialized(ContextLoaderListener.java:45)
    at org.apache.catalina.core.StandardContext.listenerStart(StandardContext.java:4791)
    at org.apache.catalina.core.StandardContext.startInternal(StandardContext.java:5285)
    at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:150)
    at org.apache.catalina.core.ContainerBase.addChildInternal(ContainerBase.java:901)
    at org.apache.catalina.core.ContainerBase.addChild(ContainerBase.java:877)
    at org.apache.catalina.core.StandardHost.addChild(StandardHost.java:618)
    at org.apache.catalina.startup.HostConfig.deployDirectory(HostConfig.java:1100)
    at org.apache.catalina.startup.HostConfig$DeployDirectory.run(HostConfig.java:1618)
    at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
    at java.util.concurrent.FutureTask.run(FutureTask.java:266)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
    at java.lang.Thread.run(Thread.java:745)
Caused by: java.lang.IllegalStateException: Context namespace element 'annotation-config' and its parser class [org.springframework.context.annotation.AnnotationConfigBeanDefinitionParser] are only available on JDK 1.5 and higher
    at org.springframework.context.config.ContextNamespaceHandler$1.parse(ContextNamespaceHandler.java:65)
    at org.springframework.beans.factory.xml.NamespaceHandlerSupport.parse(NamespaceHandlerSupport.java:69)
    at org.springframework.beans.factory.xml.BeanDefinitionParserDelegate.parseCustomElement(BeanDefinitionParserDelegate.java:1297)
    at org.springframework.beans.factory.xml.BeanDefinitionParserDelegate.parseCustomElement(BeanDefinitionParserDelegate.java:1287)
    at org.springframework.beans.factory.xml.DefaultBeanDefinitionDocumentReader.parseBeanDefinitions(DefaultBeanDefinitionDocumentReader.java:135)
    at org.springframework.beans.factory.xml.DefaultBeanDefinitionDocumentReader.registerBeanDefinitions(DefaultBeanDefinitionDocumentReader.java:92)
    at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.registerBeanDefinitions(XmlBeanDefinitionReader.java:507)
    at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.doLoadBeanDefinitions(XmlBeanDefinitionReader.java:398)
    ... 26 more
六月 14, 2016 1:38:09 下午 org.apache.catalina.core.StandardContext startInternal
严重: Error listenerStart
```

查看错误，找到关键点`only available on JDK 1.5 and higher`，验证这个百毒了一下，找到关键的原因点：

1. JRE版本
2. Tomcat7启动时用到了JRE
3. Spring框架中有一个jkdcheckversion方法，这个方法中，没有兼容到1.8

### 解决办法

1. 降级JRE，即卸载JRE1.8，使用JRE1.6
2. 修改Tomcat启动环境变量，
  * 系统添加JRE_HOME环境变量，这个需要重启服务器（由于是客户的服务器，不能随便重启）
  * 修改`setclasspath.bat`批处理文件，在最前面添加
    ```
    set JAVA_HOME=C:\Program Files\Java\jdk1.6.0_45
    set JRE_HOME=C:\Program Files\Java\jdk1.6.0_45\jre
    ```
  * 修改完了批处理文件后，需要卸载Tomcat服务，重新安装服务
