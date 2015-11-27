//
//  Order.h
//  CityBox
//
//  Created by LastDay on 15/11/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Menu.h"



@interface Order : NSObject

@property (nonatomic, strong)NSMutableArray *menuArry;
@property NSString *address; //w
@property NSString *phoneNum; //w
@property NSString *totalPrice;
@property NSString *commission;
@property NSString *remarks; //w
@property NSString *orderNum;
@property NSString *studentName;

-(void)setVlue:(Menu *)h;
-(NSMutableArray *)getVlue;
-(void)clearMessage;

@end
