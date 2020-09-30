---
title: CustomCell
---

拉取文件 ”球队图片“ 和 team.plist 到项目中

## 添加组件

1. 删除故事板的 view controller
2. 拖拽一个 table view controller 到设计界面
3. 选择场景中的 table view controller，右上角属性检查器，选中 view controller 的 is initial view controller 复选框（会出现箭头）
4. 修改 ViewController.h 中的父类为 UITableViewController
5. 选中左栏的 view controller，打开标识检查器，在 class 下拉列表中选择 ViewController（也就是工程自带的 ViewController 类）
6. 选中单元格，设置属性检查器的 identifier 为 CellIdentifier

## 设计自定义单元格

1. 新建 CustomCell 类，父类为 UITableViewCell
2. 左栏选中单元格，在标识选择器中 class 选择 Customcell
3. 拖拽标签 uilabel、图片 imageview 到单元格，调整一下位置
4. 将标签输出口送到 CustomCell，命名为 name
5. 将图片输出口送到 CustomCell 类，命名为 image

## 实现表格视图协议

1. 告诉渲染器单元格的数量（numberOfRowsInSection）
2. 逐个渲染单元格（cellForRowAtIndexPath）

