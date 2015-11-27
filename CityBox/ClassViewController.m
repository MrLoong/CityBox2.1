//
//  ClassViewController.m
//  CityHelper
//
//  Created by LastDay on 15/10/21.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassCell.h"
#import "GetManage.h"
#import "WeekCell.h"
#import "ZFPopupMenu.h"
#import "ZFPopupMenuItem.h"




@interface ClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *weekCollection;
@property (weak, nonatomic) IBOutlet UIButton *setWeekNumber;
@property NSArray *weekNameString;
@property NSArray *classNumberString;
@property NSDictionary *message;
@property NSArray *week;
@property NSArray *number;
@property int i;
@property NSInteger num;
@property DbHelper *dbHelper;
@property UIAlertView *alert;
@end

@implementation ClassViewController

static NSString * const reuseIdentifier = @"classCell";

-(NSArray *)menuItems
{
    ZFPopupMenuItem *item1 = [ZFPopupMenuItem initWithMenuName:@"第1周"
                                                         image:[UIImage imageNamed:@"图标1"]
                                                        action:@selector(test1)
                                                        target:self];
    ZFPopupMenuItem *item2 = [ZFPopupMenuItem initWithMenuName:@"第2周"
                                                         image:[UIImage imageNamed:@"图标2"]
                                                        action:@selector(test2)
                                                        target:self];
    ZFPopupMenuItem *item3 = [ZFPopupMenuItem initWithMenuName:@"第3周"
                                                         image:[UIImage imageNamed:@"图标3"]
                                                        action:@selector(test3)
                                                        target:self];
    ZFPopupMenuItem *item4 = [ZFPopupMenuItem initWithMenuName:@"第4周"
                                                         image:[UIImage imageNamed:@"图标4"]
                                                        action:@selector(test4)
                                                        target:self];
    ZFPopupMenuItem *item5 = [ZFPopupMenuItem initWithMenuName:@"第5周"
                                                         image:[UIImage imageNamed:@"图标1"]
                                                        action:@selector(test5)
                                                        target:self];
    ZFPopupMenuItem *item6 = [ZFPopupMenuItem initWithMenuName:@"第6周"
                                                         image:[UIImage imageNamed:@"图标2"]
                                                        action:@selector(test6)
                                                        target:self];
    ZFPopupMenuItem *item7 = [ZFPopupMenuItem initWithMenuName:@"第7周"
                                                         image:[UIImage imageNamed:@"图标3"]
                                                        action:@selector(test7)
                                                        target:self];
    ZFPopupMenuItem *item8 = [ZFPopupMenuItem initWithMenuName:@"第8周"
                                                         image:[UIImage imageNamed:@"图标4"]
                                                        action:@selector(test8)
                                                        target:self];
    ZFPopupMenuItem *item9 = [ZFPopupMenuItem initWithMenuName:@"第9周"
                                                         image:[UIImage imageNamed:@"图标1"]
                                                        action:@selector(test9)
                                                        target:self];
    ZFPopupMenuItem *item10 = [ZFPopupMenuItem initWithMenuName:@"第10周"
                                                          image:[UIImage imageNamed:@"图标2"]
                                                         action:@selector(test10)
                                                         target:self];
    ZFPopupMenuItem *item11 = [ZFPopupMenuItem initWithMenuName:@"第11周"
                                                          image:[UIImage imageNamed:@"图标3"]
                                                         action:@selector(test11)
                                                         target:self];
    ZFPopupMenuItem *item12 = [ZFPopupMenuItem initWithMenuName:@"第12周"
                                                          image:[UIImage imageNamed:@"图标4"]
                                                         action:@selector(test12)
                                                         target:self];
    ZFPopupMenuItem *item13 = [ZFPopupMenuItem initWithMenuName:@"第13周"
                                                          image:[UIImage imageNamed:@"图标1"]
                                                         action:@selector(test13)
                                                         target:self];
    ZFPopupMenuItem *item14 = [ZFPopupMenuItem initWithMenuName:@"第14周"
                                                          image:[UIImage imageNamed:@"图标2"]
                                                         action:@selector(test14)
                                                         target:self];
    ZFPopupMenuItem *item15 = [ZFPopupMenuItem initWithMenuName:@"第15周"
                                                          image:[UIImage imageNamed:@"图标3"]
                                                         action:@selector(test15)
                                                         target:self];
    ZFPopupMenuItem *item16 = [ZFPopupMenuItem initWithMenuName:@"第16周"
                                                          image:[UIImage imageNamed:@"图标4"]
                                                         action:@selector(test16)
                                                         target:self];
    ZFPopupMenuItem *item17 = [ZFPopupMenuItem initWithMenuName:@"第17周"
                                                          image:[UIImage imageNamed:@"图标1"]
                                                         action:@selector(test17)
                                                         target:self];
    ZFPopupMenuItem *item18 = [ZFPopupMenuItem initWithMenuName:@"第18周"
                                                          image:[UIImage imageNamed:@"图标2"]
                                                         action:@selector(test18)
                                                         target:self];
    ZFPopupMenuItem *item19 = [ZFPopupMenuItem initWithMenuName:@"第19周"
                                                          image:[UIImage imageNamed:@"图标3"]
                                                         action:@selector(test19)
                                                         target:self];
    ZFPopupMenuItem *item20 = [ZFPopupMenuItem initWithMenuName:@"第20周"
                                                          image:[UIImage imageNamed:@"图标4"]
                                                         action:@selector(test20)
                                                         target:self];
    
    return @[item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item14,item15,item16,item17,item18,item19,item20];
}
- (IBAction)setCofing:(id)sender {
    [self allertinitTitle:@"提示" meeeage:@"此功能暂未开放,敬请期待"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"进入课表");
    
    self.title = @"课表";
    NSString *openDayString = @"2015-09-7";
    _num = [self Calculate:openDayString];
    NSString *title = [[@"第" stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)_num]] stringByAppendingString:@"周▼"];
    [self.setWeekNumber setTitle:title forState:UIControlStateNormal];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _weekCollection.dataSource = self;
    _weekCollection.delegate = self;
    [_collectionView reloadData];
    [_weekCollection reloadData];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.weekCollection.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"classBack"]];
    [self initData];
}

