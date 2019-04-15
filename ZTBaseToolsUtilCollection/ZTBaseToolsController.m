//
//  ZTBaseToolsController.m
//  ZTBaseToolsUtilCollection
//
//  Created by 孙东日 on 10/4/2019.
//  Copyright © 2019 孙东日. All rights reserved.
//

#import "ZTBaseToolsController.h"
#import "ZTCustumSearchBarView.h"
@interface ZTBaseToolsController ()<ZTCustumSearchBarViewDelegate>
@property(nonatomic,strong)ZTCustumSearchBarView * custumSearchBarView;
@end

@implementation ZTBaseToolsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.custumSearchBarView];
}

#pragma mark - Getter and Setter
//自定义搜索栏
-(ZTCustumSearchBarView*)custumSearchBarView{
    if (_custumSearchBarView==nil) {
        _custumSearchBarView = [[ZTCustumSearchBarView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 64) withPlaceholder:@"请输入XXX" withType:noSideNaviBarType];
        _custumSearchBarView.hidenScannerBtn = YES;
        _custumSearchBarView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [_custumSearchBarView.searchCtrl resignFirstResponder];
        _custumSearchBarView.custumSearchBarViewDelegate = self;
    }
    return _custumSearchBarView;
}

@end
