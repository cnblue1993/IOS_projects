//
//  FolderView.h
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderView : UITableView

- (void)openFolderAtIndexPath:(NSIndexPath *)indexPath shopList:(NSArray *)shopList;

@end
