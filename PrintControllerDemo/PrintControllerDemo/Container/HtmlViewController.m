//
//  HtmlViewController.m
//  PrintControllerDemo
//
//  Created by WindXu on 17/3/1.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "HtmlViewController.h"

@interface HtmlViewController ()<UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) NSString  * filePath;

@property (nonatomic, strong) NSString  * htlmString;

@end

@implementation HtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureSetUpView];
}
- (void)configureSetUpView {
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _filePath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"html"];
    NSURL * url = [NSURL fileURLWithPath:_filePath];
    _htlmString = [NSString stringWithContentsOfFile:_filePath encoding:NSUTF8StringEncoding error:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
}
- (void)printAction {
    NSLog(@"打印");
    UIPrintInteractionController * print = [UIPrintInteractionController sharedPrintController];
    print.delegate = self;
    
    UIPrintInfo * printInfo = [UIPrintInfo printInfo];
    printInfo.outputType  = UIPrintInfoOutputGeneral;
    printInfo.jobName = [_filePath lastPathComponent];
    //printInfo.jobName = self.documentName;
    print.printInfo = printInfo;
    
    UIMarkupTextPrintFormatter * htmlFormatter = [[UIMarkupTextPrintFormatter alloc]initWithMarkupText:_htlmString];
    htmlFormatter.startPage = 0;
    htmlFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0);
    print.printFormatter = htmlFormatter;
    print.showsPageRange = YES;
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        [pic presentFromBarButtonItem:sender animated:YES completionHandler:completionHandler];
    } else {
        [print presentAnimated:YES completionHandler:completionHandler];
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
