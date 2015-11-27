//
//  DbHelper.h
//  CityHelper
//
//  Created by MrLoong on 15/10/7.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DbHelper : NSObject

@property(nonatomic,retain) NSManagedObjectContext *context;

/**
 *  初始化数据
 *
 */
-(void)LoadData;

/**
 *  添加数据
 *
 */
-(void)addData:(NSString *) data type:(NSString *)type;

/**
 *  检索数据
 *
 */
-(NSDictionary *)searchdata :(NSString *)type;

/**
 *  更新数据
 *
 */
-(void)UdataData;

/**
 *  删除数据
 *
 */
-(void)deleteData;
-(void)deleteStalls;

/**
 *  检查数据是否存在
 *
 */
-(NSString *)searchCheck :(NSString *)type;


/**
 *  添加数据标记
 *
 */

-(void)addCheck:(NSString *) check type:(NSString *)type;

@end
