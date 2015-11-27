//
//  DbHelper.m
//  CityHelper
//
//  Created by MrLoong on 15/10/7.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "DbHelper.h"

@implementation DbHelper

-(void)LoadData{
    NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
    for (NSEntityDescription *desc in model.entities) {
        NSLog(@"%@",desc.name);
    }
    NSPersistentStoreCoordinator *storeCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *document= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    document=[document stringByAppendingPathComponent:@"coredata.db"];
    NSURL *url=[NSURL fileURLWithPath:document];
    NSError *error=nil;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if(error){
        NSLog(@"打开数据库失败");
        return;
    }
    
    self.context=[[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator=storeCoordinator;
}

-(void)addData:(NSString *) data type:(NSString *)type{
    

        //把实体对象和实体上下文相关联
        NSManagedObject *obj=[NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:self.context];
        [obj setValue: data forKey:@"data"];
        [obj setValue: @"yes" forKey:@"check"];

        //保存上下文中相关联的对象即可
        [self.context save:nil];
}


-(NSDictionary *)searchdata :(NSString *)type{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:type];
    NSDictionary *message;
    NSArray *arr=[self.context executeFetchRequest:fetch error:nil];
    for (NSManagedObject *mode in arr) {
        message = [mode valueForKey:@"data"];
    }
    return message;
}


-(NSString *)searchCheck :(NSString *)type{
    NSString *checkString = @"no";
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:type];
    NSArray *arr=[self.context executeFetchRequest:fetch error:nil];
    for (NSManagedObject *mode in arr) {
        NSString *data=[mode valueForKey:@"check"];
        checkString = data;
    }
    return checkString;
}


-(void)UdataData{
    NSFetchRequest *Fetch=[NSFetchRequest fetchRequestWithEntityName:@"Users"];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    Fetch.sortDescriptors=@[sort];
    Fetch.predicate=[NSPredicate predicateWithFormat:@"age>%i",5];
    NSArray * arr=[self.context executeFetchRequest:Fetch error:nil];
    for (NSManagedObject *obj in arr) {
        [obj setValue:@(50) forKey:@"age"];
    }
    [self.context save:nil];
}


-(void)deleteData{
    NSFetchRequest *FectchRequest=[NSFetchRequest fetchRequestWithEntityName:@"ClassData"];
    NSArray *arr=[self.context executeFetchRequest:FectchRequest error:nil];
    for (NSManagedObject *obj in arr) {
        
        [self.context deleteObject:obj];
    }
    [self.context save:nil];
}
-(void)deleteStalls{
    NSFetchRequest *FectchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Stalls"];
    NSArray *arr=[self.context executeFetchRequest:FectchRequest error:nil];
    for (NSManagedObject *obj in arr) {
        
        [self.context deleteObject:obj];
    }
    [self.context save:nil];
}


@end
