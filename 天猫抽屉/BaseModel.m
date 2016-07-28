//
//  BaseModel.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.name = dict[@"name"];
        self.image = [UIImage imageNamed:dict[@"imageName"]];
    }
    return self;
}

@end
