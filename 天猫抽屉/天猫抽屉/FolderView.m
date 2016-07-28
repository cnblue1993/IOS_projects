//
//  FolderView.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "FolderView.h"
#import "ShopTypeCell.h"
#import "ShopListViewController.h"

#define kProductCellHeight 80
#define kSubViewHeight 200

typedef CGRect(^newFrame)(CGFloat up,CGFloat down,NSIndexPath *path,UITableViewCell *cell);

@interface FolderView()

@property (strong,nonatomic) NSMutableArray *animationRows;
@property (strong,nonatomic) ShopListViewController *shopListController;

@end

@implementation FolderView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        UIImage *image = [UIImage imageNamed:@"tmall_bg_furley.png"];
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
        [self setRowHeight:kProductCellHeight];
        [self setShowsVerticalScrollIndicator:NO];
        
        self.shopListController = [[ShopListViewController alloc]init];
    }
    return self;
}

- (void)openFolderAtIndexPath:(NSIndexPath *)indexPath shopList:(NSArray *)shopList{
    
    if(self.animationRows != nil){
        [self closeFolder];
        return;
    }
    
    [self.shopListController setShopList:shopList];
    [self.shopListController.tableView reloadData];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self indexPathsForVisibleRows]];
    self.animationRows = array;
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    CGFloat cellY = cell.frame.origin.y;
    CGFloat cellHeight = cell.frame.size.height;
    CGFloat tableHeight = self.frame.size.height;
    CGFloat subViewY = cellY + cellHeight;
    CGFloat offsetY = self.contentOffset.y;
    
    if(offsetY + tableHeight - subViewY >= kSubViewHeight){
        [self openFolderFromIndexPath:indexPath up:0 down:self.shopListController.view.frame.size.height newFrame:^CGRect(CGFloat up, CGFloat down,NSIndexPath *path,UITableViewCell *cell) {
            CGRect newFrame = cell.frame;
            if(path.row > indexPath.row){
                
                newFrame.origin.y += down;
            }
            return newFrame;
        }];
    }else{
        CGFloat up= tableHeight + offsetY - kSubViewHeight -subViewY;
        subViewY += up;
        CGFloat down = kSubViewHeight + up;
        [self openFolderFromIndexPath:indexPath up:up down:down newFrame:^CGRect(CGFloat up, CGFloat down, NSIndexPath *path, UITableViewCell *cell) {
                CGRect newFrame = cell.frame;
            if(path.row <= indexPath.row){
                newFrame.origin.y += up;
            }else{
                newFrame.origin.y +=down;
            }
            return newFrame;
        }];
    }
    CGRect subViewFrame = self.shopListController.view.frame;
    subViewFrame.origin.y = subViewY;
    [self.shopListController.view setFrame:subViewFrame];
    [self insertSubview:self.shopListController.view atIndex:0];
}

- (void)closeFolder{
    for(NSIndexPath *path in self.animationRows){
        ShopTypeCell *cell = (ShopTypeCell *)[self cellForRowAtIndexPath:path];
        
        CGRect closeFrame = cell.frame;
        closeFrame.origin.y = cell.originY;
        [cell setFrame:closeFrame];
    }
    self.animationRows = nil;
    [self.shopListController.view removeFromSuperview];
}

- (void)openFolderFromIndexPath:(NSIndexPath *)indexPath up:(CGFloat)up down:(CGFloat)down newFrame:(newFrame)newFrame{
    for(NSIndexPath *path in self.animationRows){
        ShopTypeCell *cell = (ShopTypeCell *)[self cellForRowAtIndexPath:path];
        cell.originY = cell.frame.origin.y;
        
        [cell setFrame:newFrame(up,down,path,cell)];
    }

}
@end
