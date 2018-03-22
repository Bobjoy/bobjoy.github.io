title: Java使用jsoup提取mht文件中图片
date: 2018-01-30 15:35:14
categories: ["编程开发"]
tags: ["Java", "Jsoup", "mht"]
---

## jsoup读取mht文件方法
```java
/**
 * 解析mht文件，包括提取图片
 */
@SuppressWarnings("unchecked")
private static String parseMhtToHtml(String fileName) throws Exception {

    // 读取文件内容
    List<String> lines = FileUtils.readLines(new File(fileName), "GBK");

    Map<String, Object> map = new HashMap<>();
    List<Map<String, Object>> list = new ArrayList<>();
    for (int i = 6; i < lines.size(); i++) {
        String line = lines.get(i).trim();

        if (line.startsWith("----boundary")) {
            map = new HashMap<>();
            map.put("headers", new HashMap<>());
            map.put("content", new ArrayList<>());
            list.add(map);
        }

        if (!line.startsWith("----boundary") && !"".equals(line)) {
            if (line.contains(":")) {
                String[] kv = line.split(":");
                ((Map<String, String>) map.get("headers")).put(kv[0], kv[1].trim());
            } else {
                ((List<String>) map.get("content")).add(line);
            }

        }
    }

    Map<String, String> resultMap = new HashMap<>();

    list.forEach(m -> {
        Map<String, String> headers = (Map<String, String>) m.get("headers");
        List<String> content = (List<String>) m.get("content");
        if (!headers.isEmpty() && !content.isEmpty()) {
            String cid = headers.get("Content-ID");
            String html = StringUtils.join(content, "");
            if (cid != null) {
                String prefix = "data:"+headers.get("Content-Type")+";"+headers.get("Content-Transfer-Encoding")+",";
                resultMap.put(cid.substring(1, cid.length()-1), prefix + html);
            } else {
                resultMap.put("html", html);
            }
        }
    });

    String html = new String(Base64.getDecoder().decode(resultMap.get("html")), "GBK");

    Pattern compile = Pattern.compile("cid:(\\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12})");
    Matcher matcher = compile.matcher(html);
    while (matcher.find()) {
        html = html.replaceAll(matcher.group(), resultMap.get(matcher.group(1)));
    }

    return html;
}

/**
 * 解析html(doc转html)到map中
 */
private static Map<String, Object> parseMhtToMap() {

    String html = parseMhtToHtml("/path/to/hmt/file");

    Document doc = Jsoup.parse(html);
    Element body = doc.body();

    // 基本信息 START
    Map<String, String> map = new HashMap<>();
    
    // 提取头像
    String image = body.select("img").attr("src");
    map.put(AVATAR, image);

    return map;
}

```


> 注意：在解析文件中，发现图片无法显示，最后分析原始html和经过jsoup解析的html（Jsoup.parse），发现BASE64图片图片长度不一致，导致无法再网页中显示，解决方法就是更新jsoup依赖版本，如下

> 
```
<dependency>
    <groupId>org.jsoup</groupId>
    <artifactId>jsoup</artifactId>
    <version>1.11.1</version>
</dependency>
```

> 改为：
> 
```
<dependency>
    <groupId>org.jsoup</groupId>
    <artifactId>jsoup</artifactId>
    <version>1.11.2</version>
</dependency>
```