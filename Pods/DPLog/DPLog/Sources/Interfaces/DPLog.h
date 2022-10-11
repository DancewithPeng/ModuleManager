//
//  DPLog.h
//  StealthCameraDetection
//
//  Created by 张鹏 on 2022/3/12.
//

#ifndef DPLog_h
#define DPLog_h

#import <Foundation/Foundation.h>

////! Project version number for DPLog.
//FOUNDATION_EXPORT double DPLogVersionNumber;
//
////! Project version string for DPLog.
//FOUNDATION_EXPORT const unsigned char DPLogVersionString[];



NSString * _DPLogSubjectText(const char *type, ...);

#define DPLogDebug(subject, ...) do { \
    [DPObjCLog debug:[NSString stringWithFormat:(_DPLogSubjectText(@encode(typeof(subject)), subject)), ##__VA_ARGS__, @""] \
                file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] \
            function:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] \
                line:__LINE__ \
                time:[NSDate date]]; \
} while(0)

#define DPLogInfo(subject, ...) do { \
    [DPObjCLog info:[NSString stringWithFormat:(_DPLogSubjectText(@encode(typeof(subject)), subject)), ##__VA_ARGS__, @""] \
               file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] \
           function:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] \
               line:__LINE__ \
               time:[NSDate date]]; \
} while(0)

#define DPLogWarning(subject, ...) do { \
    [DPObjCLog warning:[NSString stringWithFormat:(_DPLogSubjectText(@encode(typeof(subject)), subject)), ##__VA_ARGS__, @""] \
                  file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] \
              function:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] \
                  line:__LINE__ \
                  time:[NSDate date]]; \
} while(0)

#define DPLogError(subject, ...) do { \
    [DPObjCLog error:[NSString stringWithFormat:(_DPLogSubjectText(@encode(typeof(subject)), subject)), ##__VA_ARGS__, @""] \
                file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] \
            function:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] \
                line:__LINE__ \
                time:[NSDate date]]; \
} while(0)

#endif /* DPLog_h */
