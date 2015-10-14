//
//  CalculatorBrain.m
//  Calculator
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;    
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:@"-"]) {
        double pop1 = [self popOperand];
        double pop2 = [self popOperand];
        result = pop2 - pop1;
    }
    else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"/"]) {
        double pop1 = [self popOperand];
        double pop2 = [self popOperand];
        result = pop2 / pop1;
    }    
    
    [self.operandStack addObject:[NSNumber numberWithDouble:result]];
    
    return result;
}

@end
