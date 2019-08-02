//
//  BaseAssemblyDispatcher.m
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "BaseAssemblyDispatcher.h"
#import "BaseAssemblySectionModel.h"
#import "BaseAssemblyComponent+Private.h"

@interface BaseAssemblyDispatcher ()

@property (strong, nonatomic) NSMutableDictionary *assemblyComponents;

@end

@implementation BaseAssemblyDispatcher
@synthesize tableView, dataDictionary;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWithData];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initWithData];
    }
    return self;
}

- (void)initWithData {
    self.assemblyComponents = [NSMutableDictionary dictionary];
}

- (void)loadView {
    CGRect rect = [UIScreen mainScreen].bounds;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView = [[BaseAssemblyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.baseDelegate = self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithData];
    [self updateSections];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (BaseAssemblySectionModel *section in self.assemblyComponents.allValues) {
        [section.component assemblyComponentWillAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (BaseAssemblySectionModel *section in self.assemblyComponents.allValues) {
        [section.component assemblyComponentWillDisappear:animated];
    }
}

#pragma mark - work
- (NSArray *)components{
    return @[];
}

#pragma mark - BaseAssemblyTableViewDelagate

- (void)tableViewWillReloadData:(BaseAssemblyTableView *)tableView{
    [self updateSections];
}


/**
 更新sections数据
 */
- (void)updateSections{
    __block BaseAssemblyDispatcher *_wself = self;
    NSArray *list = [self components];
    [self cleanRepeatCompontKey:list];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = (NSArray *)obj;
        if (!arr && arr.count<1) {
            return ;
        }
        BaseAssemblySectionModel *section = [[BaseAssemblySectionModel alloc] init];
        section.sectionIndexInTableView = idx;
        
        NSString *componentType = arr.firstObject;
        Class componentClass = NSClassFromString(arr[1]);
        BaseAssemblyComponent *component = _wself.assemblyComponents[@(idx).stringValue];
        if (!component || ![component isKindOfClass:componentClass]) {
            component = [self createComponentWithComponentClass:componentClass ComponentType:componentType];
        }
        
        section.component = component;
        section.componentKey = componentType;
        [_wself.assemblyComponents setValue:section forKey:@(idx).stringValue];
    }];
}


/**
 根据组件类创建组件

 @param componentClass 组件类
 @param componentType 组件类型
 @return 组件
 */
- (BaseAssemblyComponent *)createComponentWithComponentClass:(Class)componentClass ComponentType:(NSString *)componentType{
    if ([componentClass isSubclassOfClass:[BaseAssemblyComponent class]]) {
        BaseAssemblyComponent *component = [componentClass new];
        component.tableView = self.tableView;
        component.dataDictionary = self.dataDictionary;
        component.componentType = componentType;
        component.componentSections = [self components];
        [self addChildViewController:component];
        [component setupComponent];
        
        return component;
    }else{
        return [BaseAssemblyComponent new];
    }
}


/**
 清除重复的组件key

 @param list key数组
 */
- (void)cleanRepeatCompontKey:(NSArray *)list{
    __block BaseAssemblyDispatcher *_wself = self;
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = (NSArray *)obj;
        if (!arr && arr.count<1) {
            return ;
        }
        NSString *componentType = arr.firstObject;
        NSArray *values = _wself.assemblyComponents.allValues;
        NSInteger isRepeat = [_wself isRepeat:values withType:componentType];
        if (isRepeat > -1) {
            BaseAssemblySectionModel *section = [self.assemblyComponents objectForKey:@(isRepeat).stringValue];
            [section.component removeFromParentViewController];
            [_wself.assemblyComponents removeObjectForKey:@(isRepeat).stringValue];
        }
    }];
}


/**
 判断是否重复

 @param values 值数组
 @param componentType 组件类型
 @return 重复的值
 */
- (NSInteger)isRepeat:(NSArray *)values withType:(NSString *)componentType{
    __block NSInteger isRepeat = -1;
    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseAssemblySectionModel *section = (BaseAssemblySectionModel *)obj;
        if ([section.componentKey isEqualToString:componentType]) {
            isRepeat = section.sectionIndexInTableView;
            *stop = YES;
        }
    }];
    return isRepeat;
}

#pragma mark - TB

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *arr = self.assemblyComponents.allKeys;
    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *idx = @(section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    [sectionComponent.component view];
    return [sectionComponent.component tableView:self.tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    [sectionComponent.component tableView:self.tableView
                  didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString *idx = @(section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *idx = @(section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *idx = @(section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString *idx = @(section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView viewForFooterInSection:section];
}

#pragma mark - no used
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    [sectionComponent.component tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView canEditRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView canFocusRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = @(indexPath.section).stringValue;
    BaseAssemblySectionModel *sectionComponent = [self.assemblyComponents valueForKey:idx];
    return [sectionComponent.component tableView:self.tableView canMoveRowAtIndexPath:indexPath];
}
@end
