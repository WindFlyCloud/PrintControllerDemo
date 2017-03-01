//
//  PdfViewController.m
//  PrintControllerDemo
//
//  Created by WindXu on 17/3/1.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()<UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) NSString  * filePath;

@end

@implementation PdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureSetUpView];
}
- (void)configureSetUpView {
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    _filePath = [[NSBundle mainBundle]pathForResource:@"" ofType:@"pdf"];
    NSURL * url = [NSURL fileURLWithPath:_filePath];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
}
- (void)printAction {
    NSLog(@"打印");
    
    //第一种实现方式 根据URL打印
//    NSURL * url = [NSURL fileURLWithPath:_filePath];
//    UIPrintInteractionController * print = [UIPrintInteractionController sharedPrintController];
//    if (print && [UIPrintInteractionController canPrintURL:url]) {
//        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
//        printInfo.outputType = UIPrintInfoOutputGeneral;
//        printInfo.jobName = [_filePath lastPathComponent];
//        printInfo.duplex = UIPrintInfoDuplexLongEdge;
//        print.printInfo = printInfo;
//        print.showsPageRange = YES;
//        print.printingItem = url;
//        
//        void (^completionHandler)(UIPrintInteractionController *,BOOL,NSError *) = ^(UIPrintInteractionController * print, BOOL completed, NSError *error) {
//            
//            if (!completed && error) {
//                NSLog(@"FAILED! due to error in domain %@ with error code %u",
//                      error.domain, error.code);
//            }
//        };
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
////            [print presentFromBarButtonItem:nil animated:YES completionHandler:completionHandler];
//            // [pic presentFromBarButtonItem:self.printButton animated:YES completionHandler:completionHandler];
//        }else{
//            [print presentAnimated:YES completionHandler:completionHandler];
//        }
//    }
    //第二种实现方式 根据NSData打印
    NSData * fileData = [NSData dataWithContentsOfFile:_filePath];
    UIPrintInteractionController * print = [UIPrintInteractionController sharedPrintController];
    if (print && [UIPrintInteractionController canPrintData:fileData]) {
        print.delegate = self;
        
        UIPrintInfo * printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [_filePath lastPathComponent];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        print.printInfo = printInfo;
        print.showsPageRange = YES;
        print.printingItem = fileData;
        
        void (^completionHandler)(UIPrintInteractionController * ,BOOL,NSError *) = ^(UIPrintInteractionController * print, BOOL completed,NSError *error) {
            if (!completed && error)
                NSLog(@"FAILED! due to error in domain %@ with error code %u",
                      error.domain, error.code);
        };
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            [pic presentFromBarButtonItem:self.printButton animated:YES
//                        completionHandler:completionHandler];
        }else{
            [print presentAnimated:YES completionHandler:completionHandler];
        }
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
