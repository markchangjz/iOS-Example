#import <stdio.h>
#import "Fraction.h"
#import "FractionMath.h"

int main( int argc, const char *argv[] ) {
    // create a new instance
    Fraction *frac1 = [[Fraction alloc] initWithNumerator: 1 denominator: 3];
    Fraction *frac2 = [[Fraction alloc] initWithNumerator: 2 denominator: 5];
    Fraction *frac3 = [frac1 mul: frac2];

    // print it
    [frac1 print];
    printf( " * " );
    [frac2 print];
    printf( " = " );
    [frac3 print];
    printf( "\n" );

    // free memory
    [frac1 release];
    [frac2 release];
    [frac3 release];

    return 0;
}
