# MXRoundedCornersTableViewCell

Under development

#### Usage

Simply subclass MXRoundedCornersTableViewCell or use MXRoundedCornersTableViewCell directly.

#### Example usage

``` objc
MXRoundedCornersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

cell.borderWidth = 1.0f;
cell.edgeOffset = 10.0f;
cell.backgroundColor = [UIColor lightGrayColor];
cell.borderColor = [UIColor redColor];
cell.cellSeparatorColor = [UIColor redColor];
cell.separatorEdgeInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);

[cell configureRoundedCornersWithRowIndex:indexPath.row andNumberOfRowsInSection:[tableView numberOfRowsInSection:indexPath.section]];
```

## License

MIT license.