//
//  visitorAttributesEventsTest.m
//  GIOAutoTests
//
//  Created by GrowingIO on 2018/7/12.
//  Copyright (C) 2018 Beijing Yishu Technology Co., Ltd.
//  Function:vstr事件的测试
//

#import "VisitorAttributesEventsTest.h"

#import "GrowingTracker.h"
#import "LogOperHelper.h"
#import "ManualTrackHelper.h"
#import "MockEventQueue.h"

@implementation VisitorAttributesEventsTest

- (void)setUp {
    //设置userid,确保cs1字段不空
    [[GrowingTracker sharedInstance] setLoginUserId:@"test"];
    [[viewTester usingLabel:@"UI界面"] tap];

}


@end
