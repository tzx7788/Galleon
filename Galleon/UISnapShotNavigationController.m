//
//  UISnapShotNavigationController.h
//  WeCampus
//
//  Created by 吴 wuziqi on 13-9-13.
//  Copyright (c) 2013年 Ziqi Wu. All rights reserved.
//

#import "UISnapShotNavigationController.h"
#import "UIImage+Snapshot.h"
#import "ImageConstant.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat kMinThreshold = 277/3;
static CGFloat kStartZoomRate = 0.95;

static NSString *const snapShotKey = @"snapShotKey";
static NSString *const snapShotViewKey = @"snapShotViewKey";

@interface UISnapShotNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) UIImageView *leftSnapshotView;
@property (nonatomic, strong) UIView *maskView;

+ (NSString *)snapshotCachePath;

- (void)shresholdJudge;
- (void)dragAnimationFinished:(BOOL)popSuccess;

- (NSString *)snapshotPathForController:(UIViewController *)controller;
- (UIImageView *)leftSnapshotView;
- (void)resetLeftSnapshotView;

- (void)touchesEnded;
- (void)touchesMovedWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer;
- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer;

- (void)renderShadow;

@end

@implementation UISnapShotNavigationController

@synthesize leftSnapshotView = _leftSnapshotView;

+ (NSString *)snapshotCachePath {
    return [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/PopSnapshots"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:TabBarBackGround forBarMetrics:UIBarMetricsDefault];
  
    self.leftSnapshotView.hidden = YES;
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self renderShadow];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
    }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        [self touchesMovedWithPanGesture:gestureRecognizer];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded
               || gestureRecognizer.state == UIGestureRecognizerStateFailed
               || gestureRecognizer.state == UIGestureRecognizerStateCancelled
               || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        [self touchesEnded];
    }
}

#pragma mark -
#pragma mark - Push Action
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {    
    if ([self.viewControllers count] > 0) {
        UIImage *image = [UIImage snapshotForView:self.view];
        [self saveSnapshot:image forViewController:viewController];
    }
    
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self removeSnapshotForViewController:self.topViewController];
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *popedController = [super popToViewController:viewController animated:animated];
    for (UIViewController *vc in popedController) {
        [self removeSnapshotForViewController:vc];
    }
    return popedController;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *popedController = [super popToRootViewControllerAnimated:animated];
    for (UIViewController *vc in popedController) {
        [self removeSnapshotForViewController:vc];
    }
    return popedController;
}

#pragma mark - 
#pragma mark - Touch Action
- (void)touchesEnded {    
    [self shresholdJudge];
}

- (void)touchesMovedWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *piece = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[piece superview]];

    CGFloat x0 = CGRectGetMinX(piece.frame) + translation.x;
    if (x0 <= 0 || x0 >= CGRectGetWidth(piece.frame)) {
        return;
    }
    
    [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y)];
    [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];

    // 前一级ViewController 动画
    UIViewController *topViewController = self.topViewController;
    
    if (![self.view.superview.subviews containsObject:self.leftSnapshotView]) {
        [self.leftSnapshotView setFrame:self.view.bounds];
        [self.view.superview insertSubview:self.leftSnapshotView belowSubview:self.view];
        
        [self.maskView setFrame:self.view.bounds];
        [self.view.superview insertSubview:self.maskView belowSubview:self.leftSnapshotView];
    }

    if (self.leftSnapshotView.hidden) {
        self.leftSnapshotView.hidden = NO;
        UIImage *snapshot = [self snapshotForViewController:topViewController];
        self.leftSnapshotView.image = snapshot;
        
        self.maskView.hidden = NO;
    }
    
    float r = CGRectGetMinX(self.view.frame) / CGRectGetWidth(self.view.frame);
    CGFloat rate = kStartZoomRate + (1 - kStartZoomRate) * r;
    self.leftSnapshotView.transform = CGAffineTransformMakeScale(rate,rate);
    self.leftSnapshotView.alpha = r + 0.35;
}

#pragma mark -

- (void)shresholdJudge {
    if (CGRectGetMinX(self.view.frame) > kMinThreshold) {
        // pop
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.view.frame;
            rect.origin.x = CGRectGetMaxX(self.view.frame);
            self.view.frame = rect;
            UIImageView *imageView = self.leftSnapshotView;
            imageView.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
            [self dragAnimationFinished:YES];
            [self popViewControllerAnimated:NO];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.view.frame;
            rect.origin.x = 0;
            self.view.frame = rect;
            UIImageView *imageView = self.leftSnapshotView;
            imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self dragAnimationFinished:NO];
        }];
    }
}

- (void)dragAnimationFinished:(BOOL)popSuccess {

    [self resetLeftSnapshotView];
    
    if (popSuccess) {
        [self removeSnapshotForViewController:self.topViewController];        
    }

    CGRect rect = self.view.frame;
    rect.origin.x = 0;

    self.view.frame = rect;
}

#pragma mark - 
#pragma mark - snapshot
- (void)saveSnapshot:(UIImage *)image forViewController:(UIViewController *)controller {

    NSString *snapshotPath = [self snapshotPathForController:controller];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[UISnapShotNavigationController snapshotCachePath] isDirectory:NULL]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[UISnapShotNavigationController snapshotCachePath] withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:snapshotPath atomically:YES];
}

- (UIImage *)snapshotForViewController:(UIViewController *)controller {

    NSString *snapshotPath = [self snapshotPathForController:controller];
    UIImage *image = [UIImage imageWithContentsOfFile:snapshotPath];
    return image;
}

- (void)removeSnapshotForViewController:(UIViewController *)controller {
    self.leftSnapshotView.hidden = YES;
    
    NSString *snapshotPath = [self snapshotPathForController:controller];
    [[NSFileManager defaultManager] removeItemAtPath:snapshotPath error:nil];

}

- (NSString *)snapshotPathForController:(UIViewController *)controller {
    NSString *snapshotPath = [[UISnapShotNavigationController snapshotCachePath] stringByAppendingFormat:@"/<%p>.png",controller,nil];
    return snapshotPath;
}

- (UIImageView *)leftSnapshotView {
    if (_leftSnapshotView == nil) {
        _leftSnapshotView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _leftSnapshotView;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    return _maskView;
}

- (void)resetLeftSnapshotView {
    self.leftSnapshotView.transform = CGAffineTransformIdentity;
    self.leftSnapshotView.image = nil;
    self.leftSnapshotView.hidden = YES;
    
    self.maskView.hidden = YES;
}

- (void)renderShadow
{
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(5, 5);
    self.view.layer.shadowRadius = 15;
    self.view.layer.shadowOpacity = 0.55;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
