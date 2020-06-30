#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DPLog.h"
#import "DPLogObjC.h"

FOUNDATION_EXPORT double DPLogVersionNumber;
FOUNDATION_EXPORT const unsigned char DPLogVersionString[];

