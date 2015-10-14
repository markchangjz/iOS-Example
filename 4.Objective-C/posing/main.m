#import <stdio.h>
#import "Fraction.h"
#import "FractionB.h"

int main( int argc, const char *argv[] ) {
    Fraction *frac = [[Fraction alloc] initWithNumerator: 3 denominator: 10];

    // print it
    printf( "The fraction is: " );
    [frac print];
    printf( "\n" );

    // make FractionB pose as Fraction
    [FractionB poseAsClass: [Fraction class]];

    Fraction *frac2 = [[Fraction alloc] initWithNumerator: 3 denominator: 10];

    // print it
    printf( "The fraction is: " );
    [frac2 print];
    printf( "\n" );

    // free memory
    [frac release];
    [frac2 release];

    return 0;
}
