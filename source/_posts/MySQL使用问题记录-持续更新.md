title: MySQL使用问题记录(持续更新)
date: 2017-07-28 16:01:09
categories: ['MySQl']
tags: ['MySQl']
---
## SQL语句中delete语句中别名引发的问题

1. SQL语句

  ```sql
  DELETE FROM sys_auth t WHERE t.id=1
  ```

2. 错误提示

  ```
  [42000][1064] You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 't where t.id=111' at line 1
  ```

3. 解决方法

  ```sql
  DELETE FROM sys_auth WHERE id=1
  ```

  或者

  ```sql
  DELETE t FROM sys_auth t WHERE t.id=1
```

4. 问题原因

  别名使用姿势不对

  > [MySQL5.6参考手册](https://dev.mysql.com/doc/refman/5.6/en/delete.html)
  >
  > ![](http://7xkexv.dl1.z0.glb.clouddn.com/20170728/mysql_delete_alias.png)


## Sonar报错问题处理


* 错误描述

  ```
  ERROR: Error during SonarQube Scanner execution
  
  ERROR: Failed to upload report - 500: An error has occurred. Please contact your administrator
  ```

* 问题原因：mysql参数设置问题

  - 检查mysql参数：
  ```shell
  mysql> SHOW VARIABLES LIKE 'max_allowed_packet';
  ```

  - 修改/etc/my.cnf文件：
  ```ini
  max_allowed_packet = 50M
  ```

## 无法删除数据库 ERROR 1010 (HY000)

在做数据库删除时出现这种提示，其原因是在database下面含有自己放进去的文件，譬如*.txt文件或*.sql文件等，只要进去把这个文件删了在执行

```
drop database database_name;
```