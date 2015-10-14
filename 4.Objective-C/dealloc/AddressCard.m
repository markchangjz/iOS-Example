#import "AddressCard.h"
#import <stdio.h>

@implementation AddressCard
-(AddressCard*) initWithFirst: (NSString*) f last: (NSString*) l email: (NSString*) e {
    self = [super init];

    if ( self ) {
        [self setFirst: f last: l email: e];
    }

    return self;
}

-(NSString*) first {
    return first;
}

-(NSString*) last {
    return last;
}

-(NSString*) email {
    return email;
}

-(void) setFirst: (NSString*) f {
    [f retain];
    [first release];
    first = f;
}

-(void) setLast: (NSString*) l {
    [l retain];
    [last release];
    last = l;
}

-(void) setEmail: (NSString*) e {
    [e retain];
    [email release];
    email = e;
}

-(void) setFirst: (NSString*) f last: (NSString*) l email: (NSString*) e {
    [self setFirst: f];
    [self setLast: l];
    [self setEmail: e];
}

-(void) setFirst: (NSString*) f last: (NSString*) l {
    [self setFirst: f];
    [self setLast: l];
}

-(void) print {
    printf( "%s %s <%s>", [first cString], [last cString], [email cString] );
}

-(void) dealloc {
    [first release];
    [last release];
    [email release];

    [super dealloc];
}
@end
