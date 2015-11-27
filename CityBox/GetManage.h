//
//  GetManage.h
//  CityHelper
//
//  Created by LastDay on 15/10/26.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbHelper.h"

static DbHelper *dbHeper;

@interface GetManage : NSObject

+(DbHelper *)getDbHelper;

+(void)setDbHerlper:(DbHelper *)dbHelper;



@end
