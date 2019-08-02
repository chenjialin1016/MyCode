//
//  BaseAssemblyTableView.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BaseAssemblyTableView;

#pragma mark - tableView协议
@protocol BaseAssemblyTableViewDelegate <NSObject>


/**
 tableView 将要加载数据
 */
@optional
- (void)tableViewWillReloadData:(BaseAssemblyTableView *)tableView;

@end

#pragma mark - tableView样式枚举
typedef enum : NSInteger{
    BaseCellMarginType_Detail,
    BaseCellMarginType_List,
}BaseCellMarginType;

typedef enum: NSInteger{
    BaseCellLineType_Top,
    BaseCellLineType_Center,
    BaseCellLineType_Bottom,
}BaseCellLineType;

#pragma mark - 自定义tableView
@interface BaseAssemblyTableView : UITableView

@property (weak, nonatomic) id<BaseAssemblyTableViewDelegate> baseDelegate;


/**
 扩展TB样式（包括布局、分割线...）
 */
@property (assign, nonatomic) BaseCellMarginType cellMarginType;

@property (assign, nonatomic) BaseCellLineType cellLineType;

@end

NS_ASSUME_NONNULL_END
