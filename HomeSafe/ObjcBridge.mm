//
//  ObjcBridge.m
//  HomeSafe
//
//  Created by Aaron Lee on 11/13/16.
//
//

#import <Foundation/Foundation.h>
#include "main.h"
#include <vector>
#include <utility>

@interface ObjClass : NSObject
@property (nonatomic, readonly) City* internal;

@end

@implementation ObjClass

- (instancetype) init
{
    
}


#pragma mark -
#pragma mark Self
- (void) load_street
{
    self.internal->load_street();
}

- (void) push_event:(double*)latitude : (double*)longitude : (double*)danger : (double*)radius
{
    self.internal->push_event(*latitude, *longitude, *danger, *radius);
}
- (NSMutableArray*) Astar (double*)start_lat : (double*)start_lon : (double*)goal_lat : (double*)goal_lon
{
    const NSMutableArray* array = self.internal->Astar(*start_lat, *start_lon, *goal_lat, *goal_lon);
    return array ? @(array) : nil;
}
#pragma mark -
#pragma mark Cleanup

- (void) dealloc
{
    delete _internal;
}

@end
