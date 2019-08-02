//
//  BaseAssemblySectionModel.h
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAssemblyComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAssemblySectionModel : NSObject

@property (assign, nonatomic) NSUInteger sectionIndexInTableView;
@property (strong, nonatomic) BaseAssemblyComponent *component;
@property (strong, nonatomic) NSString *componentKey;

@end

NS_ASSUME_NONNULL_END
