//
//  BaseCellProtocol.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseCellProtocol <NSObject>

- (void)updateData:(id)model;

@end

NS_ASSUME_NONNULL_END
