//
//  ViewController.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"
#import "TitleView.h"
#import "AirPlayGameViewController.h"

@interface ViewController ()

@property (weak, nonatomic) LoadingView *loadingView;
@property (weak, nonatomic) TitleView *titleView;

@property (strong, nonatomic) AirPlayGameViewController *gameController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:loadingView];
    self.loadingView = loadingView;
    
    [self performSelectorInBackground:@selector(loadResources) withObject:nil];
}

#pragma mark - 私有方法
#pragma mark 后台加载数据
- (void)loadResources{
    [NSThread sleepForTimeInterval:2.0f];
    NSLog(@"loading");
    self.gameController = [[AirPlayGameViewController alloc]init];
    [self.gameController loadResources];
    
    [self.loadingView removeFromSuperview];
    
    TitleView *titleView = [[TitleView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:titleView];
    
    self.titleView = titleView;
    [self performSelectorInBackground:@selector(beginGame) withObject:nil];
    
}

#pragma mark 进入游戏
- (void)beginGame{
    [NSThread sleepForTimeInterval:1.0f];
    
    [self.titleView removeFromSuperview];
    
    //self.gameController = [[AirPlayGameViewController alloc]init];
    [self.view addSubview:self.gameController.view];
}


@end
