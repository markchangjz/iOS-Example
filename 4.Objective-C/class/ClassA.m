#import "ClassA.h"

@implementation ClassA
-(id) init {
    self = [super init];
    count++;
    return self;
}

+(int) initCount {
    return count;
}

+(void) initialize {
    count = 0;
}
@end
