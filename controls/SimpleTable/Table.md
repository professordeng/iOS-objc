---
title: Table
---

## 添加组件

1. 拉拽一个表视图 table view 到故事板，覆盖整个可视范围
2. 选中表视图，打开表视图属性检查器，设置 prototype cells 为 1（不要添加多个，会发生错误）
3. 选择 view controller scene 中的 table view cell（表视图单元格），打开其属性检查器，其中 style 属性用于设置单元格样式，而 Identifier 属性指可重用单元格的标识符，这里设置为 CellIdentifier
4. 对表视图右键，将数据源协议和委托协议拉到 view controller 中。
5. 代码实现相应协议