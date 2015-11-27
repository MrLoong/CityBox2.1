//
//  Confirmation orderViewController.m
//  CityBox
//
//  Created by LastDay on 15/11/24.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "ConfirmationorderViewController.h"
#import "ViewController.h"
#import "WSProgressHUD.h"
#import "HttpRequesCenterProtocol.h"
#import "HttpRequesCenter.h"

@interface ConfirmationorderViewController ()<HttpRequesCenterProtocol>

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *where;
@property (weak, nonatomic) IBOutlet UITextField *remark;

@end

@implementation ConfirmationorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交";

}
-(void)subscriptionMessage:(id)message httpNumber:(NSString *)httpNumber{
    NSLog(@"%@",message);
    
    if([message[@"status"] isEqual:@"ok"]){
        [self allertinitTitle:@"提示" meeeage:@"提交订单成功"];
        [[ViewController getOrder] clearMessage];
        [WSProgressHUD dismiss];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)commit:(UIButton *)sender {
    
    
    if(self.phone.text.length!=0&&self.where.text.length!=0&&self.remark.text.length!=0){
        if ([ViewController getOrder].menuArry.count == 0) {
            [self allertinitTitle:@"提示" meeeage:@"请返回重新选购"];
            
        }else{
            
            [ViewController getOrder].address = _where.text;
            [ViewController getOrder].remarks = _remark.text;
            [ViewController getOrder].phoneNum = _phone.text;
            
            
            [self loginWithordernum:[ViewController getOrder].orderNum ordermenu:[self setJosn] ordermealusername:[ViewController getOrder].studentName];
        }
    }else{
        [self allertinitTitle:@"提示" meeeage:@"请填写完整信息"];
    }
   
}

-(NSString *)setJosn{
    NSString *json;
    NSMutableArray *mutableArry = [[NSMutableArray alloc] init];
    for (Menu *obj in [ViewController getOrder].menuArry) {
        
        NSDictionary *so = [NSDictionary dictionaryWithObjectsAndKeys:obj.Canteen,@"st",obj.Stalls,@"dk",obj.number,@"sl",obj.unitPrice,@"dj",obj.dishesName,@"cm", nil];
        [mutableArry addObject:so];
        
    }
    
    NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:mutableArry,@"ordermeal",[ViewController getOrder].address,@"where",[ViewController getOrder].totalPrice,@"price",[ViewController getOrder].phoneNum,@"phone",[ViewController getOrder].remarks,@"remark",[ViewController getOrder].commission,@"reward",[ViewController getOrder].orderNum,@"ordernum",nil];
    
    if ([NSJSONSerialization isValidJSONObject:song])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}
-(void)loginWithordernum : (NSString *)ordernum ordermenu:(NSString *)ordermenu ordermealusername:(NSString *)ordermealusername{
    
    NSLog(@"%@",ordermenu);
    NSString *POST = @"http://cityuit.sinaapp.com/ordermeal.php";
    id parmenters = @{
                      @"ordernum":ordernum,
                      @"ordermenu":ordermenu,
                      @"ordermealusername":ordermealusername
                      };
    [HttpRequesCenter createHttpReques:@"Commit"];
    [HttpRequesCenter addRequesClass:self withCreateHttpReques:@"Commit" POST:POST parmenters:parmenters];
    [WSProgressHUD showWithStatus:@"提交中..." maskType:WSProgressHUDMaskTypeBlack];
    
}

-(void)allertinitTitle:(NSString *)title meeeage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
    [WSProgressHUD dismiss];
    [alert show];
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
