//
//  ZTCustumSearchBarView.h
//  ZTBaseToolsUtilCollection
//
//  Created by 孙东日 on 10/4/2019.
//  Copyright © 2019 孙东日. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,searchToolsType){
    searchBtnType,
    withoutSearchBtnType,
    searchInNaviBarType,
    pubSearchBarType,
    noSideNaviBarType//无边框搜索框
};

@protocol ZTCustumSearchBarViewDelegate <NSObject>

@optional
- (void)custumsearchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (void)custumsearchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (void)custumsearchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (void)custumSearchRightButtonClick:(UIButton *)sender;
- (void)custumTurnScannerController;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZTCustumSearchBarView : UIView
@property (nonatomic) BOOL hidenScannerBtn;//带有二维码按钮 默认为YES隐藏
@property (nonatomic, retain) UISearchBar *searchCtrl;
@property (nonatomic,weak) id<ZTCustumSearchBarViewDelegate>custumSearchBarViewDelegate;
-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString*)PlaceholderText withType:(searchToolsType)toolsType;
-(instancetype)initPublicSearchView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText withEdgeInsets:(UIEdgeInsets)edge;
@property (nonatomic) searchToolsType searchToolsType;
//设置UISearchBar 父视图背景颜色
@property (nonatomic,strong) UIColor *customBackgroundColor;
@end

NS_ASSUME_NONNULL_END
