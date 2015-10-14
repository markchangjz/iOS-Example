#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>

@interface AddressCard: NSObject {
    NSString *first;
    NSString *last;
    NSString *email;
}

-(AddressCard*) initWithFirst: (NSString*) f last: (NSString*) l email: (NSString*) e;
-(NSString*) first;
-(NSString*) last;
-(NSString*) email;
-(void) setFirst: (NSString*) f;
-(void) setLast: (NSString*) l;
-(void) setEmail: (NSString*) e;
-(void) setFirst: (NSString*) f last: (NSString*) l email: (NSString*) e;
-(void) setFirst: (NSString*) f last: (NSString*) l;
-(void) print;
@end
