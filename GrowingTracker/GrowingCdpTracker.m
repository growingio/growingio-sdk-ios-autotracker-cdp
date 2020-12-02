//
//  GrowingCdpRealTracker.m
//  GrowingAnalytics-Autotracker-AutotrackerCore-Tracker-TrackerCore
//
//  Created by sheng on 2020/11/24.
//  Copyright (C) 2017 Beijing Yishu Technology Co., Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "GrowingCdpTracker.h"
#import "GrowingArgumentChecker.h"
#import "GrowingEventManager.h"
#import "GrowingTrackConfiguration.h"
#import "GrowingResourceCustomEvent.h"
#import "GrowingDispatchManager.h"
#import "GrowingCdpEventInterceptor.h"
#import "GrowingLogMacros.h"
#import "GrowingCocoaLumberjack.h"
#import "GrowingRealTracker.h"
@interface GrowingCdpTracker ()
@property (nonatomic, strong) GrowingCdpEventInterceptor *interceptor;
@end

@implementation GrowingCdpTracker

static GrowingCdpTracker *sharedInstance = nil;

- (instancetype)initWithRealTracker:(GrowingRealTracker *)realTracker {
    self = [super initWithTarget:realTracker];
    return self;
}



+ (void)startWithConfiguration:(GrowingTrackConfiguration *)configuration launchOptions:(NSDictionary *)launchOptions {
    if (![NSThread isMainThread]) {
        @throw [NSException exceptionWithName:@"初始化异常" reason:@"请在applicationDidFinishLaunching中调用startWithConfiguration函数,并且确保在主线程中" userInfo:nil];
    }

    if (!configuration.projectId.length) {
        @throw [NSException exceptionWithName:@"初始化异常" reason:@"ProjectId不能为空" userInfo:nil];
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GrowingRealTracker *realTracker = [GrowingRealTracker trackerWithConfiguration:configuration launchOptions:launchOptions];
        sharedInstance = [[self alloc] initWithRealTracker:realTracker];
        sharedInstance.interceptor = [[GrowingCdpEventInterceptor alloc] initWithSourceId:configuration.dataSourceId];
        [[GrowingEventManager shareInstance] addInterceptor:sharedInstance.interceptor];
        
    });
}

+ (instancetype)sharedInstance {
    if (!sharedInstance) {
        @throw [NSException exceptionWithName:@"GrowingCdpTracker未初始化" reason:@"请在applicationDidFinishLaunching中调用startWithConfiguration函数,并且确保在主线程中" userInfo:nil];
    }
    return sharedInstance;
}

- (void)trackCustomEvent:(NSString *)eventName itemKey:(NSString *)itemKey itemId:(NSString *)itemId {
    
    [self trackCustomEvent:eventName itemKey:itemKey itemId:itemId withAttributes:nil];
}

- (void)trackCustomEvent:(NSString *)eventName itemKey:(NSString *)itemKey itemId:(NSString *)itemId withAttributes:(NSDictionary <NSString *, NSString *> *)attributes {
    if ([GrowingArgumentChecker isIllegalEventName:itemKey] || [GrowingArgumentChecker isIllegalEventName:itemId]) {
        return;
    }
    [GrowingDispatchManager trackApiSel:_cmd dispatchInMainThread:^{
        NSDictionary *dict = @{itemKey:itemId};
        GrowingResourceCustomBuilder *builder = GrowingResourceCustomEvent.builder.setResourceItem(dict).setAttributes(attributes).setEventName(eventName);
        [[GrowingEventManager shareInstance] postEventBuidler:builder];
    }];
}

@end
