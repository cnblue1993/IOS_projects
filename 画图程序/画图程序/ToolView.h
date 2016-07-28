//
//  ToolView.h
//  画图程序
//
//  Created by anne on 16/4/27.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorView.h"
#import "SelectLineWidthView.h"

typedef void(^ToolViewActionBlock)();
//typedef void(^ToolViewSelectEarserBlock)();
//typedef void(^ToolViewSelectUndoBlock)();
//typedef void(^ToolViewSelectClearScreenBlock)();
//typedef void(^ToolViewSelectPhotoBlock)();

@interface ToolView : UIView

- (id)initWithFrame:(CGRect)frame
   afterSelectColor:(SelectColorBlock)afterSelectColor
afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth
       selectEarser:(ToolViewActionBlock)selectEarser
         selectUndo:(ToolViewActionBlock)selectUndo
  selectClearScreen:(ToolViewActionBlock)selectClearScreen
        selectPhoto:(ToolViewActionBlock)selectPhoto;

@end
