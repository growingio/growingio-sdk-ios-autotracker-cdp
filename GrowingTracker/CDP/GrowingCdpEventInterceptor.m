//
//  GrowingCdpEventInterceptor.m
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

#import "GrowingCdpEventInterceptor.h"
#import "GrowingPersistenceDataProvider.h"
#import "GrowingSession.h"

static NSString *kGrowingGioId = @"GIO_ID";

@implementation GrowingCdpEventInterceptor

@synthesize gioId = _gioId;

- (instancetype)initWithSourceId:(NSString *)dataSourceId {
    if (self = [super init]) {
        _dataSourceId = dataSourceId;
    }
    return self;;
}

//在未完成构造event前，返回builder
- (void)growingEventManagerEventWillBuild:(GrowingBaseBuilder* _Nullable)builder {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_dataSourceId forKey:@"dataSourceId"];
    if (_gioId.length > 0) {
        [dict setValue:_gioId forKey:@"gioId"];
    }
    builder.setExtraParams(dict);
}

//在完成构造event之后，返回event
- (void)growingEventManagerEventDidBuild:(GrowingBaseEvent* _Nullable)event {
    
}

- (void)setGioId:(NSString * _Nonnull)gioId {
    _gioId = gioId;
    [[GrowingPersistenceDataProvider sharedInstance] setString:gioId forKey:kGrowingGioId];
}

- (NSString *)gioId {
    return [[GrowingPersistenceDataProvider sharedInstance] getStringforKey:kGrowingGioId];
}

#pragma mark - GrowingUserIdChangedDelegate

- (void)userIdDidChangedFrom:(NSString *)oldUserId to:(NSString *)newUserId {
    if (newUserId.length > 0 && ![_gioId isEqualToString:newUserId]) {
        [self setGioId:newUserId];
    }
}

@end
