//
//  GTNewsViewController.m
//  SampleApp
//
//  Created by dequanzhu on 2019/4/6.
//  Copyright © 2019 dequanzhu. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"

@interface GTNewsViewController ()<UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray;
@property (nonatomic, strong, readwrite) GTListLoader *listLoader;
@end

@implementation GTNewsViewController

#pragma mark - lefe cycle

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[GTListLoader alloc] init];
    
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    GTDetailViewController *controller = [[GTDetailViewController alloc] initWithUrlString:item.articleUrl];
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }

    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];

    return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
//
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    __weak typeof(self)wself = self;
//    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//         __strong typeof(wself) strongSelf = wself;
//         [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//     }];
}

@end
