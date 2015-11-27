//
//  FoodViewController.m
//  CityHelper
//
//  Created by LastDay on 15/11/10.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "FoodViewController.h"
#import "HttpRequesCenter.h"
#import "WSProgressHUD.h"
#import "FoodviewCell.h"

@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource,HttpRequesCenterProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *item;
@property NSDictionary *dictonary;
@property UIAlertView *alert;

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"food"]];
    self.title = @"菜单";
    [HttpRequesCenter createHttpReques:@"getFood"];
    [HttpRequesCenter addRequesClass:self withCreateHttpReques:@"getFood" POST:_URl parmenters:nil];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeBlack];
    
}
-(void)subscriptionMessage:(id)message httpNumber:(NSString *)httpNumber{
    
    _dictonary = message;
    _item = _dictonary[@"data"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    [WSProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _item.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor clearColor];
    if(cell == nil){
        cell = [[FoodviewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = _dictonary[@"data"][indexPath.row][@"name"];
    cell.price.text = _dictonary[@"data"][indexPath.row][@"price"];
    cell.indexPath = indexPath;
    cell.Canteen = _Canteen;
    cell.Stalls = _Stalls;
    
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _alert = [[UIAlertView alloc] initWithTitle:@"价格" message:_dictonary[@"data"][indexPath.row][@"price"] delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
    [_alert show];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"进到了这里");
}


@end
