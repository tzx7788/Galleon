//
//  PostMessageViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "PostMessageViewController.h"
#import "Client.h"
#import "NotificationConstant.h"
#import "StringConstant.h"

@interface PostMessageViewController ()<UITextViewDelegate>

@end

@implementation PostMessageViewController

+ (PostMessageViewController *)createViewController
{
    PostMessageViewController * vc = [[PostMessageViewController alloc] initWithNibName:@"PostMessageViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.contentTextView layer] setCornerRadius:5.0];
    [[self.contentTextView layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor lightGrayColor].CGColor, 1.0f)];
    [[self.contentTextView layer] setBorderWidth:1.0f];
    [[self.submitButton layer] setCornerRadius:20.0];
    [[self.submitButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor lightGrayColor].CGColor, 1.0f)];
    [[self.submitButton layer] setBorderWidth:1.0f];
}

- (IBAction)submitClicked:(id)sender {
//    if (self.contentTextView.text.length < 4) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:EnterMoreContext];
//        return;
//    }
    [[Client sharedClient] PostMessgeWithContent:self.contentTextView.text token:self.model.user.token successBlock:^(id responseData){
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(NSError * error, NSString * errorString){
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
