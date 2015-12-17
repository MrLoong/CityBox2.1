//
//  SelectViewViewController.m
//  CityBox
//
//  Created by LastDay on 15/12/17.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "SelectViewViewController.h"
#import "CourselistViewController.h"

@interface SelectViewViewController ()


@end

@implementation SelectViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"页面选择";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)SubmitView:(UIButton *)sender {
    [self performSegueWithIdentifier:@"select" sender:self];
}

@end
