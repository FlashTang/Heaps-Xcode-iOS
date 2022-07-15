#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

// @interface OC_Native : NSObject{
// }
// +(void) PrintHello:(NSString *) pram;
// @end


// @implementation OC_Native

// + (void) PrintHello:(NSString *) pram {
//     float scale = [UIScreen mainScreen].nativeScale;
//     NSLog(@"=======scale==>%f<=========",scale);
//  }

// + (UIWindow*) keyWindow {
//    NSPredicate *isKeyWindow = [NSPredicate predicateWithFormat:@"isKeyWindow == YES"];
//    return [[[UIApplication sharedApplication] windows] filteredArrayUsingPredicate:isKeyWindow].firstObject;
// }
// @end


#define HL_NAME(n) iostools_##n

#include <hl.h>
#include <stdlib.h>
#include <_std/String.h>
#include <string.h>

//#import <Cocoa/Cocoa.h>
HL_PRIM float HL_NAME(get_pixel_ratio)()
{
    
   // char * data = hl_to_utf8((uchar*)msg->bytes);
    
    return [UIScreen mainScreen].nativeScale;
}

 
DEFINE_PRIM(_F32,get_pixel_ratio, _NO_ARG);






