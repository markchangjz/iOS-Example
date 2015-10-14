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
- (double)popOperand;
- (double)performOperation:(NSString *)operation;

@end
