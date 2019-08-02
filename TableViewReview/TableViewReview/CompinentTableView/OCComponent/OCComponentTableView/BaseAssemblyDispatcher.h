//
//  BaseAssemblyDispatcher.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAssemblyTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAssemblyDispatcher : UIViewController<BaseAssemblyTableViewDelegate, UITableViewDelegate, UITableViewDataSource>


/**
 数据传递 （注：可以考虑 reactiveCocoa）
 */
@property (strong, nonatomic) NSDictionary *dataDictionary;
@property (strong, nonatomic) BaseAssemblyTableView *tableView;

- (NSArray *)components;

@end

NS_ASSUME_NONNULL_END
