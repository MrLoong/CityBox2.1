//
//  MainTabBarController.m
//  CityHelper
//
//  Created by LastDay on 15/11/1.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "MainTabBarController.h"
#import "ClassViewController.h"
#import "AboutViewController.h"
#import "LibraryController.h"
#import "CourselistViewController.h"



@interface MainTabBarController ()<UITabBarDelegate>


@property UINavigationController *classViewController;
@property UINavigationController *courselistViewController;
@property UINavigationController *libraryViewController;
@property UINavigationController *aboutViewController;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFram];
    [self.view addSubview:_classViewController.view];
    _tabBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    switch (item.tag) {
        case 0:
            
            [self removeFramView];
            [self.view addSubview:_classViewController.view];
            [self.view addSubview:self.tabBar];
            break;
            
        case 1:
            [self removeFramView];
            [self.view addSubview:_libraryViewController.view];
            [self.view addSubview:self.tabBar];
            break;
            
        case 2:
            [self removeFramView];
            [self.view addSubview:_courselistViewController.view];
            [self.view addSubview:self.tabBar];
            break;
        case 3:
            [self removeFramView];
            [self.view addSubview:_aboutViewController.view];
            [self.view addSubview:self.tabBar];
            break;
        default:
            break;
    }
}

-(void)initFram{
    _classViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"classNavigation"];
    _aboutViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutNavigation"];
    _libraryViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookNavigation"];
    _courselistViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Food"];
}
-(void)removeFramView{
    [_classViewController.view removeFromSuperview];
    [_courselistViewController.view removeFromSuperview];
    [_aboutViewController.view removeFromSuperview];
    [_libraryViewController.view removeFromSuperview];
}



@end
