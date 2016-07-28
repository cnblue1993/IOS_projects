//
//  SoundTool.m
//  打飞机
//
//  Created by anne on 16/5/15.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "SoundTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundTool()

@property (strong, nonatomic) AVAudioPlayer *musicPlayer;

@property (strong, nonatomic) NSDictionary *soundDict;

@end

@implementation SoundTool

- (id)init{
    self = [super init];
    if(self){
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath] stringByAppendingPathComponent:@"music.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *path = [bundle pathForResource:@"game_music" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [self.musicPlayer setNumberOfLoops:-1];
        [self.musicPlayer prepareToPlay];
        
        self.soundDict = [self loadSoundsWithBundle:bundle];
    }
    return self;
}
- (NSDictionary *)loadSoundsWithBundle:(NSBundle *)bundle{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    NSArray *array = @[@"bullet",@"enemy1_down",@"enemy2_down",@"enemy3_down",@"game_over"];
    for(NSString *name in array){
        SystemSoundID soundId = [self loadSoundIdWithBundle:bundle name:name];
        [dictM setObject:@(soundId) forKey:name];
    }
    
    return dictM;
    
}
- (SystemSoundID)loadSoundIdWithBundle:(NSBundle *)bundle name:(NSString *)name{
    SystemSoundID soundId;
    
    NSString *path = [bundle pathForResource:name ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundId);
    
    return soundId;
}
- (void)playMusic{
    [self.musicPlayer play];
}

- (void)stopMusic{
    [self.musicPlayer stop];
}

- (void)playSoundByFileName:(NSString *)filename{
    SystemSoundID soundId = [self.soundDict[filename]unsignedLongValue];
    
    AudioServicesPlaySystemSound(soundId);
}
@end
