//
//  NetWork.m
//  CityHelper
//
//  Created by MrLoong on 15/9/16.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import "NetWork.h"



@implementation NetWork

+(NSDictionary *)GET:(NSString *)URLString
          parmenters:(id)parmenters
          requesType:(id)requestType
        responseType:(id)responseType{
    
    return nil;
}
-(NSDictionary *)POST:(NSString *)URLString
          parmenters:(id)parmenters
          requesType:(id)requestType
        responseType:(id)responseType
             httpNum:(NSString *)httpRequesNum{
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:URLString
       parameters:parmenters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              _dictonary = responseObject;
              HttpRequesCenter <HttpProtocol> *object = [[HttpRequesCenter alloc]init];;
              [object httpMessage:_dictonary httpNumber:httpRequesNum];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
          }];

    return _dictonary;

}

@end