-(void)allertinitTitle:(NSString *)title meeeage:(NSString *)message{
    self.alert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
    //[WSProgressHUD dismiss];
    [_alert show];
}


//计算当前周数
-(NSInteger)Calculate:(NSString *) openDayString{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *openDay = [dateFormatter dateFromString:openDayString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumberOfNow =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    NSInteger weekNumberOfOpenDay =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:openDay] weekOfYear];
    NSInteger weekDayNow = [[calendar components:NSCalendarUnitWeekday fromDate:now] weekday];
    if (weekDayNow == 1) {
         return  weekNumberOfNow - weekNumberOfOpenDay;
    }
    else{
         return  weekNumberOfNow - weekNumberOfOpenDay + 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (IBAction)setWeekNums:(UIButton *)sender {
    
    [ZFPopupMenu setMenuBackgroundColorWithRed:0 green:0 blue:0 aphla:0.5];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int i;
    if ([collectionView isEqual:self.collectionView]) {
        i = 48;
    }else if([collectionView isEqual:self.weekCollection]){
        i= 8;
    }
    return i;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *colorHex[] = {@"D45DA5",@"D936C0",@"85EB6A",@"03899C",@"6F0F95",@"FF6633",@"33BDB8",@"D65DA1"};
    
    int x = (arc4random() % 7) + 1;
    if ([collectionView isEqual:self.collectionView]) {
        ClassCell *cell = (ClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        if (indexPath.item%8==0) {
            cell.classNmea.text = [_classNumberString objectAtIndex:_i];
            _i++;
            [cell.classNmea setNumberOfLines:0];
            cell.classNmea.textColor =  [UIColor blackColor];
            CGFloat h = 0.8f;
            [cell setBackgroundColor:[self getColor:@"D3D3D3" alpha:&h]];
            
        }else{
            
            NSInteger j = (indexPath.item%8)-1;
            NSInteger k = (indexPath.item-(indexPath.item%8))/8;
            if (![[self getMessageLable:j and:k] isEqual:@" "]) {
                cell.classNmea.text = [self getMessageLable:j and:k];
                CGFloat h = 0.95f;
                [cell setBackgroundColor:[self getColor:colorHex[x] alpha:&h]];
            }else{
                CGFloat h = 0.0f;
                [cell setBackgroundColor:[self getColor:@"D3D3D3" alpha:&h]];
                cell.classNmea.text = @" ";
            }
            [cell.classNmea setNumberOfLines:0];
        }
        return cell;
        
    }else if([collectionView isEqual:self.weekCollection]){
        
        WeekCell *cell = (WeekCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"weekCell" forIndexPath:indexPath];
        cell.weekName.text = [_weekNameString objectAtIndex:indexPath.item];
        return cell;
    }
    return nil;
}


-(NSString *)getMessageLable:(NSInteger )week and:(NSInteger)number{
    
    NSInteger j = week;
    NSInteger k = number;
    NSString *lable;
    NSArray *type = _message[@"schedule"][_week[j]][_number[k]];  //课程
    for (int m=0;m<type.count;m++) {
        if ((NSNull *)_message[@"schedule"][_week[j]][_number[k]][m]!=[NSNull null]&&[_message[@"schedule"][_week[j]][_number[k]][m][@"weeks"] indexOfObject:[NSNumber numberWithInteger:_num]]!=NSNotFound) {
            NSString *str =  _message[@"schedule"][_week[j]][_number[k]][m][@"class_name"];
            NSString *s =  _message[@"schedule"][_week[j]][_number[k]][m][@"classrom"];
            
            NSString *name = [[str stringByAppendingString:@"@"] stringByAppendingString:s];
            lable = name;
            return lable;
        }
    }
    return @" ";
}

- (UIColor *)getColor:(NSString*)hexColor alpha:(CGFloat*)al
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:*al];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.collectionView]){
        if(indexPath.item%8!=0){
            // [self performSegueWithIdentifier:@"ok" sender:indexPath];
        }
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:_collectionView]) {
        CGFloat height = collectionView.frame.size.height;
        CGFloat width = collectionView.frame.size.width;
        return CGSizeMake((width/8)-1, height/6.5);

    }else if([collectionView isEqual:_weekCollection]){
        CGFloat width = collectionView.frame.size.width;
        return CGSizeMake((width/8)-1, 50);
    }
    
    return CGSizeMake(0, 0);

}


