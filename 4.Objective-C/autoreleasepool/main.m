#import <Foundation/NSString.h>
#import <Foundation/NSAutoreleasePool.h>
#import <stdio.h>

int main( int argc, const char *argv[] ) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *str1 = @"constant string";
    NSString *str2 = [NSString stringWithString: @"string managed by the pool"];
    NSString *str3 = [[NSString alloc] initWithString: @"self managed string"];

    // print the strings
    printf( "%s retain count: %x\n", [str1 cString], [str1 retainCount] );
    printf( "%s retain count: %x\n", [str2 cString], [str2 retainCount] );
    printf( "%s retain count: %x\n", [str3 cString], [str3 retainCount] );

    // free memory
    [str3 release];

    // free pool
    [pool release];
    return 0;
}
