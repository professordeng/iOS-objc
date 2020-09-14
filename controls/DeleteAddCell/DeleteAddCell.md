---
title: DeleteAddCell
---

实现单元格的增删

## 添加组件

1. 删除故事板的 view controller
2. 拖拽一个  navigation view controller 到设计界面
3. 选择场景中的  navigation controller，右上角属性检查器，选中 view controller 的 `is initial view controller` 选项（图会出现箭头）
4. 修改 ViewController.h 中的父类为 UITableViewController
5. 选中左栏的 root view controller，打开标识检查器，在 class 下拉列表中选择 ViewController（也就是工程自带的 ViewController 类）
6. 选中单元格，设置属性检查器的 identifier 为 CellIdentifier

## 添加 TextField

1. 拉拽一个 TextField 到 Root View Controller Scene 栏下
2.  将 textfield 输出口属性到 viewcontroller.m
3. 设置 textfield 到字体大小，设置 placeholder 为 add...

## 事件处理

接下来全都是代码了

1. 表视图显示相关协议实现
2. 进入编辑状态实现
3. 不同单元格中编辑状态下的按钮风格实现
4. 删除插入实现
5. 最后一行不高亮实现（用于编辑状态下添加数据）
6. textField 委托协议实现



