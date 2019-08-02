//
//  BaseAssemblyComponent+Private.m
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "BaseAssemblyComponent+Private.h"
#import <objc/runtime.h>

static const char *keyForTableView = "keyForTableView";
static const char *keyForDataDictionary = "keyForDataDictionary";
static const char *keyForComponentSection = "keyForComponentSection";
static const char *keyForComponentType = "keyForComponentType";

@implementation BaseAssemblyComponent (Private)
@dynamic tableView;

#pragma mark - setter\getter
- (void)setTableView:(BaseAssemblyTableView *)tableView{
    objc_setAssociatedObject(self, keyForTableView, tableView, OBJC_ASSOCIATION_RETAIN);
}

- (BaseAssemblyTableView *)tableView{
    return objc_getAssociatedObject(self, keyForTableView);
}

- (void)setDataDictionary:(NSDictionary *)dataDictionary{
    objc_setAssociatedObject(self, keyForDataDictionary, dataDictionary, OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)dataDictionary{
    return objc_getAssociatedObject(self, keyForDataDictionary);
}

- (void)setComponentType:(NSString *)componentType{
    objc_setAssociatedObject(self, keyForComponentType, componentType, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)componentType{
    return objc_getAssociatedObject(self, keyForComponentType);
}

- (void)setComponentSections:(NSArray *)componentSections{
    objc_setAssociatedObject(self, keyForComponentSection, componentSections, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray *)componentSections{
    return objc_getAssociatedObject(self, keyForComponentSection);
}

@end
