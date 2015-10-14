#import "Square.h"
#import "Rectangle.h"
#import <stdio.h>

int main( int argc, const char *argv[] ) {
    Rectangle *rec = [[Rectangle alloc] initWithWidth: 10 height: 20];
    Square *sq = [[Square alloc] initWithSize: 15];

    // isMemberOfClass

    // true 
    if ( [sq isMemberOfClass: [Square class]] == YES ) {
        printf( "square is a member of square class\n" );
    }

    // false
    if ( [sq isMemberOfClass: [Rectangle class]] == YES ) {
        printf( "square is a member of rectangle class\n" );
    }

    // false
    if ( [sq isMemberOfClass: [NSObject class]] == YES ) {
        printf( "square is a member of object class\n" );
    }

    // isKindOfClass
    
    // true 
    if ( [sq isKindOfClass: [Square class]] == YES ) {
        printf( "square is a kind of square class\n" );
    }

    // true
    if ( [sq isKindOfClass: [Rectangle class]] == YES ) {
        printf( "square is a kind of rectangle class\n" );
    }

    // true
    if ( [sq isKindOfClass: [NSObject class]] == YES ) {
        printf( "square is a kind of object class\n" );
    }

    // respondsToSelector

    // true
    if ( [sq respondsToSelector: @selector( setSize: )] == YES ) {
        printf( "square responds to setSize: method\n" );
    }

    // false
    if ( [sq respondsToSelector: @selector( nonExistant )] == YES ) {
        printf( "square responds to nonExistant method\n" );
    }

    // true
    if ( [Square respondsToSelector: @selector( alloc )] == YES ) {
        printf( "square class responds to alloc method\n" );
    }


    // instancesRespondToSelector

    // false
    if ( [Rectangle instancesRespondToSelector: @selector( setSize: )] == YES ) {
        printf( "rectangle instance responds to setSize: method\n" );
    }

    // true
    if ( [Square instancesRespondToSelector: @selector( setSize: )] == YES ) {
        printf( "square instance responds to setSize: method\n" );
    }

    // free memory
    [rec release];
    [sq release];
    
    return 0;
}
