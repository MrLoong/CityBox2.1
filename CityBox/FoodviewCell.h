//
//  FoodviewCell.h
//  CityBox
//
//  Created by LastDay on 15/11/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "CourselistViewController.h"



@interface FoodviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UIStepper *selectNumber;

@property NSIndexPath *indexPath;
@property NSString *Canteen;
@property NSString *Stalls;
@property NSString *numberString;
@property NSString *unitPrice;
@property NSString *dishesName;
@property (nonatomic,strong)NSMutableArray *mutableArry;

@end
