//
//  TitleView.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        UIImage *bgImage = [UIImage imageNamed:@"images.bundle/background_2.png"];
        UIImageView *bg = [[UIImageView alloc]initWithImage:bgImage];
        [bg setFrame:self.frame];
        
        [self addSubview:bg];
        
        UIImage *titleImage = [UIImage imageNamed:@"images.bundle/BurstAircraftLogo.png"];
        UIImageView *titleView = [[UIImageView alloc]initWithImage:titleImage];
        [titleView setCenter:self.center];
        
        [self addSubview:titleView];
    }
    return self;
}
@end
