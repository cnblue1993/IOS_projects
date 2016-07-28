//
//  Shop.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (id)shopWithDict:(NSDictionary *)dict{
    Shop *s = [[Shop alloc]initWithDict:dict];
    s.classId = dict[@"classID"];
    return s;
}

@end
