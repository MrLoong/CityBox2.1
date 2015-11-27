//
//  GetManage.m
//  CityHelper
//
//  Created by LastDay on 15/10/26.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "GetManage.h"

@implementation GetManage

+(DbHelper *)getDbHelper{
    return dbHeper;
}

+(void)setDbHerlper:(DbHelper *)Helper{
    dbHeper = Helper;
}

@end
