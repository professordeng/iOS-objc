---
title: UITableViewController
---

## 添加组件

1. 删除故事板的 view controller
2. 拖拽一个 table view controller 到设计界面
3. 选择场景中的 table view controller，右上角属性检查器，选中 view controller 的 is initial view controller 复选框（会出现箭头）
4. 修改 ViewController.h 中的父类为 UITableViewController
5. 选中左栏的 view controller，打开标识检查器，在 class 下拉列表中选择 ViewController（也就是工程自带的 ViewController 类）
6. 选中单元格，设置属性检查器的 identifier 为 CellIdentifier
7. 实现相应的代码（由于根视图就是表格视图控制器，所以不需要拖拽连接委托协议和数据源协议）