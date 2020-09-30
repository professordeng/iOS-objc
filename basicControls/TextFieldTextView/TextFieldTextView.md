---
title: TextField、TextView
---

## 添加控件

1. 拖两个标签到合适的位置，命名为 `Name:` 和 `Abstract:`
2. 在 `name:` 标签下放一个 UITextField
3. 设置 placeholder，clear button 设置为 is always visible
4. 拖拽 UITextView 到合适的位置
5. 选中 UITextField，右键，然后按住 delegate，将其拖拽到左边的 View Controller Scene 栏下的 view controller
6. 选中 UITextView，右键，然后按住 delegate，将其拖拽到左边的 View Controller Scene 栏下的 view controller

然后可以在 view controller 中实现对应的协议。

## 添加委托协议实现

1. 类拓展加上 TextField 和 TextView 的协议声明
2. 实现相应的协议，详情看 ViewContoller.m

## 键盘事件处理

看代码的委托协议和通知处理

## 键盘的种类

1. 打开有输入动作的属性检查器（例如 UITextField）
2. 尝试不同的 Keyboard Type（例如 phone pad）
3. 尝试不同的 Return Type（例如 go）