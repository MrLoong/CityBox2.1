#城市学院小助手

欢迎大家来提价代码

* UIT 215 LastDays


引用了cocapods对AF进行管理 



##遍历所有课表


~~~
_i=0;
    _dbHelper = [GetManage getDbHelper];
    _message = [_dbHelper searchdata];
    _week = [NSArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu",@"Fri",@"Sat",@"Sun",nil];
    _number = [NSArray arrayWithObjects:@"1-2", @"3-4", @"5-6", @"7-8",@"9-10",@"11-12",nil];
    _weekNameString = [NSArray arrayWithObjects:@"UIT", @"周一", @"周二", @"周三",@"周四",@"周五",@"周六",@"周日",nil];
    _classNumberString = [NSArray arrayWithObjects:@"1~2", @"3~4", @"5~6", @"7~8",@"9~10",@"11~12",nil];
    
    
    
    NSArray *type = [NSArray arrayWithObjects:0,1, nil];
    
        for (int i = 1; i<=20; i++) {    //周数
            NSLog(@"%i ==========================",i);
            for (int j=0; j<week.count; j++) {    //星期
                for (int k = 0; k< number.count; k++) {   //节数
    
                    NSArray *type = message[@"schedule"][week[j]][number[k]];  //课程
    
                    for (int m=0;m<type.count; m++) {
                        if ((NSNull *)message[@"schedule"][week[j]][number[k]][m]!=[NSNull null]&&[message[@"schedule"][week[j]][number[k]][m][@"weeks"] indexOfObject:[NSNumber numberWithInteger:i]]!=NSNotFound) {
                            NSLog(@"周数:%i  星期：%@： 节数：%@  课程：%@  地址：%@   老师：%@",i,week[j],number[k],message[@"schedule"][week[j]][number[k]][m][@"class_name"],message[@"schedule"][week[j]][number[k]][m][@"classrom"],message[@"schedule"][week[j]][number[k]][m][@"teacher_name"]);
                        }
                    }
                }
            }
        }
~~~

