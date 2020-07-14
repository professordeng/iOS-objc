---
title: UINavigationController
---

 `UINavigationController` 管理着一个存放视图控制器的栈和一个导航栏。正常情况下我们不会直接使用导航栏，而是选择使用导航控制器。

## 1. 样式

导航控制器的样式其实就是 `UISearchBar` 的样式。这里罗列了常用的几个样式：

```objc
// 去除 SearchBar 下方的黑线
navigationController.navigationBar.shadowImage = [UIImage new];

// 设置 SearchBar 的背景颜色
navigationController.navigationBar.barTintColor =  [UIColor redColor];

// 设置导航栏按钮的字体颜色
navigationController.navigationBar.tintColor = [UIColor greenColor];
```

## 2. 事件

