//
//  ViewController.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ViewController.h"
#import "FolderView.h"
#import "ShopType.h"
#import "ShopTypeCell.h"

static NSString *CellIdentifier = @"MyCell";

@interface ViewController ()

@property (strong,nonatomic) NSArray *dataList;

@end

@implementation ViewController


- (void)loadView{
    self.tableView = [[FolderView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    
    [self.tableView registerClass:[ShopTypeCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - 初始化数据
- (void)loadData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"shops.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for(NSDictionary *dict in array){
        ShopType *shopType = [ShopType shopTypeWithDict:dict];
        [arrayM addObject:shopType];
    }
    self.dataList = arrayM;
}

#pragma mark - tableView数据源方法
#pragma mark 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}
#pragma mark 设置单元格信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //TUDO:设置单元格内容
    ShopType *shopType = self.dataList[indexPath.row];
    [cell.textLabel setText:shopType.name];
    [cell.detailTextLabel setText:shopType.detail];
    [cell.imageView setImage:shopType.image];
    return cell;
}

#pragma mark - tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FolderView *folder = (FolderView *)tableView;
    
    ShopType *shopType = self.dataList[indexPath.row];
    
    [folder openFolderAtIndexPath:indexPath shopList:shopType.subShops];
}


@end
