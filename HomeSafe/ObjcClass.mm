#import "main.h"

@interface ObjcClass ()

@property (nonatomic, readonly) CppClass* internal;

@end

@implementation ObjcClass

- (instancetype) init
{
    return [self initWithString:nil];
}

- (instancetype) initWithString:(NSString*) string
{
    self = [super init];
    
    if(self != nil)
    {
        _internal = new CppClass(string.UTF8String);
    }
    
    return self;
}

#pragma mark -
#pragma mark Self

- (NSString*) string
{
    const char* string = self.internal->string();
    return string ? @(string) : nil;
}

- (void) setString:(NSString*) string
{
    self.internal->set_string(string.UTF8String);
}

#pragma mark -
#pragma mark Cleanup

- (void) dealloc
{
    delete _internal;
}

@end
