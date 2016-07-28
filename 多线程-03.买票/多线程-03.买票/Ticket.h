//
//  Ticket.h
//  多线程-03.买票
//
//  Created by anne on 16/7/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (assign, atomic) NSInteger tickets;

+ (Ticket *)sharedTicket;

@end
