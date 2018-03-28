title: Mybatis单个参数的if判断（针对异常：There is no getter for property..）
date: 2017-11-23 10:12:42
categories:
tags:
photos:
  - "https://images.pexels.com/photos/913179/pexels-photo-913179.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---
MyBatis在进行参数判断的时候，可以直接使用传入entity实体属性名或者map的键名，如下：

1. 常规代码

  ```xml
  <update id="update" parameterType="com.demo.entity.Test">
    UPDATE t_test
    <set>
      <if test="field1 != null">
        field1 = #{field1,jdbcType=VARCHAR},
      </if>
      <if test="field2 != null">
        field2 = #{field2,jdbcType=INTEGER},
      </if>
    </set>
    WHERE id = #{id,jdbcType=INTEGER}
  </update>
  ```

  * 但是单个参数和多参数的判断有个不同点，当我们的入参为entity实体，或者map的时候，使用 `if` 参数判断没任何问题。

  * 但是当我们的入参为 `java.lang.Integer` 或者 `java.lang.String` 的时候，这时候就需要注意一些事情了，代码如下：

2. 错误代码

  ```xml
  <select id="select" parameterType="java.lang.Integer" resultType="java.lang.Integer">
    SELECT field FROM t_test WHERE
    <if test="id != null">
      AND id = #{id}
    </if>
  </select>
  ```

  * 上述代码存在一些问题，首先入参是 `java.lang.Integer`，而不是map或者实体的入参方式，对于这类单个入参然后用 `if` 判断的，MyBatis有自己的内置对象

  * 如果你在 `if` 判断里面写的是你的入参的对象名，那就报异常：`Internal error : nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named 'langId' in 'class java.lang.Integer'`

3. 正确代码：

  ```xml
  <select id="select" parameterType="java.lang.Integer" resultType="java.lang.Integer">
    SELECT field FROM t_test WHERE
    <if test="_parameter != null">
      AND id = #{id,jdbcType=INTEGER}
    </if>
  </select>
  ```

  * 这里MyBatis有内置对象 `_parameter`，对于单个参数的传入和判断，必须用 `_parameter` 来处理，而不是传入对象名 `id`

  * 在使用传入参数时，需要加上参数对于数据库类型


> 参考：https://www.2cto.com/database/201505/401604.html
