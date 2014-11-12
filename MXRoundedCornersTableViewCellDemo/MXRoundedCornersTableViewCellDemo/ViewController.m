//
//  ViewController.m
//  MXRoundedCornersTableViewCellDemo
//
//  Created by Max Sokolov on 11/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "ViewController.h"
#import "MXRoundedCornersTableViewCell.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Demo";
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 30.0f;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 30.0f)];

    [self.tableView registerClass:[MXRoundedCornersTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0: return 1;
        case 1: return 2;
        case 2: return 3;
        case 3: return 1;
        case 4: return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MXRoundedCornersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"Happy coding!";

    cell.borderWidth = 1.0f;
    cell.edgeOffset = 10.0f;
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.borderColor = [UIColor redColor];
    cell.cellSeparatorColor = [UIColor redColor];
    cell.separatorEdgeInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);

    [cell configureRoundedCornersWithRowIndex:indexPath.row andNumberOfRowsInSection:[tableView numberOfRowsInSection:indexPath.section]];

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 30.0f)];
}

@end