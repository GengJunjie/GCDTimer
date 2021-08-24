//
//  GJJTimer.h
//  GCDTimer
//
//  Created by 耿俊杰 on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJJTimer : NSObject

+ (NSString *)timerWithStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void(^)(void))task;

+ (NSString *)timerWithTarget:(id)target select:(SEL)select start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async;

+ (void)stopTimer:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
