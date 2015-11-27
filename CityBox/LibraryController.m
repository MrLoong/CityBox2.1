//
//  LibraryController.m
//  CityHelper
//
//  Created by LastDay on 15/11/10.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "LibraryController.h"
#import "WSProgressHUD.h"

@interface LibraryController ()<UISearchBarDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *librarySearchBar;
@property (weak, nonatomic) IBOutlet UIWebView *libraryWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation LibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图书搜索";
    
    self.librarySearchBar.keyboardType = UIKeyboardTypeDefault;
    self.librarySearchBar.placeholder = @"请输入书名";
    self.librarySearchBar.delegate = self;
    self.librarySearchBar.showsCancelButton = YES;

    self.libraryWebView.delegate = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"classBack"]];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 实现取消按钮的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // 丢弃第一使用者
}

#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [self fetchResult];
}

- (void)fetchResult{
    
    NSString *bookName = self.librarySearchBar.text;
    NSString *bookapi = [NSString stringWithFormat:@"http://1.csxyxzs.sinaapp.com/library.php?book_name=%@", bookName];
    NSURL *url = [NSURL URLWithString:bookapi];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeBlack];
    [_libraryWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.isLoading){
        return;
    }
    else{
        [WSProgressHUD dismiss];
    }
}

- (void) setLibraryWebView:(UIWebView *)libraryWebView{
    _libraryWebView = libraryWebView;
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
