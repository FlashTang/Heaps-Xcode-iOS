#import <Cocoa/Cocoa.h>

#define HL_NAME(n) mac_native_##n

#include <hl.h>
#include <stdlib.h>
// #include <_std/String.h>
#include <string.h>

//#import <Cocoa/Cocoa.h>
HL_PRIM float HL_NAME(get_native_scale)()
{
    
   // char * data = hl_to_utf8((uchar*)msg->bytes);
    
    return [NSScreen mainScreen].backingScaleFactor;
}

 
DEFINE_PRIM(_F32,get_native_scale, _NO_ARG);