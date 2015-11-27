//
//  FoodviewCell.m
//  CityBox
//
//  Created by LastDay on 15/11/22.
//  Copyright © 2015年 MrLoong. All rights reserved.
//

#import "FoodviewCell.h"
#import "Menu.h"
#import "Order.h"
#import "ViewController.h"


@implementation FoodviewCell



- (void)awakeFromNib {
    // Initialization code
    
    _selectNumber.minimumValue = 0;
    _selectNumber.stepValue = 1;
    _number.text = @"0";
    
    
    [ViewController getOrder].address = @" ";
    [ViewController getOrder].phoneNum = @" ";
    [ViewController getOrder].totalPrice = @" ";
    [ViewController getOrder].commission = @" ";
    [ViewController getOrder].remarks = @" ";
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _number.userInteractionEnabled = NO;
    
    [_selectNumber addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventValueChanged];

    // Configure the view for the selected state
}

-(void)stepperAction:(UIStepper *)stepper{
    [_number setText:[NSString stringWithFormat: @"%d", (int)stepper.value]];
//    NSLog(@"食堂%@",self.Canteen);
//    NSLog(@"档口%@",self.Stalls);
//    NSLog(@"数量%@",_number.text);
//    NSLog(@"单价%@",self.price.text);
//    NSLog(@"菜名%@",self.textLabel.text);
    Menu *menu  = [[Menu alloc]init];
    menu.Canteen = self.Canteen;
    menu.Stalls = _Stalls;
    menu.number =_number.text;
    menu.unitPrice = self.price.text;
    menu.dishesName = self.textLabel.text;
    
    if([self judgeExistName:menu.dishesName]){
        for (Menu *obj in [ViewController getOrder].menuArry) {
            if([obj.dishesName isEqual:menu.dishesName]){
//                NSLog(@"前：%@",obj.number);
                NSLog(@"更新数据");
                obj.number = menu.number;
                
//                NSLog(@"后：%@",obj.number);
            }
        }
        
        
    }else{
        NSLog(@"添加数据");
        [[ViewController getOrder].menuArry addObject:menu];
        NSLog(@"%lu",(unsigned long)[ViewController getOrder].menuArry.count);
    }

}

//判断移交表单中是否存在相同元素
-(Boolean)judgeExistName:(NSString *)dishesName{
    for (Menu *obj in [ViewController getOrder].menuArry) {
        if([obj.dishesName isEqual:dishesName]){
            return YES;
        }
        
    }
    return NO;
}

@end
