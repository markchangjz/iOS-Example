#import <Foundation/NSAutoreleasePool.h>
#import "Fraction.h"
#import <stdio.h>

int main( int argc, const char *argv[] ) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    Fraction *frac1 = [Fraction fractionWithNumerator: 2 denominator: 5];
    Fraction *frac2 = [Fraction fractionWithNumerator: 1 denominator: 3];

    // print frac 1
    printf( "Fraction 1: " );
    [frac1 print];
    printf( "\n" );

    // print frac 2
    printf( "Fraction 2: " );
    [frac2 print];
    printf( "\n" );

    // this causes a segmentation fault
    //[frac1 release];

    // release the pool and all objects in it
    [pool release];
    return 0;
}
