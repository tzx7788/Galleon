//
//  ExhibitionFileListViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 23/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionFileListViewController.h"
#import "NotificationConstant.h"
#import "PDFModel.h"
#import "PDFTableViewCell.h"
#import "Client.h"
#import "PDFPushNotification.h"

@interface ExhibitionFileListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * modelList;

@end

@implementation ExhibitionFileListViewController
@dynamic model;

+ (ExhibitionFileListViewController *)createViewController
{
    ExhibitionFileListViewController * vc = [[ExhibitionFileListViewController alloc] initWithNibName:@"ExhibitionFileListViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PDFTableViewCell" bundle:nil] forCellReuseIdentifier:@"PDFTableViewCell"];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getExhibitionPDFlistWithId:self.model.exhibitionId successBlock:^(id responseData){
        NSArray * array = responseData;
        NSMutableArray * modelArray = [[NSMutableArray alloc] init];
        for (id dict in array) {
            PDFModel * model = [[PDFModel alloc] init];
            if (dict[@"file_name"]) model.pdfName = dict[@"file_name"];
            if (dict[@"file_path"]) model.pdfURLString = dict[@"file_path"];
            [modelArray addObject:model];
        }
        self.modelList = [modelArray copy];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDFTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PDFTableViewCell" forIndexPath:indexPath];
    PDFModel * model = self.modelList[indexPath.row];
    cell.titleLabel.text = model.pdfName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDFPushNotification * pushNotification = [[PDFPushNotification alloc] init];
    PDFModel * model = self.modelList[indexPath.row];
    pushNotification.title = model.pdfName;
    pushNotification.model = model;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPush object:pushNotification];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
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
