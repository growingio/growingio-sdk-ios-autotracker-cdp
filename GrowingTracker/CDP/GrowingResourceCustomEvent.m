//
//  GrowingResourceCustomEvent.m
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

#import "GrowingResourceCustomEvent.h"

@implementation GrowingResourceCustomEvent

- (instancetype)initWithBuilder:(GrowingBaseBuilder *)builder {
    if (self = [super initWithBuilder:builder]) {
        GrowingResourceCustomBuilder *subBuilder = (GrowingResourceCustomBuilder*)builder;
        _resourceItem = subBuilder.resourceItem;
    }
    return self;
}

+ (GrowingResourceCustomBuilder *)builder {
    return [[GrowingResourceCustomBuilder alloc] init];
}


- (NSDictionary *)toDictionary {
    NSMutableDictionary *dataDictM = [NSMutableDictionary dictionaryWithDictionary:[super toDictionary]];
    dataDictM[@"resourceItem"] = self.resourceItem;
    return dataDictM;;
}

@end


@implementation GrowingResourceCustomBuilder

- (GrowingResourceCustomBuilder *(^)(NSDictionary *value))setResourceItem {
    return ^(NSDictionary *value) {
        self->_resourceItem = value;
        return self;
    };
}

- (GrowingBaseEvent *)build {
    return [[GrowingResourceCustomEvent alloc] initWithBuilder:self];
}

@end