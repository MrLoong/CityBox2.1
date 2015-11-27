//
//  CYLDBManager.h
//  CityHelper
//
//  Created by MrLoong on 15/10/11.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetManage.h"


extern NSString *const kDataSourceSectionKey;
extern NSString *const kDataSourceCellTextKey;
extern NSString *const kDataSourceCellPictureKey;

@interface CYLDBManager : NSObject

+ (NSMutableArray *)dataSource;


@end
