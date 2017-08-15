title: 记一次Spring注入Bean异常
date: 2017-08-03 12:36:38
categories:
tags:
---
## 问题描述

```java
 org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'userLastOnlineController': Injection of autowired dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Could not autowire method: public void com.bfl.sa.common.web.controller.BaseCRUDController.setBaseService(com.bfl.sa.common.service.BaseService); nested exception is org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type [com.bfl.sa.common.service.BaseService] found for dependency: expected at least 1 bean which qualifies as autowire candidate for this dependency. Dependency annotations: {}
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.postProcessPropertyValues(AutowiredAnnotationBeanPostProcessor.java:334) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.populateBean(AbstractAutowireCapableBeanFactory.java:1214) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:543) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:482) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory$1.getObject(AbstractBeanFactory.java:306) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:230) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:302) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:197) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:772) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:839) ~[spring-context-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:538) ~[spring-context-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.configureAndRefreshWebApplicationContext(FrameworkServlet.java:667) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.createWebApplicationContext(FrameworkServlet.java:633) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.createWebApplicationContext(FrameworkServlet.java:681) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.initWebApplicationContext(FrameworkServlet.java:552) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.initServletBean(FrameworkServlet.java:493) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.web.servlet.HttpServletBean.init(HttpServletBean.java:136) ~[spring-webmvc-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at javax.servlet.GenericServlet.init(GenericServlet.java:158) ~[servlet-api.jar:3.1.FR]
	at org.apache.catalina.core.StandardWrapper.initServlet(StandardWrapper.java:1227) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.StandardWrapper.loadServlet(StandardWrapper.java:1140) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.StandardWrapper.load(StandardWrapper.java:1027) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.StandardContext.loadOnStartup(StandardContext.java:5038) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.StandardContext.startInternal(StandardContext.java:5348) ~[catalina.jar:8.0.37]
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:145) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.ContainerBase.addChildInternal(ContainerBase.java:725) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.ContainerBase.addChild(ContainerBase.java:701) ~[catalina.jar:8.0.37]
	at org.apache.catalina.core.StandardHost.addChild(StandardHost.java:717) ~[catalina.jar:8.0.37]
	at org.apache.catalina.startup.HostConfig.manageApp(HostConfig.java:1696) ~[catalina.jar:8.0.37]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_101]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_101]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_101]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_101]
	at org.apache.tomcat.util.modeler.BaseModelMBean.invoke(BaseModelMBean.java:300) ~[tomcat-coyote.jar:8.0.37]
	at com.sun.jmx.interceptor.DefaultMBeanServerInterceptor.invoke(DefaultMBeanServerInterceptor.java:819) ~[?:1.8.0_101]
	at com.sun.jmx.mbeanserver.JmxMBeanServer.invoke(JmxMBeanServer.java:801) ~[?:1.8.0_101]
	at org.apache.catalina.mbeans.MBeanFactory.createStandardContext(MBeanFactory.java:484) ~[catalina.jar:8.0.37]
	at org.apache.catalina.mbeans.MBeanFactory.createStandardContext(MBeanFactory.java:433) ~[catalina.jar:8.0.37]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_101]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_101]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_101]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_101]
	at org.apache.tomcat.util.modeler.BaseModelMBean.invoke(BaseModelMBean.java:300) ~[tomcat-coyote.jar:8.0.37]
	at com.sun.jmx.interceptor.DefaultMBeanServerInterceptor.invoke(DefaultMBeanServerInterceptor.java:819) ~[?:1.8.0_101]
	at com.sun.jmx.mbeanserver.JmxMBeanServer.invoke(JmxMBeanServer.java:801) ~[?:1.8.0_101]
	at javax.management.remote.rmi.RMIConnectionImpl.doOperation(RMIConnectionImpl.java:1468) ~[?:1.8.0_101]
	at javax.management.remote.rmi.RMIConnectionImpl.access$300(RMIConnectionImpl.java:76) ~[?:1.8.0_101]
	at javax.management.remote.rmi.RMIConnectionImpl$PrivilegedOperation.run(RMIConnectionImpl.java:1309) ~[?:1.8.0_101]
	at javax.management.remote.rmi.RMIConnectionImpl.doPrivilegedOperation(RMIConnectionImpl.java:1401) ~[?:1.8.0_101]
	at javax.management.remote.rmi.RMIConnectionImpl.invoke(RMIConnectionImpl.java:829) ~[?:1.8.0_101]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_101]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_101]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_101]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_101]
	at sun.rmi.server.UnicastServerRef.dispatch(UnicastServerRef.java:324) ~[?:1.8.0_101]
	at sun.rmi.transport.Transport$1.run(Transport.java:200) ~[?:1.8.0_101]
	at sun.rmi.transport.Transport$1.run(Transport.java:197) ~[?:1.8.0_101]
	at java.security.AccessController.doPrivileged(Native Method) ~[?:1.8.0_101]
	at sun.rmi.transport.Transport.serviceCall(Transport.java:196) ~[?:1.8.0_101]
	at sun.rmi.transport.tcp.TCPTransport.handleMessages(TCPTransport.java:568) ~[?:1.8.0_101]
	at sun.rmi.transport.tcp.TCPTransport$ConnectionHandler.run0(TCPTransport.java:826) ~[?:1.8.0_101]
	at sun.rmi.transport.tcp.TCPTransport$ConnectionHandler.lambda$run$0(TCPTransport.java:683) ~[?:1.8.0_101]
	at java.security.AccessController.doPrivileged(Native Method) ~[?:1.8.0_101]
	at sun.rmi.transport.tcp.TCPTransport$ConnectionHandler.run(TCPTransport.java:682) [?:1.8.0_101]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142) [?:1.8.0_101]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617) [?:1.8.0_101]
	at java.lang.Thread.run(Thread.java:745) [?:1.8.0_101]
Caused by: org.springframework.beans.factory.BeanCreationException: Could not autowire method: public void com.bfl.sa.common.web.controller.BaseCRUDController.setBaseService(com.bfl.sa.common.service.BaseService); nested exception is org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type [com.bfl.sa.common.service.BaseService] found for dependency: expected at least 1 bean which qualifies as autowire candidate for this dependency. Dependency annotations: {}
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor$AutowiredMethodElement.inject(AutowiredAnnotationBeanPostProcessor.java:661) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.annotation.InjectionMetadata.inject(InjectionMetadata.java:88) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.postProcessPropertyValues(AutowiredAnnotationBeanPostProcessor.java:331) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	... 65 more
Caused by: org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type [com.bfl.sa.common.service.BaseService] found for dependency: expected at least 1 bean which qualifies as autowire candidate for this dependency. Dependency annotations: {}
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.raiseNoSuchBeanDefinitionException(DefaultListableBeanFactory.java:1373) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1119) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1014) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor$AutowiredMethodElement.inject(AutowiredAnnotationBeanPostProcessor.java:618) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.annotation.InjectionMetadata.inject(InjectionMetadata.java:88) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.postProcessPropertyValues(AutowiredAnnotationBeanPostProcessor.java:331) ~[spring-beans-4.2.5.RELEASE.jar:4.2.5.RELEASE]
	... 65 more
```

