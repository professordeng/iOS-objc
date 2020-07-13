---
title: UIButton
---

`UIButton` 是 IOS 应用中的按钮，本文介绍 `UIButton` 的样式和事件处理。

## 1. 设置圆角

### 1.1 相同的圆角

如果同时将 `UIButton` 的 4 个圆角设置成相同的大小，那很简单，如下：

```objc
[button.layer setMasksToBounds:YES];
[button.layer setCornerRadius:8];
```

其中，`setMasksToBounds` 方法告诉 `layer` 将位于它之下的 `layer` 都遮盖住，这样圆角效果就不会被遮住。

此时按钮的圆角被设置成了 8pt。

**tip** : 如果你的按钮是在故事板中，可以在故事板中左栏 `Show the Identity inspector` - `User Defined Runtime Attributes` 设置按钮的圆角，其中 `Key Path` 为 `layer.cornerRadius`，`Type` 为 `Number`，`Value` 为 8。

### 1.2 设置部分圆角

可以使用 `UIBezierPath` （贝塞尔曲线）实现，`UIBezierPath` 允许你在自定义的 `View` 中绘制和渲染由直线和曲线组成的路径。

这里我们使用 `UIBezierPath` 来实现部分圆角，代码如下

```objc
// 指定左上、左下的圆角为 8
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                     cornerRadii:CGSizeMake(8, 8)];
// CAShapeLayer 是用来绘制三次贝塞尔样条曲线
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
maskLayer.frame = button.bounds;
maskLayer.path = maskPath.CGPath;
button.layer.mask = maskLayer;
```

## 2. 根据不同的状态变换样式

`UIButton` 属于控件，有能力响应一些高级事件，同时根据事件的不同转变状态，在很多场景中需要根据状态的不同变化样式。例如最常见的是 “可点击” 和 “不可点击” 两种状态，我们可以实现设置两种状态下按钮的样式，之后按钮会根据状态的不同切换样式。

 



