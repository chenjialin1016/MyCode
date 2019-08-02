//
//  BaseAssemblyComponent+Private.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "BaseAssemblyComponent.h"
#import "BaseAssemblyTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAssemblyComponent (Private)

/**
 数据字典
 */
@property (strong, nonatomic) NSDictionary *dataDictionary;


/**
 自定义的额tableView
 */
@property (strong, nonatomic) BaseAssemblyTableView *tableView;


/**
 组件类型
 */
@property (copy, nonatomic) NSString *componentType;


/**
 组件section数据
 */
@property (strong, nonatomic) NSArray *componentSections;

@end

NS_ASSUME_NONNULL_END
