//
//  CalculatorBrain.h
//  Calculator
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (readonly) id program;
+ (double)runPrograme:(id)programe;
+ (NSString *)descriptionOfPrograme:(id)programe;

@end
