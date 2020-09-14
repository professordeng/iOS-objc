---
title: LabelButton
---

## 添加组件

1. 拖一个标签进故事板
2. 拖一个按钮进故事板
3. 点击按钮，修改字为 ok
4. 点击标签，可以看到 label 和 view 两栏，label 是对自身而言，view 是对视图而言。
5. 点击按钮，在 view 栏可修改背景颜色（改成灰色），在 button 栏可修改按钮类型
6. 点击按钮，可在 button 栏勾选 shows touch on highlight（点击后会有光圈）

注意：UIKit 至少有两种按钮，一种是 UIButton 类型的普通按钮，一种是放在工具栏和导航栏中的 UIBarButtonItem，虽然可当按钮用，但是从类的继承上看，UIBarButtonItem 不是 UIView 的子类。

## 添加事件处理

事件可同样可通过拖拽实现，首先

1. 通过 File、new、editor 可打开另一个编辑器，这样就有两个编辑器并列，我们同时打开故事板和 viewcontroller.m 
2. 选中标签，按住 control，将标签拉到 viewcontroller.m 的类拓展中，命名为 label，其他默认
3. 选择按钮，按住 control，将按钮拉到 viewcontroller.m 的类实现中，命名为 onClick，其他默认
4. 拖拽事件可通过 IB 中的右上角的 “右箭头” 看到，例如按钮可以看到 touch up inside 连接到 view controller 的 onclick: 方法（在 sent events 栏），标签 label 可看到 label 链接到 view controller（在 referencing outlets 栏）

## 访问视图

由于标签变量已经映射到控制器，所以我们可以直接在控制器里修改标签到相关属性

1. 在 onClick 方法中修改标签的字为 HelloWorld