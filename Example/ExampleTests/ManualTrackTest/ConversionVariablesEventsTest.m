//
//  EvarEventsTest.m
//  GIOAutoTests
//
//  Created by GrowingIO on 2018/6/12.
//  Copyright (C) 2018 Beijing Yishu Technology Co., Ltd.
//

#import "ConversionVariablesEventsTest.h"

#import "GrowingTracker.h"
#import "LogOperHelper.h"
#import "ManualTrackHelper.h"
#import "MockEventQueue.h"

@implementation ConversionVariablesEventsTest

- (void)setUp {
    //设置userid,确保cs1字段不空
    [[GrowingTracker sharedInstance] setLoginUserId:@"test"];
}



- (void)test17SetEvarDicOutRange {
    /**
     function:setEvar数值字典超过100个关键字
     **/
    [MockEventQueue.sharedQueue cleanQueue];
    [[viewTester usingLabel:@"协议/接口"] tap];
    [[viewTester usingLabel:@"CONVERSION_VARIABLES请求"] tap];
    //将Log日志写入文件
    [LogOperHelper writeLogToFile];
    [[viewTester usingLabel:@"EventAttributesOutRange"] tap];
    //检测日志输出
//    Boolean chres = [LogOperHelper CheckLogOutput:[LogOperHelper getValueErrNsLog]];
    //恢复日志重定向
    [LogOperHelper redirectLogBack];
//    if (chres) {
//        XCTAssertEqual(1, 1);
//        NSLog(@"CONVERSION_VARIABLES事件，setEvar数值字典超过100个关键字，日志检测测试通过-----passed");
//    } else {
//        NSLog(@"CONVERSION_VARIABLES事件，setEvar数值字典超过100个关键字，日志检测测试失败---Failed");
//        XCTAssertEqual(1, 0);
//    }
}

@end
