---
title: Picker View
---

普通选择器的拨盘个数可以设定，每个拨盘的内容也可以设定。

## 添加控件

1. 拖拽 pickerview 到故事板，给控制器添加输出口属性，命名为 label
2. 拖拽标签到故事板，给控制器添加输出口属性，命名为 pickerview
3. 拖拽按钮到故事板，拖拽生成方法 onclick 到控制器
4. 手动创建新的 plist 文件，添加相应的省、市字段
5. 实现 onclick 方法，实现 plist 文件的读取
6. 选中 pickerView，右键，将委托协议拖拽给左栏控制器 View Controller，也就是委托给控制器实现
7. 选中 pickerView，右键，将数据源协议拖拽给左栏控制器 View Controller，也就是委托给控制器实现
8. 实现普通选择器的委托协议和数据源协议