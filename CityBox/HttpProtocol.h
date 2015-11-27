//
//  HttpProtocol.h
//  CityHelper
//
//  Created by MrLoong on 15/10/8.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpProtocol <NSObject>

@required
- (void)httpMessage:(id)message httpNumber:(NSString *)httpNumber;

@end
