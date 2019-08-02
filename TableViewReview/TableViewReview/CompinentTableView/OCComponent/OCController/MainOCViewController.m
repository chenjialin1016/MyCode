//
//  MainViewController.m
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

#import "MainOCViewController.h"
#import "UIListTimeComponent.h"
#import "UITitleNumberComponent.h"

@interface MainOCViewController ()

@end

@implementation MainOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AssemblyTableView";
    self.tableView.cellMarginType = BaseCellMarginType_List;
    NSArray *listData= [NSArray arrayWithObjects:@"UIListTimeComponents 2016-02-15@1",@"UIListTimeComponents 2016-02-15@2",@"UIListTimeComponents 2016-02-15@3",@"UIListTimeComponents 2016-02-15@4",@"UIListTimeComponents 2016-02-15@5",@"UIListTimeComponents 2016-02-15@6",@"UIListTimeComponents 2016-02-15@7",@"UIListTimeComponents 2016-02-15@8",@"UIListTimeComponents 2016-02-15@9",@"UIListTimeComponents 2016-02-15@10",
                        @"UIListTimeComponents 2016-02-15@11",@"UIListTimeComponents 2016-02-15@12",@"UIListTimeComponents 2016-02-15@13",@"UIListTimeComponents 2016-02-15@14",@"UIListTimeComponents 2016-02-15@15",
                        @"UIListTimeComponents 2016-02-15@16",@"UIListTimeComponents 2016-02-15@17",@"UIListTimeComponents 2016-02-15@18",@"UIListTimeComponents 2016-02-15@19",@"UIListTimeComponents 2016-02-15@20",
                        @"UIListTimeComponents 2016-02-15@21", nil];
    self.dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:listData, @"UIListTimeComponentKey", nil];
}

- (NSArray *)components{
    return [NSArray arrayWithObjects:
            @[@"UIListTimeComponentKey", NSStringFromClass([UIListTimeComponent class])],
            @[@"UITitleNumberComponentKey", NSStringFromClass([UITitleNumberComponent class])] ,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
