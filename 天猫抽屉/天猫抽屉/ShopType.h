//
//  ShopType.h
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "BaseModel.h"

@interface ShopType : BaseModel

@property (strong,nonatomic) NSArray *subShops;
@property (strong,nonatomic) NSString *detail;

+ (id)shopTypeWithDict:(NSDictionary *)dict;

@end
