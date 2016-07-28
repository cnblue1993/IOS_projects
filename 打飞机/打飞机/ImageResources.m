//
//  ImageResources.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ImageResources.h"

@implementation ImageResources

#pragma mark - 私有方法
#pragma mark 从指定bundle中加载图像
- (UIImage *)loadImageWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName{
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    return [UIImage imageNamed:path];
}
#pragma mark 从指定bundle中加载序列帧动画
- (NSArray *)loadImagesWithBundle:(NSBundle *)bundle format:(NSString *)format count:(NSInteger)count{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for(NSInteger i = 1; i <= count; i++){
        NSString *imageName = [NSString stringWithFormat:format,i];
        
        UIImage *image = [self loadImageWithBundle:bundle imageName:imageName];
        
        [arrayM addObject:image];
    }
    
    return arrayM;
}

- (id)init{
    self = [super init];
    
    if (self) {
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"images.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
//        NSString *path = [bundle pathForResource:@"background_2" ofType:@"png"];
//        self.bgImage = [UIImage imageNamed:path];
        self.bgImage = [self loadImageWithBundle:bundle imageName:@"background_2"];
        
        self.heroFlyImages = [self loadImagesWithBundle:bundle format:@"hero_fly_%d" count:2];
        
        self.heroBlowupImages = [self loadImagesWithBundle:bundle format:@"hero_blowup_%d" count:4];
        
        self.bulletNormalImage = [self loadImageWithBundle:bundle imageName:@"bullet1"];
        self.bulletEnhancedImage = [self loadImageWithBundle:bundle imageName:@"bullet2"];
        
        self.enemySmallImage = [self loadImageWithBundle:bundle imageName:@"enemy1_fly_1"];
        self.enemySmallBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy1_blowup_%d" count:4];
        
        self.enemyMiddleImage = [self loadImageWithBundle:bundle imageName:@"enemy3_fly_1"];
        self.enemyMiddleBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy3_blowup_%d" count:4];
        self.enemyMiddleHitImage = [self loadImageWithBundle:bundle imageName:@"enemy3_hit_1"];
        
        self.enemyBigImage = [self loadImagesWithBundle:bundle format:@"enemy2_fly_%d" count:2];
        self.enemyBigBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy2_blowup_%d" count:7];
        self.enemyBigHitImage = [self loadImageWithBundle:bundle imageName:@"enemy2_hit_1"];
        
        
    }
    
    return self;
}
@end
