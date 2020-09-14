---
title: NavigationBar
---

工具栏应用于当前界面，考虑的是局部界面；而导航栏主要用于导航，考虑的是整个应用。

## 添加组件

1. 拉取 NavigationBar 到视图顶部，不要遮挡状态栏（高度 20）
2. 修改 Navigation 的标题 title
3. 在 NavigationBar 左边放 save 按钮（类型为 Bar Button Item），右边放 add 按钮（类型为 Bar Button Item）
4. 拖拽按钮到 viewcontroller.m 生成对应的方法，save 按钮的方法名为 save，add 按钮的方法名为 add
5. 拉取 label 放到屏幕中央，输出口属性命名为 label

一般情况下，如果涉及导航栏，都是多界面的应用，本案例主要是关注导航栏和导航栏项目的用法