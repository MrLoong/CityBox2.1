//
//  ViewController.h
//  CityBox
//
//  Created by LastDay on 15/11/17.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

static Order *orders;
@interface ViewController : UIViewController

+(Order *)getOrder;

@end

