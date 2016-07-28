//
//  SoundTool.h
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundTool : NSObject

- (void)playMusic;
- (void)stopMusic;

- (void)playSoundByFileName:(NSString *)filename;
@end
