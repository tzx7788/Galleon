//
//  RegisterViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIAlertView+ErrorMessage.h"
#import "NotificationConstant.h"
#import "SelectionViewController.h"
#import "StringConstant.h"

@interface RegisterViewController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.confirmButton layer] setBorderWidth:1.0f];
    [[self.confirmButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.confirmButton layer] setCornerRadius:20.0f];
    [[self.cancelButton layer] setBorderWidth:1.0f];
    [[self.cancelButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.cancelButton layer] setCornerRadius:20.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateAvatarButtonClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从相册选取", nil];
    [actionSheet showInView:self.view];
}
- (IBAction)ComfirmClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:@"hahahah"];
    }];
}
- (IBAction)CancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)disctrictClicked:(id)sender {
    [self performSegueWithIdentifier:@"SelectionSegue" sender:self.districtTextField];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectionSegue"] && (sender == self.districtTextField) ) {
        SelectionViewController * vc = (SelectionViewController *)segue.destinationViewController;
        vc.textField = self.districtTextField;
        NSArray * array = @[Asia, Africa, NorhthAmerica, SouthAmerica, Europe, Oceania];
        vc.dataArray = array;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == actionSheet.cancelButtonIndex)
        return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    
    if(buttonIndex == 1) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if(buttonIndex == 0) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *edittedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (edittedImage.size.height > edittedImage.size.width + 3.5f || edittedImage.size.height < edittedImage.size.width - 3.5f) {
        [UIAlertView alertErrorMessage:@"为了达到更好的头像显示效果，请上传正方形头像"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    WERequest *request = [WERequest requestWithSuccessBlock:^(id responseObject) {
//        self.avatarImageView.image = edittedImage;
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        [UIAlertView alertErrorMessage:@"上传头像失败"];
//    }];
//    [request updateCurrentUserAvatarWithImage:edittedImage];
//    [[WEClient sharedClient] enqueueTokenRequest:request];
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
