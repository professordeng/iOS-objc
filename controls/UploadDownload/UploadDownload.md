---
title: UploadDownload
---

## 活动指示器

活动指示器 ActivityIndicatorView 就是一个加载圈

1. 设置视图背景色为黑色，修改 background 为 dark text color
2. 拖一个活动指示器和按钮到故事板
3. 活动指示器到 style 改为 large white（另外，behavior 中的 animating 表示运行时控件会处于活动状态，hides when stopped 表示非活动状态时控件会被隐藏）
4. 拖拽活动指示器在 ViewController.m 中生成输出口属性 activityIndicatorView
5. 拖拽按钮实现动作方法 startToMove，实现相应代码

## 进度条

1. 拉取进度条 progress view 到故事板，设置 progress 为 0
2. 拉取按钮到故事板
3. 进度条的输出口属性 progressView
4. 拖拽实现按钮的响应方法 downloadProgress
5. 使用定时器模拟下载过程

