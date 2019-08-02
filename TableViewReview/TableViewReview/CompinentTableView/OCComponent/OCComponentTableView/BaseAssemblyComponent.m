//
//  BaseAssemblyComponentViewController.m
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "BaseAssemblyComponent.h"
#import "BaseAssemblyComponent+Private.h"

@interface BaseAssemblyComponent ()

@end

@implementation BaseAssemblyComponent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupComponent{
    NSLog(@"setupComponent ! ");
}

- (BOOL)shouldShowComponent{
    return YES;
}

#pragma mark - Register Cell
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier{
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)reloadTableView{
    [self.tableView reloadData];
}

- (void)reloadTableViewComponent{
    [self.componentSections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = (NSArray *)obj;
        BOOL isContain = [arr containsObject:self.componentType];
        if (isContain) {
            NSIndexSet *moduleSet = [[NSIndexSet alloc] initWithIndex:idx];
            [self.tableView reloadSections:moduleSet withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
}

- (void)reloadTableViewComponentWithRow:(NSInteger)row{
    [self.componentSections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = (NSArray *)obj;
        BOOL isContain = [arr containsObject:self.componentType];
        if (isContain) {
            NSIndexPath *componentIndexPath = [[NSIndexPath alloc] indexPathByAddingIndex:idx];
            [self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObjects:componentIndexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
}

#pragma mark - life cycle
- (void)assemblyComponentWillAppear:(BOOL)animated{
    NSLog(@"assemblyComponentWillAppear ! ");
}

- (void)assemblyComponentWillDisappear:(BOOL)animated{
    NSLog(@"assemblyComponentWillDisappear ! ");
}

#pragma mark - TB

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"BaseAssemblyComponent is select:%ld", (long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

#pragma mark - no-used method
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
