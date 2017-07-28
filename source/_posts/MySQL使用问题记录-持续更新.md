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