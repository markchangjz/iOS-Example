//
//  CalculatorBrain.m
//  Calculator
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic, strong) NSMutableArray *programeStack;
@end

@implementation CalculatorBrain
@synthesize programeStack = _programeStack;

- (NSMutableArray *)programeStack
{
    if (_programeStack == nil) {
        _programeStack = [[NSMutableArray alloc] init];
    }
    
    return _programeStack;
}

- (void)pushOperand:(double)operand
{
    [self.programeStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    [self.programeStack addObject:operation];
    return [CalculatorBrain runPrograme:self.program];
}

- (id)program
{
    return [self.programeStack copy];
}

+ (NSString *)descriptionOfPrograme:(id)programe
{
    return @"Homework 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"-"]) {
            double subsrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subsrahend;
        }
        else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) {
                result = [self popOperandOffStack:stack] / divisor;
            }
        }    
    }    
    
    return result;
}

+ (double)runPrograme:(id)programe
{
    NSMutableArray *stack;
    
    if ([programe isKindOfClass:[NSArray class]]) {
        stack = [programe mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}

@end
