//
//  ZTCustumSearchBarView.m
//  ZTBaseToolsUtilCollection
//
//  Created by 孙东日 on 10/4/2019.
//  Copyright © 2019 孙东日. All rights reserved.
//

#import "ZTCustumSearchBarView.h"

//颜色
#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define LINECOLOR RGB(229,229,229)//线段色
#define COMMNTBTNCOLOR RGB(33,211,134)//按钮
#define BACKGROUNDCOLOR RGB(246,246,246)//背景
//间距
#define pxChangePt(px) px/2
#define sizelevel_3 pxChangePt(34)//界面左、右间距||详情页标题
#define sizelevel_5 pxChangePt(30)//内容与边框上下距离||图标与内容间距||搜索导航
#define sizelevel_9 pxChangePt(14)//内容和内容之间间距
#define sizelevel_8 pxChangePt(24)//标题和内容之间间距
@interface ZTCustumSearchBarView()<UISearchBarDelegate>
{
    UIButton *btnSearch;
    UIButton *scannerBtn;
    UIView *backView;
}
@end
@implementation ZTCustumSearchBarView

//创建有查询按钮和无查询按钮的搜索框
-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString*)PlaceholderText withType:(searchToolsType)toolsType{
    self = [super initWithFrame:frame];
    _hidenScannerBtn = YES;
    if (self) {
        switch (toolsType) {
            case searchBtnType://有查询按钮
                [self initMianView:frame withPlaceholder:PlaceholderText];
                break;
            case searchInNaviBarType://内嵌在导航条里
                [self initwithoutSearchView:frame withPlaceholder:PlaceholderText];
                break;
            case withoutSearchBtnType://没有查询按钮
                [self initWithOutSearchBtnView:frame withPlaceholder:PlaceholderText];
                break;
            case noSideNaviBarType://无边框
                [self initWithNoSideSearchBtnView:frame withPlaceholder:PlaceholderText];
                break;
            default:
                break;
        }
    }
    return self;
}

//内嵌在自定义导航栏
-(instancetype)initPublicSearchView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText withEdgeInsets:(UIEdgeInsets)edge{
    self = [super initWithFrame:viewFrame];
    if (self) {
        //[self setBackgroundColor:NAVIBARCOLOR];
        //   CGFloat backViewWidth = (viewFrame.size.width-sizelevel_3-sizelevel_9)/6*5;
        backView = [[UIView alloc] initWithFrame:CGRectMake(edge.left, edge.top, viewFrame.size.width-edge.left-edge.right, viewFrame.size.height-edge.top-edge.bottom)];
        [backView.layer setCornerRadius:5.0f];
        backView.layer.masksToBounds = YES;
        [backView.layer setBorderWidth:0.5];
        [backView.layer setBorderColor:LINECOLOR.CGColor];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        self.searchCtrl = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
        [self.searchCtrl.layer setBorderWidth:10.0];
        [self.searchCtrl.layer setBorderColor:[UIColor whiteColor].CGColor];
        self.searchCtrl.placeholder = placeholderText;
        self.searchCtrl.delegate = self;
        for (UIView *subview in self.searchCtrl.subviews) {
            for(UIView* grandSonView in subview.subviews){
                if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    [grandSonView removeFromSuperview];
                }
                else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                    [grandSonView setBackgroundColor:[UIColor whiteColor]];
                }
            }//for cacheViews
        }//subviews
        [backView addSubview:self.searchCtrl];
    }
    return self;
}

