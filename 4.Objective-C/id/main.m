#import <stdio.h>
#import "Fraction.h"
#import "Complex.h"

int main( int argc, const char *argv[] ) {
    // create a new instance
    Fraction *frac = [[Fraction alloc] initWithNumerator: 1 denominator: 10];
    Complex *comp = [[Complex alloc] initWithReal: 10 andImaginary: 15];
    id number;

    // print fraction
    number = frac;
    printf( "The fraction is: " );
    [number print];
    printf( "\n" );

    // print complex
    number = comp;
    printf( "The complex number is: " );
    [number print];
    printf( "\n" );

    // free memory
    [frac release];
    [comp release];

    return 0;
}
