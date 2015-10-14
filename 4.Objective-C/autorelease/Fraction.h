#import <Foundation/NSObject.h>

@interface Fraction: NSObject {
    int numerator;
    int denominator;
}

+(Fraction*) fractionWithNumerator: (int) n denominator: (int) d;
-(Fraction*) initWithNumerator: (int) n denominator: (int) d;
-(void) print;
-(void) setNumerator: (int) d;
-(void) setDenominator: (int) d;
-(void) setNumerator: (int) n andDenominator: (int) d;
-(int) numerator;
-(int) denominator;
@end

