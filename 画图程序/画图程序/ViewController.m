//
//  ViewController.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ToolView.h"

@interface ViewController ()

@property (weak, nonatomic) DrawView *drawView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    ToolView *toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, 0, 320, 44) afterSelectColor:^(UIColor *color) {
        [drawView setDrawColor:color];
        NSLog(@"main");
    }afterSelectLineWidth:^(CGFloat lineWidth) {
        [drawView setLineWidth:lineWidth];
    }selectEarser:^{
        [drawView setDrawColor:[UIColor whiteColor]];
        [drawView setLineWidth:30.0];
    }selectUndo:^{
        [drawView undo];
    }selectClearScreen:^{
        [drawView clearScreen];
    }selectPhoto:^{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setDelegate:self];
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [self.view addSubview:toolView];
}

#pragma mark 图片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    [self.drawView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
