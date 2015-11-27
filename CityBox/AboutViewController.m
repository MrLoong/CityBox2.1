//
//  AboutViewController.m
//  CityHelper
//
//  Created by LastDay on 15/11/2.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "AboutViewController.h"
#import "LoginViewController.h"
#import "DbHelper.h"
#import "GetManage.h"
#import "ViewController.h"
#import "MainTabBarController.h"



@interface AboutViewController ()

@property LoginViewController *loginViewController;
@property ViewController *viewController;
@property MainTabBarController *mainTabBarController;
@property DbHelper *dbHelper;


@property UINavigationController *classViewController;
@property UINavigationController *courselistViewController;
@property UINavigationController *libraryViewController;
@property UINavigationController *aboutViewController;
@property UIAlertView *alert;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbHelper = [GetManage getDbHelper];

    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关于";

    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"Logo"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"城院小助手";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        
        view;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Welcome to join us";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                
            }
            if (indexPath.row==1) {
                [self allertinitTitle:@"意见反馈" meeeage:@"请关注csxyxzs公众号进行反馈"];
            }
        

        } else if(indexPath.section == 1){
            if (indexPath.row == 0) {
                [self allertinitTitle:@"加入我们" meeeage:@"请关注csxyxzs公众号进行反馈给我们留言"];
            }
            if (indexPath.row==1) {
                
                [self allertinitTitle:@"开发团队" meeeage:@"UIT小助手开发团队"];

               // [self performSegueWithIdentifier:@"four" sender:self];
                
            }
        }

}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(sectionIndex==0)
        return 2;
    else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"版本信息                V2.0", @"意见反馈"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        
        NSArray *titles = @[@"加入我们", @"开发团队"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

- (IBAction)quitLogin:(id)sender {
    
    
    [_dbHelper deleteData];
    [_dbHelper deleteStalls];
    
    [self performSegueWithIdentifier:@"aboutToLogin" sender:self];

    
}

-(void)allertinitTitle:(NSString *)title meeeage:(NSString *)message{
    self.alert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
   // [WSProgressHUD dismiss];
    [_alert show];
}

@end
