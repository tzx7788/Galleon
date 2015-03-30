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
#import "Client.h"
#import "User.h"
#import "PersonModel.h"
#import <MBProgressHUD.h>
#import "UIImage+Resize.h"

@interface RegisterViewController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSString * headerName;

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

- (BOOL)verified
{
    if ( ![self.passwordTextField.text isEqualToString: self.confirmPasswordTextField.text] ){
        NSString * message =PasswordFail;
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.delegate = self;
        hud.dimBackground = YES;
        hud.square = YES;
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
        [hud show:YES];
        [hud hide:YES afterDelay:1.0f];
        return NO;
    }
    return YES;
}
- (IBAction)ComfirmClicked:(id)sender {
    if ([self verified]) {
        NSString * message =Registering;
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.delegate = self;
        hud.dimBackground = YES;
        hud.square = YES;
        hud.labelText = message;
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud show:YES];
        [[Client sharedClient] registerWithName:self.nameTextField.text
                                        account:self.accountTextField.text
                                       password:self.passwordTextField.text
                                    headerImage:self.headerName
                                        company:self.campanyTextField.text
                                            job:self.jobTextField.text
                                          phone:self.phoneTextField.text
                                          email:self.emailTextField.text
                                   successBlock:^(id responseData){
                                       NSLog(@"%@",responseData);
                                       User * user = [[User alloc] init];
                                       [user loadWithDictionary:responseData];
                                       user.password = self.passwordTextField.text;
                                       [User saveToCache:user];
                                       hud.mode = MBProgressHUDModeText;
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                       PersonModel * model = [[PersonModel alloc] init];
                                       model.user = user;
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:LogInSuccessful];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPersonPageClicked object:model];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLeftMenuUserRefresh object:nil];
                                   } failureBlock:^(NSError *error, NSString * errorString){
                                       hud.mode = MBProgressHUDModeText;
                                       hud.labelText = RegisterFailure;
                                       [hud hide:YES afterDelay:1];
                                   }];
    }
}
- (IBAction)CancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    int radius = edittedImage.self.size.height / 2;
    edittedImage = [edittedImage cutImageWithRadius:radius];
    edittedImage = [edittedImage OriginImage:edittedImage scaleToSize:self.avatarImageView.bounds.size];
    NSString * message = Uploading;
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.delegate = self;
    hud.dimBackground = YES;
    hud.square = YES;
    hud.labelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:YES];
    [[Client sharedClient] uploadImage:edittedImage successBlock:^(id responseData){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = UploadingSuccessful;
        [hud hide:YES afterDelay:1];
        self.headerName = responseData[@"filename"];
        [self.avatarImageView setImage:edittedImage];
    } failureBlock:^(NSError *error,NSString * errorString){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = UploadingFailure;
        [hud hide:YES afterDelay:1];
    }];
}

#pragma mark - MBProgressHUDDeleagte
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

#pragma - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollView scrollsToTop];
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 300, 0)];
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
