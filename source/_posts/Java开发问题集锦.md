title: Java开发问题集锦
date: 2018-01-09 09:33:41
categories: ["编程开发"]
tags: ["Java"]
photos:
  - "https://images.pexels.com/photos/756086/pexels-photo-756086.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

## Failed to load class "org.slf4j.impl.StaticLoggerBinder"

### 问题描述

```
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
```

### 解决办法

```
<dependency>
   <groupId>org.slf4j</groupId>
   <artifactId>slf4j-api</artifactId>
   <version>1.7.5</version>
</dependency>
<dependency>
   <groupId>org.slf4j</groupId>
   <artifactId>slf4j-simple</artifactId>
   <version>1.7.5</version>
</dependency>
```
