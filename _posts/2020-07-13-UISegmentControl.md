---
title: UISegmentControl
---

`UISegmentControl` 是分段控件，一般用来切换不同的模式。

**tip** : 分段控件在样式上是很不自由的，如果设计图上的分段控件和系统控件不符，建议使用多个 `UIButton`自定义实现。

## 1. 样式设置

主要是设置 “选中” 和 “未选中” 时的字体和背景颜色。

```objc
// 选中时背景色
[segmentControl setBackgroundImage:[UIColor imageWithColor:[UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

// 选中时字体颜色
[segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        
// 未选中时背景色
[segmentControl setBackgroundImage:[UIColor imageWithColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

// 未选中时字体颜色
[segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        
// 去掉中间的分割线
[segmentControl setDividerImage:[UIColor imageWithColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
```

其中，`imageWithColor` 是将颜色转为图片的方法，需要自己实现，可以参考 [UIColor 拓展](https://professordeng.com/ios/2020/07/13/UIColor.html)。

## 2. 分段控件局限性

1. 很难去掉圆角



