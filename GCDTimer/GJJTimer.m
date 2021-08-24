//
//  GJJTimer.m
//  GCDTimer
//
//  Created by 耿俊杰 on 2021/8/24.
//

#import "GJJTimer.h"

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;

@implementation GJJTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)timerWithStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void (^)(void))task {
    if (!task || (repeats && interval <= 0)) return nil;
    
    dispatch_queue_t queue = async? dispatch_get_global_queue(0, 0):dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC), interval*NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *name = [NSString stringWithFormat:@"%ld", timers_.count];
    timers_[name]= timer;
    dispatch_semaphore_signal(semaphore_);
     
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self stopTimer:name];
        }
    });
    
    dispatch_resume(timer);
    
    return name;
}

+ (NSString *)timerWithTarget:(id)target select:(SEL)select start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!target || !select)  return nil;
    
    __weak typeof(target) weakTarger = target;
    return [self timerWithStart:start interval:interval repeats:repeats async:async task:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([weakTarger respondsToSelector:select]) {
            [weakTarger performSelector:select];
        }
#pragma clang diagnostic pop
    }];
}

+ (void)stopTimer:(NSString *)name {
    if (!name) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    if (timers_[name]) {
        dispatch_source_cancel(timers_[name]);
        [timers_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(semaphore_);
}

@end
