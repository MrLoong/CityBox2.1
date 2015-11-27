//
//  HttpRequesCenter.h
//  CityHelper
//
//  Created by MrLoong on 15/9/16.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequesCenterProtocol.h"
#include "NetWork.h"

@interface HttpRequesCenter : NSObject

/**
 *  创建一个HTTP请求
 *
 *  @param httpRequesNum 请求编号
 */


+(void)createHttpReques:(NSString *)httpRequesNum;


/**
 *  移除一个HTTP请求
 *
 *  @param httpRequesNum 请求编号
 */
+(void)removeHttpReques:(NSString *)httpRequesNum;



/**
 *  在具体的请求中添加请求Class
 *
 *  @param requseClass   请求类
 *  @param httpRequesNum Http请求编号
 */
+(void)addRequesClass:(id<HttpRequesCenterProtocol>)requseClass withCreateHttpReques:(NSString *)httpRequesNum POST:(NSString *)POST parmenters:(id)parmenters;


/**
 *  从具体请求中移除请求Class
 *
 *  @param requseClass   请求类
 *  @param httpRequesNum Http请求编号
 */
+(void)removeRequesClass:(id<HttpRequesCenterProtocol>)requseClass withCreateHttpReques:(NSString *)httpRequesNum;



/**
 *  发送消息给具体请求编号
 *
 *  @param message       发送信息
 *  @param httpRequesNum 请求编号
 */
+(void)sendMessageToClass:(id)message tohttpRequesNum:(NSString *)httpRequesNum;

@end
