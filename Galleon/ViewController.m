//
//  ViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 09/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuViewController.h"
#import "RootContentViewController.h"
#import "GalleonNavigationController.h"
#import "UIView+Resize.h"
#import "NotificationConstant.h"
#import "MBProgressHUD.h"
#import "Client.h"
#import "ExhibitionModel.h"

typedef enum {
    WERootContainerViewControllerSlideDirectionStill = 0, // Default
    WERootContainerViewControllerSlideDirectionLeft = 1,
    WERootContainerViewControllerSlideDirectionRight = 2
    
} WERootContainerViewControllerSlideDirection;

typedef enum {
    WERootContainerViewControllerStatusContent = 0,
    WERootContainerViewControllerStatusLeftMenu = 1
} WERootContainerViewControllerStatus;

@interface ViewController ()<UIGestureRecognizerDelegate,MBProgressHUDDelegate>

@property (nonatomic, strong) LeftMenuViewController * leftMenuViewController;
@property (nonatomic, strong) UISnapShotNavigationController * contentNavigationController;
@property (nonatomic, strong) RootContentViewController * rootContentViewController;
@property (assign, nonatomic) WERootContainerViewControllerSlideDirection direction;
@property (assign, nonatomic) WERootContainerViewControllerStatus status;
@property (assign, nonatomic) CGFloat slideStartPointX;
@property (assign, nonatomic) CGFloat slideVelocityX;
@property (assign, nonatomic) BOOL isAnimating;
@end

@implementation ViewController

- (BOOL) shouldAutorotate
{
    return NO;
}

#define kMenuWidth 277
- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftMenuViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    [self addChildViewController:self.leftMenuViewController];
    [self.view addSubview:self.leftMenuViewController.view];
    self.rootContentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootContentViewController"];
    self.contentNavigationController = [[GalleonNavigationController alloc] initWithRootViewController:self.rootContentViewController];
    [self addChildViewController:self.contentNavigationController];
    [self.view addSubview:self.contentNavigationController.view];
    [self configureGesture];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftMenu) name:NotificationShowLeftMenu object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showContent) name:NotificationShowContent object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWarningMessage:) name:NotificationWarningMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadLoginViewController:) name:NotificationLoginIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exhibitionAddToCalendar:) name:NotificationExhibitionAddToCalendar object:nil];
    [self.contentNavigationController.view resetOriginX:kMenuWidth];
    [self disableSubView];
    self.status = WERootContainerViewControllerStatusLeftMenu;
}

- (void)exhibitionAddToCalendar:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[ExhibitionModel class]] ) {
        ExhibitionModel *model = [notification object];
        [model saveToCalendarWithViewController:self];
    }
}


- (void)showWarningMessage:(NSNotification *) notification
{
    NSString * message = @"";
    if ( [[notification object] isKindOfClass:[NSString class]] )
        message = [notification object];
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.delegate = self;
    hud.dimBackground = YES;
    hud.square = YES;
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
    }];
}

- (void)loadLoginViewController:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginIn object:nil];
    });
}

- (void)configureGesture
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didTriggerPanGesture:)];
    panGesture.delegate = self;
    
    [self.view addGestureRecognizer:panGesture];
}

#pragma mark - Private

#define kLeftThreshold 277/3
#define kRightThreshold (277*2/3)
- (void)didTriggerPanGesture:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.slideStartPointX = self.contentNavigationController.view.frame.origin.x;
        self.slideVelocityX = 0;
        
        CGPoint velocity = [pan velocityInView:self.view];
        self.direction = (velocity.x > 0) ? WERootContainerViewControllerSlideDirectionRight : WERootContainerViewControllerSlideDirectionLeft;
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint velotcity = [pan velocityInView:self.view];
        if (velotcity.x * self.slideVelocityX < 0) {
            self.direction = (self.direction == WERootContainerViewControllerSlideDirectionLeft) ? WERootContainerViewControllerSlideDirectionRight : WERootContainerViewControllerSlideDirectionLeft;
        }
        
        self.slideVelocityX = velotcity.x;
        
        CGPoint translation = [pan translationInView:self.view];
        CGFloat newOriginX = translation.x + self.slideStartPointX;
        newOriginX = newOriginX < 0? 0 : newOriginX;
        [self.contentNavigationController.view resetOriginX:newOriginX];
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        CGPoint translation = [pan translationInView:self.view];
        CGFloat newOriginX = translation.x + self.slideStartPointX;
        newOriginX = newOriginX < 0? 0 : newOriginX;
        
        if (self.direction == WERootContainerViewControllerSlideDirectionLeft && newOriginX < kRightThreshold) {
            // From Right To Left should show content
            [self showContent];
        } else if (self.direction == WERootContainerViewControllerSlideDirectionRight && newOriginX < kLeftThreshold) {
            // From Right To Left but not enough
            [self showContent];
        } else if (self.direction == WERootContainerViewControllerSlideDirectionRight && newOriginX > kLeftThreshold) {
            [self showLeftMenu];
        } else if (self.direction == WERootContainerViewControllerSlideDirectionLeft && newOriginX > kRightThreshold) {
            [self showLeftMenu];
        }
    }
}


- (void)showLeftMenu
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.contentNavigationController.view resetOriginX:kMenuWidth];
    } completion:^(BOOL finished) {
        [self disableSubView];
        
        self.status = WERootContainerViewControllerStatusLeftMenu;
        self.isAnimating = NO;
    }];
}

- (void)showContent
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.contentNavigationController.view resetOriginX:0];
    } completion:^(BOOL finished) {
        [self restoreSubView];
        
        self.status = WERootContainerViewControllerStatusContent;
        self.isAnimating = NO;
    }];
}

- (void)disableSubView
{
//    if (![self.contentNavigationController.visibleViewController respondsToSelector:@selector(getPopButton)]) {
//        self.contentNavigationController.visibleViewController.view.userInteractionEnabled = NO;
//        return;
//    }
//    
//    UIButton *popButton = [self.contentNavigationController.visibleViewController performSelector:@selector(getPopButton)];
//    
    for (UIView *subview in self.contentNavigationController.visibleViewController.view.subviews) {
//        if (subview == popButton) continue;
        subview.userInteractionEnabled = NO;
    }
}

- (void)restoreSubView
{
    for (UIView *subview in self.contentNavigationController.visibleViewController.view.subviews) {
        subview.userInteractionEnabled = YES;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (![gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) return NO;
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint location = [pan locationInView:self.view];
    
    if (CGRectContainsPoint(self.contentNavigationController.view.frame, location)) {
        return YES;
    }
    
    return NO;
}

- (void) finalize
{
    [super finalize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationShowLeftMenu object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationShowContent object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationWarningMessage object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationLoginIn object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationExhibitionAddToCalendar object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MBProgressHUDDeleagte
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

@end
