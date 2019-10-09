//
//  GTListLoader.h
//  SampleApp
//
//  Created by dequanzhu on 2019/5/12.
//  Copyright © 2019 dequanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^GTListLoaderFinishBlock)(BOOL success, NSArray<GTListItem *> *dataArray);

/**
 列表请求
 */
@interface GTListLoader : NSObject

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
