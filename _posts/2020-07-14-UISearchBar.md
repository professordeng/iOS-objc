---
title: UISearchBar
---

`UISearchBar` 是 iOS 提供的搜索栏，可以用来学习如果自己搭建搜索栏（在公司一般都是要自己实现更自由的搜索栏，所以别想直接套用了）。

这里讲讲搜索栏的样式和方法。

## 1. 结构

搜索框一般包括两部分：搜索框和右侧按钮。我们有两种办法可以看 `UISearchBar` 的结构：通过源文件或 `Debug View Hierarchy`。

查看源文件可知，搜索栏继承自 `UIView`，搜索框其实就是 `UITextField`，取消按钮是 `UIButton`，得知了这三个东西，完全可以自定义。

## 2. 样式

系统的搜索栏有那么一点点的样式可以自定义，这里总结一些常用的。

1. 去除边框

   ```objc
   searchBar.backgroundImage = [UIImage new];
   ```

2. 设置按钮的文字

   ```objc
   [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
   ```

   这段代码作用范围太广，本人并不推荐（但是没有找到更好的方案）。

## 3. 协议

`UISearchBar` 提供了一些常用的协议（自己实现其实也不难）。

```objc
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始编辑搜索框");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"文本发生改变");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击取消按钮");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击键盘中的搜索按钮");
}
```



