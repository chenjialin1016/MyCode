
//
//  BaseAssemblyTableView.m
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "BaseAssemblyTableView.h"

@implementation BaseAssemblyTableView

- (void)reloadData{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(tableViewWillReloadData:)]) {
        [self.baseDelegate tableViewWillReloadData:self];
    }
    [super reloadData];
}

@end
