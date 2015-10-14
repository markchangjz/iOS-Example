#import <Foundation/NSObject.h>

@interface Cup: NSObject {
    int level;
}

-(int) level;
-(void) setLevel: (int) l;
-(void) fill;
-(void) empty;
-(void) print;
@end
