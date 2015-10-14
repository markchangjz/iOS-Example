#import "Complex.h"
#import <stdio.h>

@implementation Complex
-(Complex*) initWithReal: (double) r andImaginary: (double) i {
    self = [super init];

    if ( self ) {
        [self setReal: r andImaginary: i];
    }

    return self;
}

-(void) setReal: (double) r {
    real = r;
}

-(void) setImaginary: (double) i {
    imaginary = i;
}

-(void) setReal: (double) r andImaginary: (double) i {
    real = r;
    imaginary = i;
}

-(double) real {
    return real;
}

-(double) imaginary {
    return imaginary;
}

-(void) print {
    printf( "%_f + %_fi", real, imaginary );
}

@end
