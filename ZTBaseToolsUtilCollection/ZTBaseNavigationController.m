//
//  ZTBaseNavigationController.m
//  ZTBaseToolsUtilCollection
//
//  Created by 孙东日 on 10/4/2019.
//  Copyright © 2019 孙东日. All rights reserved.
//

#import "ZTBaseNavigationController.h"

@interface ZTBaseNavigationController ()

@end

@implementation ZTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithRed:31/255.0 green:84/255.0 blue:184/255.0 alpha:1];
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