-(void)initMianView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText{
    CGFloat backViewWidth = (viewFrame.size.width-sizelevel_3-sizelevel_9)/6*5;
    backView = [[UIView alloc] initWithFrame:CGRectMake(sizelevel_3/2, sizelevel_5, backViewWidth, 44)];
    [backView.layer setBorderWidth:0.5];
    [backView.layer setBorderColor:LINECOLOR.CGColor];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    self.searchCtrl =[self custumSetSearchBarFrame:CGRectMake(0, 0, backViewWidth, 44)];
    self.searchCtrl.placeholder = placeholderText;
    [backView addSubview:self.searchCtrl];
    
    btnSearch = [UIButton buttonWithType:UIButtonTypeSystem];
    // CGFloat btnSearchWidth = viewFrame.size.width -CGRectGetMaxX(backView.frame)+sizelevel_9;
    CGFloat btnSearchoffsetX = CGRectGetMaxX(backView.frame)+sizelevel_9;
    btnSearch.frame = CGRectMake(btnSearchoffsetX, sizelevel_3+sizelevel_9/2, backViewWidth/5, backView.frame.size.height-sizelevel_9-sizelevel_9/2);
    [btnSearch setTitle:@"查询" forState:UIControlStateNormal];
    [btnSearch setBackgroundColor:COMMNTBTNCOLOR];
    [btnSearch.layer setCornerRadius:4.0f];
    self.searchCtrl.delegate = self;
    [btnSearch setTintColor:[UIColor whiteColor]];
    [btnSearch addTarget:self action:@selector(searchRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSearch];
    [self.searchCtrl becomeFirstResponder];
}

-(void)initwithoutSearchView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText{
    // CGFloat backViewWidth = (viewFrame.size.width-sizelevel_3-sizelevel_9)/6*5;
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    [self.layer setCornerRadius:5.0f];
    self.layer.masksToBounds = YES;
    [backView.layer setBorderWidth:0.5];
    // [backView.layer setBorderColor:LINECOLOR.CGColor];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    self.searchCtrl = [self custumSetSearchBarFrame:CGRectMake(0, 0, backView.frame.size.width, viewFrame.size.height)];
    self.searchCtrl.placeholder = placeholderText;
    self.searchCtrl.searchFieldBackgroundPositionAdjustment = UIOffsetMake(2, 0);
    self.searchCtrl.searchTextPositionAdjustment =  UIOffsetMake(2, 0);
    self.searchCtrl.delegate = self;
    UITextField *searchField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
        searchField=[self.searchCtrl.subviews objectAtIndex:1];
    }
    else{
        searchField=[((UIView *)[self.searchCtrl.subviews objectAtIndex:0]).subviews lastObject];
    }
    [searchField setFrame:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    searchField.font = [UIFont systemFontOfSize:sizelevel_8];
    self.searchCtrl.delegate = self;
    [backView addSubview:self.searchCtrl];
    
}

-(void)initWithOutSearchBtnView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText{
    CGFloat backViewWidth = viewFrame.size.width;
    CGFloat backViewHeight = viewFrame.size.height;
    CGFloat baseConstHeight = 44; //搜索框固定高度
    CGFloat backViewY = (backViewHeight-baseConstHeight)>0?(backViewHeight-baseConstHeight)/2:0;
    backView = [[UIView alloc] initWithFrame:CGRectMake(sizelevel_3, backViewY, backViewWidth-sizelevel_3*2, baseConstHeight)];
    [backView.layer setBorderWidth:0.5];
    [backView.layer setBorderColor:LINECOLOR.CGColor];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    self.searchCtrl =[self custumSetSearchBarFrame:CGRectMake(0, 0, backView.frame.size.width, 44)];
    self.searchCtrl.placeholder = placeholderText;
    self.searchCtrl.delegate = self;
    [backView addSubview:self.searchCtrl];
    [self.searchCtrl becomeFirstResponder];
}

-(void)initWithNoSideSearchBtnView:(CGRect)viewFrame withPlaceholder:(NSString*)placeholderText{
    CGFloat backViewWidth = viewFrame.size.width;
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, viewFrame.size.height)];
    backView.backgroundColor =[UIColor whiteColor];
    [self addSubview:backView];
    self.searchCtrl = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, viewFrame.size.height)];
    self.searchCtrl.layer.masksToBounds = YES;
    [self.searchCtrl.layer setCornerRadius:1.0f];
    [self.searchCtrl.layer setBorderWidth:10.0];
    [self.searchCtrl.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.searchCtrl.placeholder = placeholderText;
    self.searchCtrl.delegate = self;
    [backView addSubview:self.searchCtrl];
    for (UIView *subview in self.searchCtrl.subviews) {
        for(UIView* grandSonView in subview.subviews){
            if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [grandSonView removeFromSuperview];
            }
            else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                [grandSonView setBackgroundColor:BACKGROUNDCOLOR];
            }
        }//for cacheViews
    }//subviews
    [self.searchCtrl becomeFirstResponder];
}


