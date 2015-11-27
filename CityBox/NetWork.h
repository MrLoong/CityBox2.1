//
//  NetWork.h
//  CityHelper
//
//  Created by MrLoong on 15/9/16.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#include "HttpProtocol.h"
#import "HttpRequesCenter.h"

@interface NetWork : NSObject


@property NSDictionary *dictonary;

/**
 *  GEt请求
 *
 *  @param URLString    URL地址
 *  @param parmenters   网络参数
 *  @param requestType  请求类型
 *  @param responseType 返回值类型
 *
 *  @return 返回NSDictionary
 */
+(NSDictionary *)GET:(NSString *)URLString
          parmenters:(id)parmenters
          requesType:(id)requestType
        responseType:(id)responseType;


/**
 *  POST请求
 *
 *  @param URLString    URL地址
 *  @param parmenters   网络参数
 *  @param requestType  请求类型
 *  @param responseType 返回值类型
 *
 *  @return 返回NSDictionary
 */
-(NSDictionary *)POST:(NSString *)URLString
          parmenters:(id)parmenters
          requesType:(id)requestType
        responseType:(id)responseType
             httpNum:(NSString *)httpRequesNum;

@end
