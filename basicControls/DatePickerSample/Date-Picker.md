---
title: Date Picker
---

## 添加控件

1. 拖拽一个 DatePicker 到故事板，其中属性包括
   - mode：设置日期时间到模式
   - locale：设置本地化，日期选择器会按照本地习惯和文字显示日期
   - interval：设定间隔时间，单位为分钟
   - date：设定开始时间
   - constraints：设定能显示的最大和最小日期
   - timer：在倒计时定时器模式下倒计时的秒数
2. 拖拽 DatePicker 到控制器生成输出口属性，命名为 datePicker
3. 拖拽一个按钮 uibutton 到故事板，拖拽方法到控制器，命名为 onclick
4. 拖拽一个标签 label 到故事板，拖拽生成输出口属性，命名为 label
5. 在 onclick 实现相应的方法