-(UISearchBar*)custumSetSearchBarFrame:(CGRect)cusFrame{
    UISearchBar *cusSearch = [[UISearchBar alloc] initWithFrame:cusFrame];
    cusSearch.layer.masksToBounds = YES;
    [cusSearch.layer setCornerRadius:5.0f];
    [cusSearch.layer setBorderWidth:10.0];
    [cusSearch.layer setBorderColor:[UIColor whiteColor].CGColor];
    UITextField *searchField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
        searchField=[self.searchCtrl.subviews objectAtIndex:1];
    }
    else{
        searchField=[((UIView *)[self.searchCtrl.subviews objectAtIndex:0]).subviews lastObject];
    }
    searchField.font = [UIFont systemFontOfSize:sizelevel_5];
    cusSearch.delegate = self;
    for (UIView *subview in self.searchCtrl.subviews) {
        for(UIView* grandSonView in subview.subviews){
            if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [grandSonView removeFromSuperview];
            }
            else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                [grandSonView setBackgroundColor:[UIColor clearColor]];
            }
        }//for cacheViews
    }//subviews
    return cusSearch;
}


/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(void)addScannerBtnInSearchBar{
    UITextField *searchField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
        searchField=[self.searchCtrl.subviews objectAtIndex:1];
    }
    else{
        searchField=[((UIView *)[self.searchCtrl.subviews objectAtIndex:0]).subviews lastObject];
    }
    if (scannerBtn==nil) {
        scannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scannerBtn setFrame:CGRectMake(self.searchCtrl.frame.size.width-24-sizelevel_9*1.5,sizelevel_9*1.5, 24, self.searchCtrl.frame.size.height-sizelevel_9*3)];
        [scannerBtn setImage:[UIImage imageNamed:@"扫描.png"] forState:UIControlStateNormal];
        [scannerBtn addTarget:self action:@selector(turnScannerController) forControlEvents:UIControlEventTouchUpInside];
        searchField.clearButtonMode = UITextFieldViewModeNever;
        [self.searchCtrl addSubview:scannerBtn];
    }
}

-(void)setCustomBackgroundColor:(UIColor *)customBackgroundColor{
    _customBackgroundColor = customBackgroundColor;
    backView.backgroundColor = _customBackgroundColor;
}

-(void)setHidenScannerBtn:(BOOL)hidenScannerBtn{
    _hidenScannerBtn = hidenScannerBtn;
    if (!_hidenScannerBtn) {
        [self addScannerBtnInSearchBar];
    }
}

#pragma mark -SearchBarViewDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if ([self.custumSearchBarViewDelegate respondsToSelector:@selector(custumsearchBarTextDidBeginEditing:)]) {
        [_custumSearchBarViewDelegate custumsearchBarTextDidBeginEditing:searchBar];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([self.custumSearchBarViewDelegate respondsToSelector:@selector(custumsearchBarSearchButtonClicked:)]) {
        [_custumSearchBarViewDelegate custumsearchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([self.custumSearchBarViewDelegate respondsToSelector:@selector(custumsearchBar:textDidChange:)]) {
        [_custumSearchBarViewDelegate custumsearchBar:searchBar textDidChange:searchText];
    }
}

- (void)searchRightButtonClick:(UIButton *)sender{
    if ([self.custumSearchBarViewDelegate respondsToSelector:@selector(custumSearchRightButtonClick:)]) {
        [_custumSearchBarViewDelegate custumSearchRightButtonClick:sender];
    }
}

//跳转二维码
-(void)turnScannerController{
    if ([self.custumSearchBarViewDelegate respondsToSelector:@selector(custumTurnScannerController)]) {
        [_custumSearchBarViewDelegate custumTurnScannerController];
    }
}

@end
