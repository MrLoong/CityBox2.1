//
//  HttpRequesCenter.m
//  CityHelper
//
//  Created by MrLoong on 15/9/16.
//  Copyright (c) 2015年 MrLoong. All rights reserved.
//

#import "HttpRequesCenter.h"

@interface HttpRequesCenter() <HttpProtocol>


@end


static NSMutableDictionary *_httpRequesDictionary = nil;

@implementation HttpRequesCenter

+(void)initialize{
    if(self==[HttpRequesCenter class]){
        _httpRequesDictionary = [NSMutableDictionary dictionary];
    }
}

+(void)createHttpReques:(NSString *)httpRequesNum{
    NSHashTable *hasTable = [self existhttpRequesNumber:httpRequesNum];
    
    if(hasTable == nil){
        hasTable = [NSHashTable weakObjectsHashTable];
        [_httpRequesDictionary setObject:hasTable forKey:httpRequesNum];
    
    }
    
}

+(void)addRequesClass:(id<HttpRequesCenterProtocol>)requseClass withCreateHttpReques:(NSString *)httpRequesNum POST:(NSString *)POST parmenters:(id)parmenters{
    NSHashTable *hashTable = [self existhttpRequesNumber:httpRequesNum];
    [hashTable addObject:requseClass];
    
    NetWork *netWork = [[NetWork alloc] init];
    [netWork POST:POST parmenters:parmenters requesType:nil responseType:nil httpNum:httpRequesNum];
}

+(void)sendMessageToClass:(id)message tohttpRequesNum:(NSString *)httpRequesNum{
    
    
    NSHashTable *hashTable = [self existhttpRequesNumber:httpRequesNum];
    if (hashTable) {

        NSEnumerator *enumerator = [hashTable objectEnumerator];
        id <HttpRequesCenterProtocol> object = nil;
        while (object = [enumerator nextObject]) {
            if ([object respondsToSelector:@selector(subscriptionMessage:httpNumber:)]) {
                
                if (message!=nil) {
                    [object subscriptionMessage:message httpNumber:httpRequesNum];
                }
            }
        }
    }
}

-(void)httpMessage:(id)message httpNumber:(NSString *)httpNumber{
    [HttpRequesCenter sendMessageToClass:message tohttpRequesNum:httpNumber];
}



#pragma mark - 私有方法
+ (NSHashTable *)existhttpRequesNumber:(NSString *)subscriptionNumber {
    
    return [_httpRequesDictionary objectForKey:subscriptionNumber];
}

@end
