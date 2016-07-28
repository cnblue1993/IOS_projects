//
//  BaseModel.h
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseModel : NSObject

@property (strong,nonatomic) NSString *imageName;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) UIImage *image;


- (id)initWithDict:(NSDictionary *)dict;
@end
