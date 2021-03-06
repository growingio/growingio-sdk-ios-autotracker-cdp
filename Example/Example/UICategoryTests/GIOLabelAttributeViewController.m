//
//  GIOLabelAttributeViewController.m
//  GrowingExample
//
//  Created by GrowingIO on 2018/5/22.
//  Copyright (C) 2018 Beijing Yishu Technology Co., Ltd.
//

#import "GIOLabelAttributeViewController.h"
//#import "GrowingAutotracker.h"
#import <CoreLocation/CoreLocation.h>

@interface GIOLabelAttributeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *checkAlpLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkHiddenLabel;
@property (weak, nonatomic) IBOutlet UIButton *gioNotTrack;

@end

@implementation GIOLabelAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置不采集Btn gioNotTrack数据
//    self.gioNotTrack.growingViewIgnorePolicy = GrowingIgnoreSelf;
//    [self.checkHiddenLabel growingTrackImpression:@"HiddenLabel"];
//    [self.checkAlpLabel growingTrackImpression:@"AlpLabel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置alpha的值为0.005
- (IBAction)setAlphaSmall:(id)sender {
    self.checkAlpLabel.alpha = 0.005;
    NSLog(@"设置alpha的值为0.005");
}
//设置alpha的值为1
- (IBAction)setAlphLarge:(id)sender {
    self.checkAlpLabel.alpha = 1;
    NSLog(@"设置alpha的值为1");
}
//隐藏label
- (IBAction)hiddenLabel:(id)sender {
    self.checkHiddenLabel.hidden = TRUE;
    NSLog(@"隐藏Label标签！");
}
- (IBAction)showLabel:(id)sender {
    self.checkHiddenLabel.hidden = false;
    NSLog(@"显示Label标签！");
}
//弹出浮层测试
- (IBAction)showAlertTest:(id)sender {
    [self showalert];
}

- (void)showalert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView"
                                                    message:@"弹出式对话框相关测试！"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:nil, nil];
    [alert addButtonWithTitle:@"重新弹出"];
    [alert show];
}

//设置GIO不采集数据
- (IBAction)growingNotTrack:(id)sender {
    NSLog(@"GrowingIO 不采集点击事件！");
}

//监听点击事件 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self showalert];
    }
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"弹出框，单击了按钮：%@", btnTitle);
}

@end
