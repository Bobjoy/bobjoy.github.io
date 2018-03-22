title: MySQL-筛选出每个人的时间最新的一条记录
date: 2018-03-22 11:12:56
categories: ["编程开发"]
tags: ["Database","MySQL"]
---

* 场景：

  查询每个学生最新的成绩记录

* 表结构

```
CREATE TABLE `student`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `no` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `score` decimal(3, 1) NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
)
```

* 表数据：

```
1	  600040407	王玲	80	2011-06-21 22:34:00
2	  600040407	王玲	56	2011-06-24 10:21:00
3	  600040407	王玲	64	2011-12-07 10:45:00
4	  600040407	王玲	84	2012-01-15 14:01:00
5	  600040407	王玲	62	2012-12-26 14:11:00
6	  600040408	魏武	58	2011-06-21 22:36:00
7	  600040408	魏武	75	2013-11-15 10:46:00
8	  600040408	魏武	68	2014-01-19 09:12:00
9	  600040408	魏武	99	2014-01-10 13:57:00
10	 600040408	魏武	73	2014-01-22 10:08:00
11	 600040435	于洋	86	2011-06-22 12:54:00
12	 600040435	于洋	77	2013-03-11 09:16:00
13	 600040435	于洋	68	2014-01-10 11:18:00
14	 600040435	于洋	88	2013-12-20 15:09:00
```

* SQL实现：

```sql
-- 方法1
select a.* from student a
where not exists(
  select 1 from student b
  where b.no=a.no and b.date>a.date
)

-- 方法2
select a.* from student a
inner join (
  select no,max(date) 'maxdate' from student 
  group by no
) b on a.no=b.no and a.date=b.maxdate

```

* 查询结果

```
5	 600040407	王玲	62	2012-12-26 14:11:00
10	600040408	魏武	73	2014-01-22 10:08:00
13	600040435	于洋	68	2014-01-10 11:18:00
```