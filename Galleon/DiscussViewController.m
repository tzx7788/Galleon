//
//  DiscussViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "DiscussViewController.h"
#import "DiscussTableViewCell.h"
#import "Client.h"
#import "MessageModel.h"

@interface DiscussViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * messageList;

@end

@implementation DiscussViewController

+ (DiscussViewController *)createViewController
{
    DiscussViewController * vc = [[DiscussViewController alloc] initWithNibName:@"DiscussViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscussTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiscussTableViewCell"];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getAllMessagesWithsuccessBlock:^(id responseData){
        NSMutableArray * modelArray = [[NSMutableArray alloc] init];
        NSArray * array = responseData;
        for ( id dict in array ) {
            MessageModel * model = [[MessageModel alloc] init];
            model.avatarURLString = dict[@"user"][@"header_small"];
            model.content = dict[@"content"];
            model.date = dict[@"created_time"];
            model.name = dict[@"user"][@"name"];
            [modelArray addObject:model];
        }
        self.messageList = [modelArray sortedArrayUsingComparator:^(id obj1, id obj2){
            MessageModel * a = (MessageModel *) obj1;
            MessageModel * b = (MessageModel *) obj2;
            return [b.date compare:a.date];
        }];
        [self.tableView reloadData];
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
    return self.messageList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static DiscussTableViewCell * cell = nil;
    if ( !cell ) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussTableViewCell"];
    }
    MessageModel * model = self.messageList[indexPath.row];
    cell.contentLabel.text = model.content;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscussTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussTableViewCell" forIndexPath:indexPath];
    [cell setModel:self.messageList[indexPath.row]];
    return cell;
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
