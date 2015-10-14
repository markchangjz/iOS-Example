#import <Foundation/NSObject.h>

@interface Complex: NSObject {
    double real;
    double imaginary;
}

-(Complex*) initWithReal: (double) r andImaginary: (double) i;
-(void) setReal: (double) r;
-(void) setImaginary: (double) i;
-(void) setReal: (double) r andImaginary: (double) i;
-(double) real;
-(double) imaginary;
-(void) print;

@end
