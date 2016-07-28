//
//  AirPlayGameViewController.m
//  打飞机
//
//  Created by anne on 16/5/14.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "AirPlayGameViewController.h"

#import "ImageResources.h"
#import "GameModel.h"
#import "SoundTool.h"

#import "BackgroundView.h"
#import "HeroView.h"
#import "BulletView.h"
#import "EnemyView.h"

static long steps;

@interface AirPlayGameViewController()

@property (strong, nonatomic) CADisplayLink *gameTimer;

@property (strong, nonatomic) ImageResources *imagesRes;
@property (strong, nonatomic) SoundTool *soundTool;

@property (weak, nonatomic) UIView *gameView;
@property (weak, nonatomic) BackgroundView *bgView;
@property (weak, nonatomic) HeroView *heroView;

@property (strong, nonatomic) GameModel *gameModel;

@property (strong, nonatomic) NSMutableSet *bulletViewSet;

@property (strong, nonatomic) NSMutableSet *enemyViewSet;

@property (weak, nonatomic) UILabel *scoreLabel;

@end

@implementation AirPlayGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.soundTool playMusic];
    
    steps = 0;
    self.bulletViewSet = [NSMutableSet set];
    self.enemyViewSet = [NSMutableSet set];
    
    self.gameModel = [GameModel gameModelWithArea:self.view.bounds heroSize:[self.imagesRes.heroFlyImages[0] size]];
    
    [self.gameModel.hero setBulletNormalSize:self.imagesRes.bulletNormalImage.size];
    [self.gameModel.hero setBulletEnhancedSize:self.imagesRes.bulletEnhancedImage.size];
    
    UIView *gameView = [[UIView alloc]initWithFrame:self.gameModel.gameArea];
    self.gameView = gameView;
    [self.view addSubview:gameView];
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
    [pauseButton setImage:image forState:UIControlStateNormal];
    
    UIImage *imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
    [pauseButton setImage:imageHL forState:UIControlStateHighlighted];
    [pauseButton setFrame:CGRectMake(20, 20, image.size.width, image.size.height)];
    [self.view addSubview:pauseButton];
    [pauseButton addTarget:self action:@selector(tapPauseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat labelX = pauseButton.frame.origin.x + pauseButton.frame.size.width;
    CGFloat labelY = 20;
    CGFloat labelW = self.gameModel.gameArea.size.width - labelX;
    CGFloat labelH = pauseButton.frame.size.height;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [self.view addSubview:label];
    self.scoreLabel = label;
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
    [label setTextColor:[UIColor darkGrayColor]];
    
    
    BackgroundView *bgView = [[BackgroundView alloc]initWithFrame:self.gameModel.gameArea image:self.imagesRes.bgImage];
    [self.gameView addSubview:bgView];
    self.bgView = bgView;
    
    HeroView *heroView = [[HeroView alloc]initWithImages:self.imagesRes.heroFlyImages];
    [heroView setCenter:self.gameModel.hero.position];
    [self.gameView addSubview:heroView];
    self.heroView = heroView;
    
    [self startGameTimer];
    
}
#pragma mark - 触摸事件
#pragma mark 触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.gameView];
    CGPoint preLocation = [touch previousLocationInView:self.gameView];
    
    CGPoint offset = CGPointMake(location.x - preLocation.x, location.y - preLocation.y);

    CGPoint position = self.gameModel.hero.position;
    self.gameModel.hero.position = CGPointMake(position.x + offset.x, position.y + offset.y);
}

#pragma mark - 私有方法
- (void)tapPauseButton:(UIButton *)button{
    button.tag = !button.tag;
    
    UIImage *image = nil;
    UIImage *imageHL = nil;
    if(button.tag){
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftStart.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftStartHL.png"];
        [self stopGameTimer];
        [self.soundTool stopMusic];
    }else{
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
        [self startGameTimer];
        [self.soundTool playMusic];
    }
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imageHL forState:UIControlStateHighlighted];
    
}
#pragma mark 时钟触发方法
- (void)step{
    steps++;
    [self.gameModel bgMoveDown];
    [self.bgView changeBGWithFrame1:self.gameModel.bgFrame1 Frame2:self.gameModel.bgFrame2];
    
    [self.heroView setCenter:self.gameModel.hero.position];
    
    if (steps % 20 == 0){
       // NSLog(@"step");
        [self.gameModel.hero fire];
        [self.soundTool playSoundByFileName:@"bullet"];
    }
    [self checkBullets];
    
    if (steps % 20 == 0) {
        Enemy *enemy = nil;
        if(steps % (5 * 60) == 0){
            EnemyType type = (arc4random_uniform(2) == 0)? kEnemyMiddle : kEnemyBig;
            CGSize size = self.imagesRes.enemyMiddleImage.size;
            if(type == kEnemyBig){
                size = [self.imagesRes.enemyBigImage[0] size];
            }
            enemy = [self.gameModel createEnemyWithType:type size:size];
        }
        else{
            enemy = [self.gameModel createEnemyWithType:kEnemySmall size:self.imagesRes.enemySmallImage.size];
        }
        if(enemy != nil){
            EnemyView *enemyView = [[EnemyView alloc]initWithEnemy:enemy imageRes:self.imagesRes];
            [self.enemyViewSet addObject:enemyView];
            [self.gameView addSubview:enemyView];
        }
    }
    
    [self updateEnemys];
    
    [self collisionDetector];
    
}

