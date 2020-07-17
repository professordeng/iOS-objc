---
title: UITableViewController
---

表格视图是 iOS 最复杂的视图之一。

## 1. 数据源协议

我们需要为表格视图提供数据，包括：

1. 表格的组个数

   ```objc
   - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 2;
   }
   ```

2. 组内单元格个数

   ```objc
   - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       if (section == 0) {
           return 1;
       } else if (section == 1) {
           return 2;
       }
       return 0;
   }
   ```

3. 单元格设置

   ```objc
   - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       
       return cell;
   }
   ```

4. 单元格高度设置。

   该方法的高度设置是在单元格渲染之前，如果你有渲染单元格里的内容后再确定单元格的需求，则需要找其他方法。

   ```objc
   - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return 44;
   }
   ```

5. 设置每个组的标题。

   ```objc
   - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
       return [NSString stringWithFormat:@"组 %ld", (long)section];
   }
   ```

