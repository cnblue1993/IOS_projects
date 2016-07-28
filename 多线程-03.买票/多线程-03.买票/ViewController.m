//
//  ViewController.m
//  多线程-03.买票
//
//  Created by anne on 16/7/21.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ViewController.h"
#import "Ticket.h"

@interface ViewController ()

@property (weak, nonatomic) UITextView *textView;

@property (strong, nonatomic) NSOperationQueue *queue;

@end


@implementation ViewController

#pragma mark 追加多行文本
- (void)appendContent:(NSString *)text{
    NSMutableString *str = [NSMutableString stringWithString:self.textView.text];
    [str appendFormat:@"%@\n",text];
    
    [self.textView setText:str];
    
    //NSRange range = NSMakeRange(str.length - 1, 1);
    //[self.textView scrollRangeToVisible:range];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    [textView setEditable:NO];
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    [Ticket sharedTicket].tickets = 30;
    //[self gcdSales];
    
    //self.queue = [[NSOperationQueue alloc]init];
    //[self operationSales];
    
    [self threadSales];
}

#pragma mark - NSTread
- (void)threadSales{
    [NSThread detachNewThreadSelector:@selector(threadSaleTicketsWithName:) toTarget:self withObject:@"thread-1"];
    [NSThread detachNewThreadSelector:@selector(threadSaleTicketsWithName:) toTarget:self withObject:@"thread-2"];
}

- (void)threadSaleTicketsWithName:(NSString *)name{
    @autoreleasepool {
        while (YES) {
            @synchronized(self) {
                if([Ticket sharedTicket].tickets > 0){
                    [Ticket sharedTicket].tickets--;
                    NSString *str = [NSString stringWithFormat:@"剩余票数：%ld,线程名:%@",(long)[Ticket sharedTicket].tickets,name];
                    [self performSelectorOnMainThread:@selector(appendContent:) withObject:str waitUntilDone:YES];
                }else{
                    //NSLog(@"票买完啦！！");
                    break;
                    
                }
            }
        }
    }
}

#pragma mark - NSOperation

- (void)operationSales{
    [self.queue setMaxConcurrentOperationCount:2];
    
    [self.queue addOperationWithBlock:^{
        [self operationSaleTicketsWithName:@"operation-1"];
    }];
    [self.queue addOperationWithBlock:^{
        [self operationSaleTicketsWithName:@"operation-2"];
    }];
    [self.queue addOperationWithBlock:^{
        [self operationSaleTicketsWithName:@"operation-3"];
    }];
}

- (void)operationSaleTicketsWithName:(NSString *)name{
    while (YES) {
        @synchronized(self) {
            if([Ticket sharedTicket].tickets > 0){
                [Ticket sharedTicket].tickets--;
                NSString *str = [NSString stringWithFormat:@"剩余票数：%ld,线程名:%@",(long)[Ticket sharedTicket].tickets,name];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self appendContent:str];
                }];
            }else{
                NSLog(@"票买完啦！！");
                break;
                
            }
        }
    }

}

#pragma mark - GCD
- (void)gcdSales{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [self gcdSaleTicketsWithName:@"gcd-1"];
            });
    dispatch_group_async(group, queue, ^{
        [self gcdSaleTicketsWithName:@"gcd-2"];
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"票卖完啦！！");
    });
    
}

- (void)gcdSaleTicketsWithName:(NSString *)name{
    while (YES) {
        @synchronized(self) {
            if([Ticket sharedTicket].tickets > 0){
                [Ticket sharedTicket].tickets--;
                NSString *str = [NSString stringWithFormat:@"剩余票数：%ld,线程名:%@",(long)[Ticket sharedTicket].tickets,name];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self appendContent:str];
                });
            }else{
                break;
                
            }
        }
    }

}


@end
