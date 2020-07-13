---
title: UITextFiled
---

`UITextField` 是只能输入一行的文本输入框，可用于账号、密码、标题等输入。

## 1. 常用样式

1. `Placeholder` : 设置提示用户的信息，字体颜色一般为浅灰色。
2. `Border Style` : 边框样式，一般使用 “有边框” 和 “无边框两种”。
3. `Clear Button` : 清除键，如果账号过长，就可以点击清除键立即去除。

## 2. 添加下划线

现在很常见的输入框是只有下划线，我们可以选择无边框，然后在输入框下方添加边框即可。

1. 创建一个继承 `UITextField` 的子类 `BaseTextField`。

2. 添加 `layer`

   ```objc
   CALayer *bottomBorder = [CALayer layer];
   bottomBorder.backgroundColor = [UIColor colorWithHexString:@"#efefef" alpha:1.0].CGColor;
   [self.layer addSublayer:bottomBorder];
   ```

3. 在合适的时机布局

   ```objc
   bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
   ```

   

   