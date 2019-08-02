//
//  BaseAssemblyComponentViewController.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//
//快捷键：alt+command+/
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAssemblyComponent : UIViewController<UITableViewDelegate, UITableViewDataSource>

/**
 控制模块是否显示
 */
- (BOOL)shouldShowComponent;

#pragma mark - Register Cell


/**
 registers-Class

 @param cellClass cell类
 @param identifier cell标识
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier;

/**
 刷新TableView
 */
- (void)reloadTableView;


/**
 局部刷新Component
 */
- (void)reloadTableViewComponent;


/**
 局部刷新Component中的row

 */
- (void)reloadTableViewComponentWithRow:(NSInteger)row;

#pragma mark - Life Cycle


/**
 模块创建后触发相当于viewDidLoad
 */
- (void)setupComponent;


/**
 模块展示时调用相当于 viewWillAppear

 @param animated 是否动画
 */
- (void)assemblyComponentWillAppear:(BOOL)animated;


/**
 模块消失时调用相当于ViewWillAppear

 @param animated 是否动画
 */
-(void)assemblyComponentWillDisappear:(BOOL)animated;



@end

NS_ASSUME_NONNULL_END
