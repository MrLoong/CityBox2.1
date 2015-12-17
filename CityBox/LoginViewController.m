//
//  LoginViewController.m
//  CityHelper
//
//  Created by LastDay on 15/10/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "LoginViewController.h"
#import "DbHelper.h"
#import "GetManage.h"
#import "MainTabBarController.h"
#import "WSProgressHUD.h"


@interface LoginViewController ()<HttpRequesCenterProtocol>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property MainTabBarController *mainTabBarController;
@property UIAlertView *alert;

@property DbHelper *dbHeper;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //是这里
    _dbHeper =  [GetManage getDbHelper];
    _mainTabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Root"];
    self.userName.placeholder = [NSString stringWithFormat:@"学号"];
    self.passWord.placeholder = [NSString stringWithFormat:@"密码"];
    _userName.tintColor = [UIColor grayColor];
    _passWord.tintColor = [UIColor grayColor];
    self.passWord.secureTextEntry = YES;
    // self.vi.enabled = YES;
    self.view.userInteractionEnabled = YES;
    self.userName.textColor = [UIColor blackColor];
    self.passWord.textColor = [UIColor blackColor];

}
- (IBAction)signUp:(id)sender {
    [self allertinitTitle:@"提示" meeeage:@"请使用城院帐号密码登录"];
}
- (IBAction)forgetPasword:(id)sender {
    [self allertinitTitle:@"提示" meeeage:@"此功能尚未开放，敬请期待"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)subscriptionMessage:(id)message httpNumber:(NSString *)httpNumber{
    
    if ([httpNumber isEqual:@"login"]&&[message[@"status"] isEqual:@"ok"]) {
        [self getClass];
        [self getStalls];
        [_dbHeper addData:[self getStudent] type:@"Student"];
    }else if ([httpNumber isEqual:@"login"]&&[message[@"status"] isEqual:@"login failed"]){
        [self allertinitTitle:@"提示" meeeage:@"用户名或密码错误"];
    }else if ([httpNumber isEqual:@"login"]&&[message[@"status"] isEqual:@"School network connection failure"]){
        [self allertinitTitle:@"提示" meeeage:@"校园网络有问题"];
    }else if ([httpNumber isEqual:@"ClassData"]||[httpNumber isEqual:@"Stalls"]){
        
        if([message[@"status"] isEqual:@"School network connection failure"]){
           // [self allertinitTitle:@"提示" meeeage:@"校园网络有问题"];
        }
        else{
                [_dbHeper addData:message type:httpNumber];
                
                if([[_dbHeper searchCheck:@"ClassData"]  isEqual: @"yes"]&&[[_dbHeper searchCheck:@"Stalls"]  isEqual: @"yes"]){
                    
                    NSLog(@"进入");
                    
                    [WSProgressHUD dismiss];
                    [self.view addSubview:_mainTabBarController.view];
                }
            }
        
       
    }
}
- (IBAction)loginCloud:(id)sender {
    
    if (self.userName.text.length != 0&&self.passWord.text.length!=0) {
        [self login];
       
    }else{
        [self allertinitTitle:@"提示" meeeage:@"请输入用户名或密码"];
    }
}

-(void)getClass{
    NSString *POST = @"http://120.27.53.146:5000/api/schedule";
    id parmenters = @{
                      @"username":self.userName.text,
                      @"password":self.passWord.text,
                      @"action":@"get"
                      };
    [HttpRequesCenter createHttpReques:@"ClassData"];
    [HttpRequesCenter addRequesClass:self withCreateHttpReques:@"ClassData" POST:POST parmenters:parmenters];
}
-(void)getStalls{
    
    NSString *POST = @"http://csxyxzs.sinaapp.com/stall_ios.php";
    

    [HttpRequesCenter createHttpReques:@"Stalls"];

    [HttpRequesCenter addRequesClass:self withCreateHttpReques:@"Stalls" POST:POST parmenters:nil];
}


-(void)login{
    NSString *POST = @"http://120.27.53.146:5000/api/login";
    id parmenters = @{
                      @"username":self.userName.text,
                      @"password":self.passWord.text
                      };
    [HttpRequesCenter createHttpReques:@"login"];
    [HttpRequesCenter addRequesClass:self withCreateHttpReques:@"login" POST:POST parmenters:parmenters];
    [WSProgressHUD showWithStatus:@"登录中..." maskType:WSProgressHUDMaskTypeBlack];
}

-(void)allertinitTitle:(NSString *)title meeeage:(NSString *)message{
    self.alert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
    [WSProgressHUD dismiss];
     [_alert show];
}

-(id )getStudent{
    
    NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:_userName.text,@"name",_passWord.text,@"password",nil];
    

    return song;
}


@end
