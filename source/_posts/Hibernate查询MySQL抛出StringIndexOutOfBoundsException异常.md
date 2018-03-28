title: Hibernate查询MySQL抛出StringIndexOutOfBoundsException异常
date: 2017-06-28 16:08:31
categories: ['Java']
tags: ['Java']
photos:
  - "https://images.pexels.com/photos/940543/pexels-photo-940543.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

## 问题排查
1. 查看数据表中是否有类型为char的字段A；
2. 检查是否存在该字段A为空的记录；

## 处理方法
1. 将该字段A为空的记录删除或者填充数据；
2. 将char类型转换为varchar，比如：`select CONCAT(c, '') str from demo`；

## 问题原因
1. MySQL中char为固定长度，不能为空；
2. Hibernate中 `org.hibernate.type.descriptor.java.CharacterTypeDescriptor` 将char类型转换为java中的类型，会截取第一个字符 `Character.valueOf(str.charAt(0))` ，如果为空，则会出现下标越界 `StringIndexOutOfBoundsException`
    ```java
    public <X> Character wrap(X value, WrapperOptions options) {
        if(value == null) {
            return null;
        } else if(Character.class.isInstance(value)) {
            return (Character)value;
        } else if(String.class.isInstance(value)) {
            String str = (String)value;
            return Character.valueOf(str.charAt(0));
        } else if(Number.class.isInstance(value)) {
            Number nbr = (Number)value;
            return Character.valueOf((char)nbr.shortValue());
        } else {
            throw this.unknownWrap(value.getClass());
        }
    }
    ```

