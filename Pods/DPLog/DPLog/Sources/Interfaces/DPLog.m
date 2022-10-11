//
//  DPLog.m
//  StealthCameraDetection
//
//  Created by 张鹏 on 2022/3/12.
//

#import "DPLog.h"

#ifdef DPLOG_USE_IN_UIKIT
#import <UIKit/UIKit.h>
#endif

NSString * _DPLogSubjectText(const char *type, ...) {
    
    va_list args;
    va_start(args, type);
    
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(args, id);
        return [NSString stringWithFormat:@"%@", actual];
    }
    
#ifdef DPLOG_USE_IN_UIKIT
    
    if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(args, CGPoint);
        return NSStringFromCGPoint(actual);
    }
    
    if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(args, CGSize);
        return NSStringFromCGSize(actual);
    }
    
    if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect actual = (CGRect)va_arg(args, CGRect);
        return NSStringFromCGRect(actual);
    }
    
    if (strcmp(type, @encode(CGVector)) == 0) {
        CGVector actual = (CGVector)va_arg(args, CGVector);
        return NSStringFromCGVector(actual);
    }
    
    if (strcmp(type, @encode(CGAffineTransform)) == 0) {
        CGAffineTransform actual = (CGAffineTransform)va_arg(args, CGAffineTransform);
        return NSStringFromCGAffineTransform(actual);
    }
    
#endif
    
    if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(args, double);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(args, double);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(args, int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(args, long);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(args, long long);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(args, int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(args, int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(args, int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(args, unsigned int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(args, unsigned int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(args, unsigned long);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(args, unsigned long long);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(args, unsigned int);
        return [NSString stringWithFormat:@"%@", @(actual)];
    }
    
    va_end(args);
        
    return [NSString stringWithFormat:@"%s", type];
}
