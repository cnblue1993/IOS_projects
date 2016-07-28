//
//  ToolView.m
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ToolView.h"
#import "MyButton.h"


#define kButtonSpace 10.0

typedef enum{
    kButtonColor = 0,
    kButtonLineWidth,
    kButtonEarser,
    kButtonUndo,
    kButtonClearScreen,
    kButtonCamera,
    kButtonSave
} kButtonActionType;

@interface ToolView()
{
    SelectColorBlock _selectColorBlock;
    SelectLineWidthBlock _selectLineWidthBlock;
    ToolViewActionBlock _selectEarserBlock;
    ToolViewActionBlock _selectUndoBlock;
    ToolViewActionBlock _selectClearScreenBlock;
    ToolViewActionBlock _selectPhotoBlock;
}

@property (weak, nonatomic) MyButton *selectButton;
@property (weak, nonatomic) SelectColorView *colorView;
@property (weak, nonatomic) SelectLineWidthView *LineWidthView;

@end

@implementation ToolView

- (id)initWithFrame:(CGRect)frame
   afterSelectColor:(SelectColorBlock)afterSelectColor
afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth
       selectEarser:(ToolViewActionBlock)selectEarser
         selectUndo:(ToolViewActionBlock)selectUndo
  selectClearScreen:(ToolViewActionBlock)selectClearScreen
        selectPhoto:(ToolViewActionBlock)selectPhoto{
    self = [super initWithFrame:frame];
    if(self){
        _selectColorBlock = afterSelectColor;
        _selectLineWidthBlock = afterSelectLineWidth;
        _selectEarserBlock = selectEarser;
        _selectUndoBlock = selectUndo;
        _selectClearScreenBlock = selectClearScreen;
        _selectPhotoBlock = selectPhoto;
        
        [self setBackgroundColor:[UIColor lightGrayColor]]
        ;NSArray *array = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏",@"相机",@"保存"];
        [self createButtonsWithArray:array];
    }
    return self;
}


#pragma mark - 创建工具视图中的按钮
- (void)createButtonsWithArray:(NSArray *)array{
    NSInteger count = array.count;
    CGFloat width = (self.bounds.size.width - (count + 1) * kButtonSpace) / count;
    CGFloat heith = self.bounds.size.height;
    
    NSInteger i = 0;
    for (NSString *text in array){
        
        MyButton *button = [MyButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat startX = kButtonSpace + i * (kButtonSpace + width);
        
        [button setFrame:CGRectMake(startX, 8, width, heith - 16)];
        [button setTitle:text forState:UIControlStateNormal];
        [button setTag:i];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //[button setSelectedMyButton:YES];
    
        [self addSubview:button];
        i++;
    }
}

#pragma mark 按钮监听方法
- (void)tapButton:(MyButton *)button{
    if(self.selectButton != nil && self.selectButton != button){
        [self.selectButton setSelectedMyButton:NO];
    }
    [button setSelectedMyButton:YES];
    self.selectButton = button;
    switch (button.tag) {
        case kButtonColor:
            [self forceHideView:self.colorView];
            [self showHideColorView];
            break;
        case kButtonLineWidth:
            [self forceHideView:self.LineWidthView];
            [self showHideLineWidthView];
            break;
        case kButtonEarser:
            _selectEarserBlock();
            [self forceHideView:nil];
            break;
        case kButtonUndo:
            _selectUndoBlock();
            [self forceHideView:nil];
            break;
        case kButtonClearScreen:
            _selectClearScreenBlock();
            [self forceHideView:nil];
            break;
        case kButtonCamera:
            _selectPhotoBlock();
            [self forceHideView:nil];
            break;
        case kButtonSave:
            [self forceHideView:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - 子视图操作方法
#pragma mark 强行隐藏当前显示的子视图
- (void)forceHideView:(UIView *)compareView{
    UIView *view = nil;
    if(self.colorView.frame.origin.y > 0){
        view = self.colorView;
    }else if(self.LineWidthView.frame.origin.y > 0){
        view = self.LineWidthView;
    }else{
        return;
    }
    if(compareView == view)
        return;
    
    CGRect toFrame = view.frame;
    CGRect toolFrame = self.frame;
   
    toFrame.origin.y = -44;
    toolFrame.size.height = 44;
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:toolFrame];
        [view setFrame:toFrame];
    }];
    
}
#pragma mark 显示隐藏指定视图
- (void)showHideView:(UIView *)view{
    CGRect toFrame = view.frame;
    CGRect toolFrame = self.frame;
    if(toFrame.origin.y < 0){
        toFrame.origin.y = 44;
        toolFrame.size.height = 88;
    }else{
        toFrame.origin.y = -44;
        toolFrame.size.height = 44;
    }
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:toolFrame];
        [view setFrame:toFrame];
    }];
}
#pragma mark 显示隐藏颜色视图
- (void)showHideColorView{
    if(self.colorView == nil){
        SelectColorView *view = [[SelectColorView alloc]initWithFrame:CGRectMake(0, -44, 320, 44) afterSelectColor:^(UIColor *color) {
            _selectColorBlock(color);
            [self forceHideView:nil];
             NSLog(@"tool");
        }];
        [self addSubview:view];
        
        self.colorView = view;
    }
    
    [self showHideView:self.colorView];
}

#pragma mark 显示隐藏线宽视图
- (void)showHideLineWidthView{
    if(self.LineWidthView == nil){
        SelectLineWidthView *view = [[SelectLineWidthView alloc]initWithFrame:CGRectMake(0, -44, 320, 44) afterSelectLineWidth:^(CGFloat lineWidth) {
            _selectLineWidthBlock(lineWidth);
            [self forceHideView:nil];
        }];
        [self addSubview:view];
        
        self.LineWidthView = view;
    }
    
    [self showHideView:self.LineWidthView];
}

@end
