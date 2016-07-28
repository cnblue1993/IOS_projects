//
//  ShopTypeCell.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ShopTypeCell.h"

@implementation ShopTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:
            reuseIdentifier];
    if(self){
        UIImage *image = [UIImage imageNamed:@"tmall_bg_main.png"];
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:image]];
         
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        
        [self.textLabel setFont:[UIFont systemFontOfSize:16]];
        [self.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
