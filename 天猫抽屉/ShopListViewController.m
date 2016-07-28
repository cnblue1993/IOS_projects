//
//  ShopListViewController.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ShopListViewController.h"
#import "Shop.h"

@interface ShopListViewController ()

@end

@implementation ShopListViewController

#pragma mark - 实例化视图
- (void)loadView{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 200) style:UITableViewStylePlain];
}

#pragma mark - tableView数据源方法
#pragma mark 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopList.count;
}
#pragma mark 设置单元格信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //TUDO:设置单元格内容
    Shop *s = self.shopList[indexPath.row];
    [cell.textLabel setText:s.name];
    [cell.imageView setImage:s.image];
    
    return cell;
}


@end
