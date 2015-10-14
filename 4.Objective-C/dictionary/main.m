#import <Foundation/NSString.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/Foundation.h>
#import <stdio.h>

void print( NSDictionary *map ) {
    NSEnumerator *enumerator = [map keyEnumerator];
    id key;

    while ( key = [enumerator nextObject] ) {
        printf( "%s => %s\n",
                [[key description] cString],
                [[[map objectForKey: key] description] cString] );
    }
}

int main( int argc, const char *argv[] ) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
        @"one", [NSNumber numberWithInt: 1],
        @"two", [NSNumber numberWithInt: 2],
        @"three", [NSNumber numberWithInt: 3],
        nil];
    NSMutableDictionary *mutable = [[NSMutableDictionary alloc] init];

    // print dictionary
    printf( "----static dictionary\n" );
    print( dictionary );
    
    // add objects
    [mutable setObject: @"Tom" forKey: @"tom@jones.com"];
    [mutable setObject: @"Bob" forKey: @"bob@dole.com" ];

    // print mutable dictionary
    printf( "----mutable dictionary\n" );
    print( mutable );

    // free memory 
    [dictionary release];
    [mutable release];
    [pool release];

    return 0;
}
