title: Java 8新特性之旅：使用Stream API处理集合
date: 2015-09-16 08:40:58
categories:
tags: ["Java"]
---
在这篇“Java 8新特性教程”系列文章中，我们会深入解释，并通过代码来展示，如何通过流来遍历集合，如何从集合和数组来创建流，以及怎么聚合流的值。

在之前的文章“遍历、过滤、处理集合及使用Lambda表达式增强方法”中，我已经深入解释并演示了通过lambda表达式和方法引用来遍历集合，使用predicate接口来过滤集合，实现接口的默认方法，最后还演示了接口静态方法的实现。

源代码都在我的Github上：可以从[这里](https://github.com/mohamed-taman/JavaSE8-Features)克隆。

内容列表

* 使用流来遍历集合。
* 从集合或数组创建流。
* 聚合流中的值。
<!-- more -->
#### 1. 使用流来遍历集合

**简介：**

Java的集合框架，如`List`和`Map`接口及`Arraylist`和`HashMap`类，让我们很容易地管理有序和无序集合。集合框架自引入的第一天起就在 持续的改进。在Java SE 8中，我们可以通过流的API来管理、遍历和聚合集合。一个基于流的集合与输入输出流是不同的。

**如何工作？**

它采用一种全新的方式，将数据作为一个整体，而不是单独的个体来处理。当你使用流时，你不需要关心循环或遍历的细节。你可以直接从一个集合创建一个流。然 后你就能用这个流来许多事件了，如遍历、过滤及聚和。我将从项目 Java8Features 的 `com.tm.java8.features.stream.traversing`包下的例子开始。代码在一个`SequentialStream`类中，Java SE 8 中有两种集合流，即串行流和并行流。

```java
List<person> people = new ArrayList<>();
 
people.add(new Person("Mohamed", 69));
people.add(new Person("Doaa", 25));
people.add(new Person("Malik", 6));
 
Predicate<person> pred = (p) -> p.getAge() > 65;
 
displayPeople(people, pred);
 
...........
 
private static void displayPeople(List<person> people, Predicate<person> pred) {
 
     System.out.println("Selected:");
     people.forEach(p -> {
         if (pred.test(p)) {
             System.out.println(p.getName());
         }
     });
}
```
在这两种流中，串行流相对比较简单，它类似一个迭代器，每次处理集合中的一个元素。但是语法与以前不同。在这段代码中，我创建了 pepole 的数组列表，向上转型为List。它包含三个 Person 类的实例。然后我们使用 Predicate 声明一个条件，只有满足这个条件的 people 才会显示。在 displayPeople() 方法的48到52行循环遍历该集合，挨个测试其中的每一项。运行这段代码，你将获得如下的结果：

```
Selected:
Mohamed
```
我将会展示如何使用流来[重构](http://www.amazon.cn/gp/product/B003BY6PLK/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&tag=importnew-23&linkCode=as2&camp=536&creative=3200&creativeASIN=B003BY6PLK)这段代码。首先，我注释了这段代码。然后，在这段注释的代码下，我开始使用集合对象 people。然后我调用一个 stream() 方法。一个stream对象，类似集合，也要声明泛型。如果你从一个集合获取流，则该流中每一项的类型与集合本身是一致的。我的集合是 Person 类的实例，所以流中也使用同样的泛型类型。

```java
System.out.println("Selected:");
 //people.forEach(p -> {
 // if (pred.test(p)) {
 //     System.out.println(p.getName());
 // }
 //});
 
  people.stream().forEach(p -> System.out.println(p.getName()));
}
```
你可以调用一个`stream()`方法来获得了一个流对象，然后可以在该对象上进行一些操作。我简单地调用了`forEach`方法，该方法需要一个Lamda表达式。我在参数中传递了一个Lamda表达式。列表中的每一项就是通过迭代器处理的每一项。处理过程是通过Lambda 操作符和方法实现来完成的。我简单使用system output来输出每个人的名称。保存并运行这段代码，输出结果如下。因为没有过滤，所以输出了列表中所有元素。

```
Selected:
Mohamed
Doaa
Malik
```
现在，一旦有了一个流对象，就可以很容易使用`predicate`对象了。当使用`for each`方法处理每一项时，我不得不显示调用`predicate`的`test`方法，但是使用流时，你可以调用一个名为`filter`的方法。该方法接收一个`predicate`对象，所有的`predicate`对象都有一个`test`方法，所以它已经知道怎样去调用该方法。所以，我对该代码做一点改动。我将`.forEach()`方法下移了两行，然后在中间的空白行，我调用了`filter`方法。

```java
people.stream()
      .filter(pred)
      .forEach(p -> System.out.println(p.getName()));
```
`filter`方法接收一个`predicate`接口的实例对象。我将`predicate`对象传进去。`filtr`方法返回一个过滤后的流对象，在这个对象上我就可以去调用`forEach()`方法了。我运行这段代码，这次我只显示集合中满足预定义条件的项了。你可以在 流对象上做更多的事情。去看看 Java SE 8 API 中流的doc文档吧。

```
Selected:
Mohamed
```
你将会看到除了过滤，你还可以做聚合、排序等其他的事情。在我总结这段演示之前，我想向你们展示一下串行流和并行流之前的重要区别。Java SE 8 的一个重要目标就是改善多 CPU 系统的处理能力。Java 可在运行期自动协调多个 CPU 的运行。你需要做的所有事情仅仅是将串行流转换为并行流。

从语法上讲，有两种方法来实现流的转换。我复制一份串行流类。在包视图窗口，我复制并粘贴该类，然后对它重命名，ParallelStream，打开这个 新的类。在这个版本中，删除了注释的代码。我不再需要这些注释了。现在就可以通过两种方式创建并行流。第一种方式是调用集合中的 parallelStream()方法。现在我就拥有一个可以自动分配处理器的流了。

```java
private static void displayPeople(List<person> people, Predicate<person> pred) {
     System.out.println("Selected:");
     people.parallelStream()
           .filter(pred)
           .forEach(p -> System.out.println(p.getName()));
 }
```
运行这段代码，就可以看到完全一致的结果，过滤然后返回数据。

```
Selected:
Mohamed
```
第二种创建并行流的方式。再次调用 stream() 方法，然后在 stream 方法的基础上调用 parallel() 方法，其本质上做的事情是一样的。开始是一个串行的流，然后再将其转换为并行流。但是它仍然是一个流。可以过滤，可以用之前的一样方式去处理。只是现在的 流可以分解到多个处理起来处理。

```java
people.stream()
      .parallel()
      .filter(pred)
      .forEach(p -> System.out.println(p.getName()));
```

**总结**

现在还没有一个明确的规定来说明在什么情况下并行流优于串行流。这个依赖于数据的大小和复杂性以及硬件的处理能力。还有你运行的多 CPU 系统。我可以给你的唯一建议是测试你的应用和数据。建立一个基准的、计时的操作。然后分别使用串行流和并行流，看哪一个更适合于你。

#### 2. 从集合或数组创建流

**简介**

Java SE 8’s stream API 是为了帮助管理数据集合而设计的，这些对象是指集合框架中的对象，例如数组列表或哈希表。但是，你也可以直接从数组创建流。

**如何工作？**

在 Java8Features 项目中的`eg.com.tm.java8.features.stream.creating`包下，我创建了一个名为`ArrayToStream`的类。在这个类的`main`方法中，我创建了一个包含三个元素的数组。每个元素都是Person类的一个实例对象。

```java
public static void main(String args[]) {
 
    Person[] people = {
        new Person("Mohamed", 69),
        new Person("Doaa", 25),
        new Person("Malik", 6)
    };
    for (int i = 0; i < people.length; i++) {
        System.out.println(people[i].getInfo());
    }
}
```
该类中为私有成员创建了`setters`和`getters`方法，以及`getInfo()`方法，该方法返回一个拼接的字符串。

```java
public String getInfo() {
    return name + " (" + age + ")";
}
```
现在，如果想使用流来处理这个数组，你可能认为需要先将数组转为数组列表，然后从这个列表创建流。但是，实际上你可以有两种方式直接从数组创建流。第一方式，我不需要处理数据的那三行代码，所以先注释掉。然后，在这个下面，我声明一个流类型的对象。

Stream 是`java.util.stream`下的一个接口。当我按下*Ctrl+Space*并选取它的时候，会提示元素的泛型，这就是流管理的类型。在这里，元素的类型即为`Person`，与数组元素本身的类型是一致的。我将我新的流对象命名为 `stream`，所有的字母都是小写的。这就是第一种创建流的方法，使用流的接口，调用`of()`方法。注意，该方法存在两个不同版本。

第一个是需要单个对象，第二个是需要多个对象。我使用一个参数的方法，所以传递一个名为`people`的数组，这就是我需要做的所有事情。`Stream.of()`意思就是传入一个数组，然后将该数组包装在流中。现在，我就可以使用`lambda`表达式、过滤、方法引用等流对象的方法。我将调用流的`for each`方法，并传入一个`lambda`表达式，将当前的`person`对象和`lambda`操作符后传入后，就能获取到`person`对象的信息。该信息是通过对象的`getInfo()`方法获取到的。

```java
Person[] people = {
    new Person("Mohamed", 69),
    new Person("Doaa", 25),
    new Person("Malik", 6)
};

//for (int i = 0; i < people.length; i++) {
//  System.out.println(people[i].getInfo());
//}
Stream<Person> stream = Stream.of(people);
stream.forEach(p -> System.out.println(p.getInfo()));
``` 
保存并运行这段代码，就可获取到结果。输出的元素的顺序与我放入的顺序是一致的。这就是第一种方式：使用`Stream.of()`方法。

```
Mohamed (69)
Doaa (25)
Malik (6)
```
另一种方式与上面的方式实际上是相同的。复制上面的代码，并注释掉第一种方式。这次不使用`Stream.of()`方法，我们使用名为`Arrays`的类，该类位于`java.util`包下。在这个类上，可以调用名为`stream`的方法。注意，`stream`方法可以包装各种类型的数组，包括基本类型和复合类型。

```java
//Stream<person> stream = Stream.of(people);
Stream<person> stream = Arrays.stream(people);
stream.forEach(p -> System.out.println(p.getInfo()));
```
保存并运行上面的代码，流完成的事情与之前实质上是一致的。

```
Mohamed (69)
Doaa (25)
Malik (6)
```

**结论**

所以，无论是`Stream.of()`还是`Arrays.stream()`，所做的事情实质上是一样的。都是从一个基本类型或者复合对象类型的数组转换为流对象，然后就可以使用 lambda 表达式、过滤、方法引用等功能了。

#### 3. 聚合流的值

**简介**

之前，我已经描述过怎么使用一个流来迭代一个集合。你也可以使用流来聚合集合中的每一项。如计算总和、平均值、总数等等。当你做这些操作的时候，弄明白并行流特性就非常重要。

**如何工作？**

我会在 Java8Features 项目的`eg.com.tm.java8.features.stream.aggregating`包下进行演示。首先我们使用`ParallelStreams`类。在这个类的`main`方法中，我创建了一个包含字符串元素的数组列表。我简单地使用循环在列表中添加了10000个元素。然后在35和36行，我创建了一个流对象，并通过`for each`方法挨个输出流中每一项。

```java
public static void main(String args[]) {
 
    System.out.println("Creating list");
    List<string> strings = new ArrayList<>();
    for (int i = 0; i < 10000; i++) {
        strings.add("Item " + i);
    }
    strings.stream()
           .forEach(str -> System.out.println(str));
}
```
运行这段代码后，就获得了一个我所预期的结果。在屏幕上输出的顺序与添加到列表中的顺序是一致的。

```
.........
Item 9982
Item 9983
Item 9984
Item 9985
Item 9986
Item 9987
Item 9988
Item 9989
Item 9990
Item 9991
Item 9992
Item 9993
Item 9994
Item 9995
Item 9996
Item 9997
Item 9998
Item 9999
```
现在，让我们看一下当转换成并行流后会发生什么。正如我之前所描述的，我即可以调用`parallelStream`方法，也可以在流上调用`parallel`方法。

我将采用第二种方法。现在，我就可以使用并行流了，该流可以根据负载分配到多个处理器来处理。

```java
strings.stream()
       .parallel()
       .forEach(str -> System.out.println(str));
```
再次运行该段代码，然后观察会发生什么。注意，现在最后打印的元素不是列表中最后一个元素，最后一个元素应该是9999。如果我滚动输出结果，就能发现处理过程以某种方式在循环跳动。这是因为在运行时将数据划分成了多个块。

```
.........
Item 5292
Item 5293
Item 5294
Item 5295
Item 5296
Item 5297
Item 5298
Item 5299
Item 5300
Item 5301
Item 5302
Item 5303
Item 5304
Item 5305
Item 5306
Item 5307
Item 5308
Item 5309
Item 5310
Item 5311
```
然后，将数据块分配给合适的处理器去处理。只有当所有块都处理完成了，才会执行之后的代码。本质上讲，这是在调用`forEach()`方法时，将整个过程是根据需要来进行划分了。现在，这么做可能会提高性能，也可能不会。这依赖于数据集的大小以及你硬件的性能。通过这个例子，也可以看 出，如果需要按照添加的顺序挨个处理每一项，那么并行流可能就不合适了。

串行流能保证每次运行的顺序是一致的。但并行流，从定义上讲，是一种更有效率的方式。所以并行流在聚合操作的时候非常有效。很适合将集合作为一个整体考虑，然后在该集合上进行一些聚合操作的情况。我将会通过一个例子来演示集合元素的计数、求平均值及求和操作。

我们在这个类的`main`方法中来计数，开始还是用相同的基础代码。创建10,000个字符串的列表。然后通过一个`for each`方法循环处理每一项。

```java
public static void main(String args[]) {
 
    System.out.println("Creating list");
    List<string> strings = new ArrayList<>();
    for (int i = 0; i < 10000; i++) {
        strings.add("Item " + i);
    }
    strings.stream()
           .forEach(str -> System.out.println(str));
}
```
在这个例子中，我想直接对集合元素进行计数，而不是挨个来处理。所以，我注释掉原来的代码，使用下面的代码。因为不能准确的知道该集合到底有多少个元素。所以我使用长整型变量来存储结果。

我将这个变量命名为`count`，通过调用集合`strings`的`.stream()`,`.count()`方法，返回一个长整型的值。然后将这个值与“count:”拼接起来，再通过system的output来打印。

```java
//strings.stream()
//       .forEach(str -> System.out.println(str));
long count = strings.stream().count();
System.out.println("Count: " + count);
```
保存并运行该段代码，下面是输出结果。集合中元素数量的统计几乎是瞬间完成。

```
Creating list
Count: 10000
```
现在对上面的代码做一点小小的改动，增加两个0。现在，开始处理1000,000个字符串。我再次运行这段代码，也很快就返回结果了。

```
Creating list
Count: 1000000
```
现在，我使用并行流来处理，看会发生什么。我在下面增加 parallel 方法：

```java
//strings.stream()
//       .forEach(str -> System.out.println(str));
long count = strings.stream().parallel().count();
System.out.println("Count: " + count);
```
然后我运行这段代码，发现花费的时间更长一点了。现在，我做一个基准测试，通过抓取操作前后的时间戳来观察发生了什么。然后做一点数学的事情。不同的系统 上，得到的结果可能不同。但是根据我的经验来说，这种包含简单类型的简单集合，使用并行流并没有太多的优势。不过，我还是鼓励你去自己做基准测试，虽然有 点麻烦。 不过这也要你是如何去做的。

再让我们看一下求和及求均值。我将使用`SumAndAverage`类。这次，我有一个包含三个`person`对象的列表，每个`person`对象的有不同的年龄值。我的目的是求三个年龄的和及年龄的平均值。我在所有的`person`对象都加入到列表之后加入了一行新的代码。然后，我创建了一个名为`sum`的整型变量。

首先，我通过`pepole.stream()`方法获取一个流。在这个流基础上，我可以调用`mapToInt()`方法。注意，还有两个类似的`Map Method：mapToDouble()`和`mapToLong()`。这些方法的目的就是，从复合类型中获取简单的基本类型数据，创建流对象。你可以用 lambda 表达式来完成这项工作。所以，我选择`mapToInt()`方法，因为每个人的年龄都是整数。

关于 Lambda 表达式，开始是一个代表当前`person`的变量。然后，通过 Lambda 操作符和 Lambda 表达式（`p.getAge()`）返回一个整数。这种返回值，我们有时也叫做`int`字符串。也可以返回`double`字符串或其它类型。现在，由于已经知道它 是一个数字类型的值，所以我可以调用`sum()`方法。现在，我就已经将所有集合中`person`对象的年龄值全部加起来了。通过一条语句，我就可以用`System Output`来输出结果了。我将求和的结果与“Total of ages”连接在一起输出。

```java
List<person> people = new ArrayList<>();
people.add(new Person("Mohamed", 69));
people.add(new Person("Doaa", 25));
people.add(new Person("Malik", 6));
 
int sum = people.stream()
                .mapToInt(p -> p.getAge())
                .sum();
System.out.println("Total of ages " + sum);
```
保存并运行上面的代码。三个年龄的总和是100。

```
Total of ages 100
```
求这些值的平均值非常类似。但是，求平均值需要做除法操作，所以需要考虑除数为0的问题，因此，当你求平均值的时候，可以返回一个`Optional`的变量。

你可以使用多种数据类型。在计算平均值的时候，我想获得一个`double`类型的值。所以，我创建了一个`OptionalDouble`类型的变量。注意，还存在`Optional Int`和`Optional Long`。我将平均值命名为`avg`，使用的代码与求和的代码也是一致的，开始用`people.stream()`。在这个基础上，再次使用`mapToInt()`。并且传递了相同的 lambda 表达式，最后，调用`average`方法。

现在，获得了一个`OptionalDouble`类型的变量。在处理这个变量前，你可以通过`isPresent()`来确保它确实是一个`double`值。所以，我使用了一段 if/else 的模板代码来处理。判定的条件是`avg.isPresent()`。如果条件为真，就使用`System Output`输出“Average”标签和平均值。在`else`子句中，我简单地打印“average wasn’t calculated”。

```java
OptionalDouble avg = people.stream()
                           .mapToInt(p -> p.getAge())
                           .average();
if (avg.isPresent()) {
    System.out.println("Average: " + avg);
} else {
    System.out.println("average wasn't calculated");
}
```
现在，在这个例子中，我知道能成功，因为我给三个人的年龄都赋值了。但是，情况不总是这样的。正如我前面说的，存在除0的情况，这时你就不能获取到一个`double`类型返回值。我保存并运行这段代码，请注意`optional double`类，它是一个复合对象。

```
Total of ages 100
Average: OptionalDouble[33.333333333333336]
```
所以，真实的值被包含在该类型中，回到这段代码，直接引用该对象，并调用`getAsDouble()`方法。

```java
if (avg.isPresent()) {
    System.out.println("Average: " + avg.getAsDouble());
} else {
    System.out.println("average wasn't calculated");
}
```
现在，我就可以获得`double`类型的值。我再次运行这段代码，输出结果如下：

```
Total of ages 100
Average: 33.333333333333336
```

**结论**

通过流和 lambda 表达式，你可以用非常非常少的代码就可以完成集合的聚合计算。

原文链接： [javacodegeeks][1] 翻译： [ImportNew.com][2] - [paddx][3]  
译文链接： [http://www.importnew.com/16545.html][4]

[1]:http://www.javacodegeeks.com/2015/07/java-se-8-new-features-tour-processing-collections-with-streams-api.html
[2]:http://www.importnew.com/
[3]:http://www.importnew.com/author/paddx
[4]:http://www.importnew.com/16545.html