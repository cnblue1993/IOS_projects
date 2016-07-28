//
//  Ticket.m
//  多线程-03.买票
//
//  Created by anne on 16/7/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "Ticket.h"

/*
 单例模型
 1.使用全局静态变量记录第一个实例化对象
 2.重写allocwithzone方法，并使用dispatch_once，保证在多线程情况下只有一个实例
 3.建立一个以shared开头的类方法实例化对象
 */

static Ticket *SharedInstance; //单例对象

@implementation Ticket



+ (id)allocWithZone:(struct _NSZone *)zone{
    
//    if(SharedInstance == nil){  //只适用于单线程
//        SharedInstance = [super allocWithZone:zone];
//    }
    
    //适用于多线程
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [super allocWithZone:zone];
    });
    
    return SharedInstance;
}

+ (Ticket *)sharedTicket{
    
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        SharedInstance = [[Ticket alloc] init];
    });
    return SharedInstance;
}

@end
