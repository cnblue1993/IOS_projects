//
//  Shop.h
//  天猫抽屉
//
//  Created by anne on 16/4/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "BaseModel.h"

@interface Shop : BaseModel

@property (strong,nonatomic) NSString *classId;

+ (id)shopWithDict:(NSDictionary *)dict;
@end