- (void)updateScoreLabel{
    if(self.gameModel.score == 0){
        [self.scoreLabel setText:@""];
    }else{
        [self.scoreLabel setText:[NSString stringWithFormat:@"%d000",self.gameModel.score]];
    }
}

- (void)collisionDetector{
    if (steps % 10 == 0){
         NSMutableSet *toRemovedSet = [NSMutableSet set];
        for (EnemyView *enemyView in self.enemyViewSet){
            Enemy *enemy = enemyView.enemy;
            
            if (enemy.toBlowup){
                [enemyView setImage:enemyView.blowupImages[enemy.blowupFrames++]];
            }
            if (enemy.blowupFrames == enemyView.blowupImages.count){
                [toRemovedSet addObject:enemyView];
            }
        }
        for (EnemyView *enemyView in toRemovedSet){
            self.gameModel.score += enemyView.enemy.score;
            [self updateScoreLabel];
            
            switch (enemyView.enemy.type) {
                case kEnemySmall:
                    [self.soundTool playSoundByFileName:@"enemy1_down"];
                    break;
                case kEnemyMiddle:
                    [self.soundTool playSoundByFileName:@"enemy3_down"];
                    break;
                case kEnemyBig:
                    [self.soundTool playSoundByFileName:@"enemy2_down"];
                    break;
                
            }
            [self.enemyViewSet removeObject:enemyView];
            [enemyView removeFromSuperview];
        }
        [toRemovedSet allObjects];
    }
    for (EnemyView *enemyView in self.enemyViewSet){
        Enemy *enemy = enemyView.enemy;
        
        for (BulletView *bulletView in self.bulletViewSet){
            Bullet *bullet = bulletView.bullet;
            if(CGRectIntersectsRect(bulletView.frame, enemyView.frame) && !enemy.toBlowup && !bullet.isUsed){
                enemy.hp -= bullet.damage;
                bullet.isUsed = YES;
                //NSLog(@"%d %d",enemy.hp, bullet.damage);
                if (enemy.hp <= 0){
                    enemy.toBlowup = YES;
                }else{
                    if (enemy.type == kEnemyBig){
                        [enemyView stopAnimating];
                    }
                    enemyView.image = enemyView.hitImage;
                }
            }
        }
    }
    
    for (EnemyView *enemyView in self.enemyViewSet){
        if(CGRectIntersectsRect(enemyView.frame, self.gameModel.hero.collisionFrame)){
            [self.soundTool playSoundByFileName:@"game_over"];
            [self.soundTool stopMusic];
            
            [self.heroView stopAnimating];
            [self.heroView setImage:self.imagesRes.heroBlowupImages[3]];
            [self.heroView setAnimationImages:self.imagesRes.heroBlowupImages];
            [self.heroView setAnimationDuration:1.0f];
            [self.heroView setAnimationRepeatCount:1];
            [self.heroView startAnimating];
            [self performSelector:@selector(stopGameTimer) withObject:nil afterDelay:1.0f];
            break;
        }
    }
}

- (void)startGameTimer{
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)stopGameTimer{
    [self.gameTimer invalidate];
}

- (void)updateEnemys{
    for (EnemyView *enemyView in self.enemyViewSet){
        Enemy *enemy = enemyView.enemy;
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y + enemy.speed);
        [enemyView setCenter:enemy.position];
    }
    NSMutableSet *toRemoveEnemys = [NSMutableSet set];
    for (EnemyView *enemyView in self.enemyViewSet){
        if(enemyView.frame.origin.y >= self.gameModel.gameArea.size.height){
            [toRemoveEnemys addObject:enemyView];
        }
    }
    for (EnemyView *enemyView in toRemoveEnemys){
        [self.enemyViewSet removeObject:enemyView];
        [enemyView removeFromSuperview];
    }
    [toRemoveEnemys removeAllObjects];
}

- (void)checkBullets{
    
    NSMutableSet *toRemoveSet = [NSMutableSet set];
    
    for (BulletView *bulletView in self.bulletViewSet){
        //NSLog(@"bulletview :%d",self.bulletViewSet.count);
        CGPoint position = CGPointMake(bulletView.center.x, bulletView.center.y - 6.0);
        [bulletView setCenter:position];
        
        if (CGRectGetMaxY(bulletView.frame) < 0 || bulletView.bullet.isUsed) {
            [toRemoveSet addObject:bulletView];
        }
    }
    
    for (BulletView *bulletView in toRemoveSet) {
        [bulletView removeFromSuperview];
        [self.bulletViewSet removeObject:bulletView];
    }
    
    [toRemoveSet removeAllObjects];
    
    for (Bullet *bullet in self.gameModel.hero.bulletSet){
        //NSLog(@"bullet :%d",self.gameModel.hero.bulletSet.count);
        UIImage *image = self.imagesRes.bulletNormalImage;
        if (bullet.isEnhanced){
            image = self.imagesRes.bulletEnhancedImage;
        }
        BulletView *bulletView = [[BulletView alloc]initWithImage:image bullet:bullet];
        [bulletView setCenter:bullet.position];
        [self.gameView addSubview:bulletView];
        [self.bulletViewSet addObject:bulletView];
    }
    [self.gameModel.hero.bulletSet removeAllObjects];
}

#pragma mark - 成员方法
#pragma mark 加载图像资源
- (void)loadResources{
    self.imagesRes = [[ImageResources alloc]init];
    self.soundTool = [[SoundTool alloc]init];
}
@end
