//
//  HttpRequesCenterProtocol.h
//  CityHelper
//
//  Created by MrLoong on 15/9/16.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRequesCenterProtocol <NSObject>

@required
- (void)subscriptionMessage:(id)message httpNumber:(NSString *)httpNumber;

@end
