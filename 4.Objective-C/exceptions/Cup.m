#import "Cup.h"
#import "CupOverflowException.h"
#import "CupWarningException.h"
#import <Foundation/NSException.h>
#import <Foundation/NSString.h>

@implementation Cup
-(id) init {
    self = [super init];

    if ( self ) {
        [self setLevel: 0];
    }

    return self;
}

-(int) level {
    return level;
}

-(void) setLevel: (int) l {
    level = l;

    if ( level > 100 ) {
        // throw overflow
        NSException *e = [CupOverflowException
            exceptionWithName: @"CupOverflowException"
            reason: @"The level is above 100"
            userInfo: nil];
        @throw e;
    } else if ( level >= 50 ) {
        // throw warning
        NSException *e = [CupWarningException
            exceptionWithName: @"CupWarningException"
            reason: @"The level is above or at 50"
            userInfo: nil];
        @throw e;
    } else if ( level < 0 ) {
        // throw exception
        NSException *e = [NSException
            exceptionWithName: @"CupUnderflowException"
            reason: @"The level is below 0"
            userInfo: nil];
        @throw e;
    }
}

-(void) fill {
    [self setLevel: level + 10];
}

-(void) empty {
    [self setLevel: level - 10];
}

-(void) print {
    printf( "Cup level is: %i\n", level );
}
@end
