//
//  CYLDBManager.m
//  CityHelper
//
//  Created by MrLoong on 15/10/11.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "CYLDBManager.h"

NSString *const kDataSourceSectionKey     = @"data";
NSString *const kDataSourceCellTextKey    = @"name";
NSString *const kDataSourceCellPictureKey = @"Picture";


@implementation CYLDBManager

static  DbHelper *dbHelper;

/**
 *  lazy load _dataSource
 *
 *  @return NSMutableArray
 */
+ (NSMutableArray *)dataSource
{
    static NSMutableArray *dataSource = nil;
    static dispatch_once_t dataSourceOnceToken;
    
    
    dispatch_once(&dataSourceOnceToken,^{
        
        dbHelper = [GetManage getDbHelper];
            NSDictionary *dictionary = [dbHelper searchdata:@"Stalls"];
            dataSource = dictionary[@"yy"];
        
    });
    return dataSource;
}

/**
 *  lazy load _allTags
 *
 *  @return NSMutableArray
 */


@end