-(void)initData{
    _i=0;
    _dbHelper = [GetManage getDbHelper];
    _message = [_dbHelper searchdata:@"ClassData"];
        
    _week = [NSArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu",@"Fri",@"Sat",@"Sun",nil];
    _number = [NSArray arrayWithObjects:@"1-2", @"3-4", @"5-6", @"7-8",@"9-10",@"11-12",nil];
    _weekNameString = [NSArray arrayWithObjects:@"UIT", @"周一", @"周二", @"周三",@"周四",@"周五",@"周六",@"周日",nil];
    _classNumberString = [NSArray arrayWithObjects:@"1~2", @"3~4", @"5~6", @"7~8",@"9~10",@"11~12",nil];
}

#pragma mark - Navigation

#pragma mark - item

-(void)test1
{
    _num = 1;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test2
{
    _num = 2;
    _i = 0;
    [_collectionView reloadData];}

-(void)test3
{
    _num = 3;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test4
{
    _num = 4;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test5
{
    _num = 5;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test6
{
    _num = 6;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test7
{
    _num = 7;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test8
{
    _num = 8;
    _i = 0;
    [_collectionView reloadData];
}
-(void)test9
{
    _num = 9;
    _i = 0;
    [_collectionView reloadData];}

-(void)test10
{
    _num = 10;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test11
{
    _num = 11;
    _i = 0;
    [_collectionView reloadData];}

-(void)test12
{
    _num = 12;
    _i = 0;
    [_collectionView reloadData];
}
-(void)test13
{
    _num = 13;
    _i = 0;
    [_collectionView reloadData];}

-(void)test14
{
    _num = 14;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test15
{
    _num = 15;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test16
{
    _num = 16;
    _i = 0;
    [_collectionView reloadData];
}
-(void)test17
{
    _num = 17;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test18
{
    _num = 18;
    _i = 0;
    [_collectionView reloadData];
}

-(void)test19
{
    _num = 19;
    _i = 0;
    [_collectionView reloadData];}

-(void)test20
{
    _num = 20;
    _i = 0;
    [_collectionView reloadData];
}

@end
