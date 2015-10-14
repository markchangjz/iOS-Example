#import "MyClass.h"

int main( int argc, const char *argv[] ) {
    MyClass *obj = [[MyClass alloc] init];

    // this compiles
    [obj publicMethod];

    // this throws errors when compiling
    //[obj privateMethod];

    // free memory
    [obj release];
    
    return 0;
}
