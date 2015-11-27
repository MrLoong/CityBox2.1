//
//  Order.m
//  CityBox
//
//  Created by LastDay on 15/11/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "Order.h"

@implementation Order


- (NSMutableArray *)menuArry {
    if (_menuArry == nil) {
        _menuArry = [NSMutableArray array];
    }
    
    return _menuArry;
}



-(void)setVlue:(Menu *)h{
    if (_menuArry == nil) {
        _menuArry = [NSMutableArray array];
    }
    
    [_menuArry addObject:h];
}
-(NSMutableArray *)getVlue{
    return _menuArry;
}
-(void)clearMessage{
    self.address = @" ";
    self.phoneNum = @" ";
    self.totalPrice = @" ";
    self.commission = @" ";
    self.remarks = @" ";
    self.menuArry = [[NSMutableArray alloc] init];
}

@end
