#import <Foundation/NSObject.h>
#import "Printing.h"

@interface Complex: NSObject <Printing> {
    double real;
    double imaginary;
}

-(Complex*) initWithReal: (double) r andImaginary: (double) i;
-(void) setReal: (double) r;
-(void) setImaginary: (double) i;
-(void) setReal: (double) r andImaginary: (double) i;
-(double) real;
-(double) imaginary;
@end