## 解决方法

* `BaseCRUDController` 类主要代码如下：

```java
/**
 * 基础CRUD 控制器
 */
public abstract class BaseCRUDController<E extends BaseEntity, ID extends Serializable> extends BaseController<E> {

    protected BaseService<E, ID> baseService;

    @Autowired
    public void setBaseService(BaseService<E, ID> baseService) {
        this.baseService = baseService;
    }

	// 以下忽略一些代码
}
```

* 在 `BaseCRUDController.setBaseService(BaseService<E, ID> baseService)` 方法处断点调试

![](http://7xkexv.dl1.z0.glb.clouddn.com/20170803/spring_debug1.png)

![](http://7xkexv.dl1.z0.glb.clouddn.com/20170803/spring_debug2.png)

* 断点调试发现在实例化 `PermissionController` 和 `UserController` 时，对应的 `Service` 都是可以正常注入的，但是当实例化 `UserLastOnlineController` 时，就出现了以上描述的异常。

Controller

```java
@Controller
@RequestMapping(value = "/admin/sys/permission/permission")
public class PermissionController extends BaseCRUDController<Permission, Long> {
}
```

```java
@Controller("adminUserController")
@RequestMapping(value = "/admin/sys/user")
public class UserController extends BaseCRUDController<User, Long> {
}
```

```java
@Controller
@RequestMapping(value = "/admin/sys/user/lastOnline")
public class UserLastOnlineController extends BaseCRUDController<UserLastOnline, Long> {
}

```

Service

```java
@Service
public class PermissionService extends BaseService<Permission, Long> {
}
```


```java
@Service
public class UserService extends BaseService<User, Long> {
}
```

```java
@Service
public class UserLastOnlineService extends BaseService<UserLastOnline, String> {
}
```

* 仔细比对 `Controller` 和 `Service` ，发现都只是简单的继承基础类，不过仔细观察，发现 `UserLastOnlineController` 和 `UserLastOnlineService` 中基类泛型中主键类型不同，然后将 `UserLastOnlineService` 中的主键类型修改为 `Long` 后，再调试就OK了

![](http://7xkexv.dl1.z0.glb.clouddn.com/20170803/spring_debug3.png)
