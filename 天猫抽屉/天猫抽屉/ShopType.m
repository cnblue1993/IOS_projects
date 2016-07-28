//
//  ShopType.m
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ShopType.h"
#import "Shop.h"

@implementation ShopType

+ (id)shopTypeWithDict:(NSDictionary *)dict{
    ShopType *st = [[ShopType alloc]initWithDict:dict];
    
    NSArray *array = dict[@"subClass"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableString *strM = [NSMutableString string];
    
//    NSInteger i = 0;
//    for(NSDictionary *dict in array){
//        Shop *shop = [Shop shopWithDict:dict];
//        [arrayM addObject:shop];
//        if(i < 3)
//            [strM appendFormat:@"%@/",shop.name];
//        else if(i == 3){
//            [strM appendString:shop.name];
//        }
//        i++;
//    }
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Shop *shop = [Shop shopWithDict:obj];
        [arrayM addObject:shop];
        if(idx < 3)
            [strM appendFormat:@"%@/",shop.name];
        else if(idx == 3){
            [strM appendString:shop.name];
        }
    }];
    
    st.subShops = arrayM;
    st.detail = strM;
    return st;
}

@end
