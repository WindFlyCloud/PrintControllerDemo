//
//  WebViewController.m
//  PrintControllerDemo
//
//  Created by WindXu on 17/3/1.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) NSString  * urlStr;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureSetUpView];
}
- (void)configureSetUpView {
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    //https://developer.apple.com/reference/uikit/uiprintinteractioncontroller?language=objc
    //http://www.jianshu.com/p/f5863a1833d0
   _urlStr = [[NSBundle mainBundle]pathForResource:@"" ofType:@"docx"];
//    _urlStr = @"https://developer.apple.com/reference/uikit/uiprintinteractioncontroller?language=objc";
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
//    NSURL * url = [NSURL URLWithString:_urlStr];
    NSURL * url = [NSURL fileURLWithPath:_urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
}
- (void)printAction {
    NSLog(@"打印");
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u",
                  error.domain, error.code);
        }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = _urlStr;
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    controller.printInfo = printInfo;
    controller.showsPageRange = YES;
    
    UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
    viewFormatter.startPage = 0;
    controller.printFormatter = viewFormatter;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        [controller presentFromBarButtonItem:printButton animated:YES completionHandler:completionHandler];
    }else{
        [controller presentAnimated:YES completionHandler:completionHandler];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
