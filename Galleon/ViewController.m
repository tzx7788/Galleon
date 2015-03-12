//
//  ViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 09/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuViewController.h"

@interface ViewController ()

@property (nonatomic, strong) LeftMenuViewController * leftMenuViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftMenuViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    [self addChildViewController:self.leftMenuViewController];
    [self.view addSubview:self.leftMenuViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
