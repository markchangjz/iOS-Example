#import "Cup.h"
#import "CupOverflowException.h"
#import "CupWarningException.h"
#import <Foundation/NSString.h>
#import <Foundation/NSException.h>
#import <Foundation/NSAutoreleasePool.h>
#import <stdio.h>

int main( int argc, const char *argv[] ) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    Cup *cup = [[Cup alloc] init];
    int i;

    // this will work
    for ( i = 0; i < 4; i++ ) {
        [cup fill];
        [cup print];
    }

    // this will throw exceptions
    for ( i = 0; i < 7; i++ ) {
        @try {
            [cup fill];
        } @catch ( CupWarningException *e ) {
            printf( "%s: ", [[e name] cString] );
        } @catch ( CupOverflowException *e ) {
            printf( "%s: ", [[e name] cString] );
        } @finally {
            [cup print];
        }
    }

    // throw a generic exception
    @try {
        [cup setLevel: -1];
    } @catch ( NSException *e ) {
        printf( "%s: %s\n", [[e name] cString], [[e reason] cString] );
    }

    // free memory 
    [cup release];
    [pool release];
}
