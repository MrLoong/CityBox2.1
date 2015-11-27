//
//  SubmitOrders.m
//  CityBox
//
//  Created by LastDay on 15/11/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "SubmitOrders.h"
#import "FoodviewCell.h"
#import "ViewController.h"
#import "DbHelper.h"
#import "GetManage.h"

@interface SubmitOrders ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property Menu *menu;
@property DbHelper *dbHelper;
@property NSDictionary *message;

@end

@implementation SubmitOrders

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _dbHelper = [GetManage getDbHelper];
    self.title = @"订单信息";
    
    [ViewController getOrder].orderNum = [self getOrdernum:[ViewController getOrder]];
    [ViewController getOrder].commission = [self getReward:[ViewController getOrder]];
    [ViewController getOrder].totalPrice = [self getPrice:[ViewController getOrder]];
    [ViewController getOrder].studentName = [self getName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([ViewController getOrder].menuArry.count == 0) {
        return 0;
    }else{
        
        return [ViewController getOrder].menuArry.count+1;

    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==[ViewController getOrder].menuArry.count){
        return 3;
    }
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    if(indexPath.section == [ViewController getOrder].menuArry.count){
        if (indexPath.row == 0) {
            
            
            cell.textLabel.text = @"订单号";
            
            cell.detailTextLabel.text =[self getOrdernum:[ViewController getOrder]];
            
        } else if(indexPath.row == 1) {
            
            cell.textLabel.text = @"佣金";
            cell.detailTextLabel.text = [self getReward:[ViewController getOrder]];
            
        }else if (indexPath.row == 2){
            
            cell.textLabel.text = @"总价";
            cell.detailTextLabel.text = [self getPrice:[ViewController getOrder]];
            
        }
        
    }else{
        _menu = [ViewController getOrder].menuArry[indexPath.section];
        if (indexPath.row == 0) {
            
            
            cell.textLabel.text = @"食堂";
            
            cell.detailTextLabel.text = _menu.Canteen;
            
        } else if(indexPath.row == 1) {
            
            cell.textLabel.text = @"档口";
            cell.detailTextLabel.text = _menu.Stalls;
            
        }else if (indexPath.row == 2){
            
            cell.textLabel.text = @"数量";
            cell.detailTextLabel.text = _menu.number;
            
        }else if (indexPath.row == 3){
            
            cell.textLabel.text = @"单价";
            cell.detailTextLabel.text = _menu.unitPrice;
            
        }else if (indexPath.row == 4){
            
            cell.textLabel.text = @"菜名";
            cell.detailTextLabel.text = _menu.dishesName;
            
        }
        
        

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.font =  [UIFont fontWithName:@"Helvetica" size:14];
    cell.textLabel.font =  [UIFont fontWithName:@"Helvetica" size:14];
    return cell;
    
}


//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return @"就是这样";
//}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"就是这样";
//}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (IBAction)commit:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"Commit" sender:self];
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

-(NSString *)getPrice:(Order *)order{
    int total = 0;
    
    for (Menu *obj in order.menuArry) {
        total+= [obj.unitPrice intValue];
    }
    
    
    return  [NSString stringWithFormat: @"%d元", total];
}


-(NSString *)getReward:(Order *)order{
    
    return  [NSString stringWithFormat: @"%lu元", (unsigned long)order.menuArry.count];
}


-(NSString *)getOrdernum:(Order *)order{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    
    NSString *number = [self getName];
    return  [number stringByAppendingString:timeString];
    
}

-(NSString *)getName{
    _message = [_dbHelper searchdata:@"Student"];
    NSString *number = _message[@"name"];
    return number;
}
@end
