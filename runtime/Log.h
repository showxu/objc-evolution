//
//  Log.h
// 
//  Created by Xudong Xu on 2016/12/1.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

_Pragma("once")

#ifdef __OBJC__
 
#define NSLog(format, ...)  \
     do {   \
         fprintf(stderr, "<%s : %d> %s\n",  \
             [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
             __LINE__,  \
            __func__);  \
         (NSLog)((format), ##__VA_ARGS__); \
         fprintf(stderr, "-----------\n"); \
     } while (0)
#endif
