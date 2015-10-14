#import "AddressCard.h"
#import <Foundation/NSString.h>
#import <stdio.h>

int main( int argc, const char *argv[] ) {
    NSString *first =[[NSString alloc] initWithCString: "Tom"];
    NSString *last = [[NSString alloc] initWithCString: "Jones"];
    NSString *email = [[NSString alloc] initWithCString: "tom@jones.com"];
    AddressCard *tom = [[AddressCard alloc] initWithFirst: first last: last email: email];

    // we'return done with the strings, so we must dealloc them
    [first release];
    [last release];
    [email release];

    // print to show the retain count
    printf( "Retain count: %i\n", [[tom first] retainCount] );
    [tom print];
    printf( "\n" );
    
    // free memory
    [tom release];

    return 0;
}
