//
//  main.m
//  KVC
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 Key-Value Coding
 類似 NSDictionary 資料一層一層解
 參考網址:http://cupsofcocoa.com/2011/05/09/objective-c-lesson-13-key-value-coding/
 */

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Community.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Person *a = [[Person alloc] initWithName:@"A_name"];
        Person *b = [[Person alloc] initWithName:@"B_name"];
        Person *c = [[Person alloc] initWithName:@"C_name"];

        Community *lost = [[Community alloc] init];

        [a setValue:@[b, c, c] forKey:@"allies"];                       // a.allies = @[b, c, c] (allies : NSArray)
        [b setValue:@[a] forKey:@"allies"];                             // b.allies = @[a]
        [c setValue:@[b] forKey:@"allies"];                             // c.allies = @[b]
        
        [a setValue:[NSNumber numberWithFloat:100.1] forKey:@"price"];  // a.price = 100.1 (price : NSNumber)
        [b setValue:[NSNumber numberWithFloat:200.2] forKey:@"price"];  // b.price = 200.2
        [c setValue:[NSNumber numberWithFloat:300.3] forKey:@"price"];  // c.price = 300.3
               
        [a setValue:b forKey:@"lover"];                                 // a.lover = b (lover : Person)
        [b setValue:c forKey:@"lover"];                                 // b.lover = c
        
        [lost setValue:@[a, b, c] forKeyPath:@"population"];            // lost.population = @[a, b, c] (population : NSArray)
        
        NSArray *theArray = [[NSArray alloc] init];
        theArray = [lost valueForKeyPath:@"population"];
        theArray = [lost valueForKeyPath:@"population.name"];
//        theArray = [lost valueForKeyPath:@"population.allies"];
//        theArray = [lost valueForKeyPath:@"population.allies.name"];
//        theArray = [lost valueForKeyPath:@"population.allies.allies"];
//        theArray = [lost valueForKeyPath:@"population.allies.allies.name"];
//        theArray = [lost valueForKeyPath:@"population.allies.name"];
//        theArray = [lost valueForKeyPath:@"population.lover"];
//        theArray = [lost valueForKeyPath:@"population.lover.allies.name"];
//        theArray = [lost valueForKeyPath:@"population.price"];
        
        // test 1 (顯示不同 valueForKeyPath 的資料) ===========================================================================
        for (Person *tmp in theArray) {
            NSLog(@"%@", tmp);
        }        
        
        // test 2 (印出資料) =================================================================================================     
//        theArray = [lost valueForKeyPath:@"population.allies.name"];
//        
//        NSMutableSet *uniqueAllies = [NSMutableSet setWithCapacity:5];
//        for (NSArray *a in theArray) {
//            if (![a isMemberOfClass:[NSNull class]]) {
//                for (NSString *n in a) {
//                    NSLog(@"%@", n);
//                    [uniqueAllies addObject:n];
//                }
//            }
//        }
//        
//        NSLog(@"%@", uniqueAllies);
        
        // test 3 (@count:個數, @sum:總和, @avg:平均, @max:最大值, @min:最小值, @distinctUnionOfObjects:列出不重複的資料) ==========
//        NSLog(@"count = %d", [[lost valueForKeyPath:@"population.@count"] intValue]);
//        NSLog(@"count = %d", [[a valueForKeyPath:@"allies.@count"] intValue]);        
//        NSLog(@"sum.price = %f", [[lost valueForKeyPath:@"population.@sum.price"] doubleValue]);
//        NSLog(@"max.price = %f", [[lost valueForKeyPath:@"population.@max.price"] doubleValue]);
//        NSLog(@"min.price = %f", [[lost valueForKeyPath:@"population.@min.price"] doubleValue]);
//        NSLog(@"avg.price = %f", [[lost valueForKeyPath:@"population.@avg.price"] doubleValue]);
//        NSLog(@"distinctUnionOfObjects.allies.name = %@", [a valueForKeyPath:@"allies.@distinctUnionOfObjects.allies.name"]);
    }
    return 0;
}

