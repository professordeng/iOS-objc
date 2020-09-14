---
title: SwitchSliderSegmentControl
---

## 开关控件

1. 拖两个开关控件 Switch 到故事板
2. 将开关控件连接到 ViewController 输出口属性，分别命名为 leftSwitch 和 rightSwitch
3. 将两个控件的默认事件连线到 switchValueChange: 动作方法，实现同步代码

## 分段控件

1. 拖一个分段控件 Segment 到故事板
2. style 是属性，没啥区别随便选
3. segment 选择要设置的段，title设置段标题（双击更快），image 设置段图标
4. 按住 control，拖拽到 ViewController.m 生成事件，实现相关代码

## 滑块控件

1. 拖一个滑块控件 Slider 到故事板
2. 设置当前值 value 为 50，最小值 minimum 为 0，最大值 maximum 为 100（可以选择添加 min image 和 max image）
3. 添加两标签，一个命名为 sliderValue，命名为 50，水平并列在 slider 上方，将第二个标签输出到 viewcontroller.m
4. 拖拽滑块控件生成事件到 viewcontroller.m 中，实现响应代码