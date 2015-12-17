
//  ViewController.m
//  CityHelper
//
//  Created by MrLoong on 15/9/15.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "DbHelper.h"
#import "GetManage.h"
#import "MainTabBarController.h"



@interface ViewController ()


//View
@property LoginViewController *loginViewController;
@property MainTabBarController *mainTabBarController;
@property DbHelper *dbHelper;

@end
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewFrame];
    
    orders = [[Order alloc] init];
    
    _dbHelper = [[DbHelper alloc] init];
    [_dbHelper LoadData];
    [GetManage setDbHerlper:_dbHelper];
    
    
    if([[_dbHelper searchCheck:@"ClassData"]  isEqual: @"yes"]&&[[_dbHelper searchCheck:@"Stalls"]  isEqual: @"yes"]){
        
        [self.view addSubview:_mainTabBarController.view];
    }else{
        
        [self.view addSubview:_loginViewController.view];
    }
    
    
    }

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//初始化视图
-(void) initViewFrame{
    
    _loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    _mainTabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Root"];
    
}

+(Order *)getOrder{
    return orders;
}

@end
