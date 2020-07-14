---
title: navigation
---

一个 iOS 有多个页面，页面之间的切换有多种方式，本文介绍我常用的导航方式。

## 1. 故事板 + 根控制器切换

有些页面是相对静态的页面，布局很少改动，且不复杂，这时候我会使用故事板构建页面，然后通过切换 **根控制器** 切换页面。

例如一个很常见的场景，我们使用 APP 都需要一个登录页面，但是登录后就很少使用登录页面了，此时可以通过切换根控制器切换到另一个页面，同时由于 ARC 原理，登录页面会被立即释放掉。代码如下：

```objc
// 获取故事板
UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

// 获取目标页面
NavigationController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(NavigationController.class)];

// 获取当前窗口
UIWindow *window = [UIApplication sharedApplication].keyWindow;

// 切换根视图控制器为目标页面
window.rootViewController = vc;
```



