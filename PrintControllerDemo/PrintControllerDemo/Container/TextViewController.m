//
//  TextViewController.m
//  PrintControllerDemo
//
//  Created by WindXu on 17/3/1.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()<UIPrintInteractionControllerDelegate>

@property (nonatomic,strong) UITextField * textField;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureSetUpView];
}
- (void)configureSetUpView {
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, CGRectGetWidth(self.view.frame)-20, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
}
- (void)printAction {
    NSLog(@"打印");
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!");
        return;
    }
    
    /* Set this object as delegate so you can  use the printInteractionController:cutLengthForPaper: delegate */
    controller.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    
    /* Use landscape orientation for a banner so the text  print along the long side of the paper. */
    printInfo.orientation = UIPrintInfoOrientationLandscape;
    
    printInfo.jobName = self.textField.text;
    controller.printInfo = printInfo;
    
    /* Create the UISimpleTextPrintFormatter with the text supplied by the user in the text field */
    UISimpleTextPrintFormatter * textFormatter = [[UISimpleTextPrintFormatter alloc] initWithText:self.textField.text];
    
    /* Set the text formatter's color and font properties based on what the user chose */
    textFormatter.color = [UIColor orangeColor];
    textFormatter.font = [UIFont systemFontOfSize:20];
    
    /* Set this UISimpleTextPrintFormatter on the controller */
    controller.printFormatter = textFormatter;
    
    /* Set up a completion handler block.  If the print job has an error before spooling, this is where it's handled. */
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(completed && error)
            NSLog( @"Printing failed due to error in domain %@ with error code %lu. Localized description: %@, and failure reason: %@", error.domain, (long)error.code, error.localizedDescription, error.localizedFailureReason );
    };
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
       //        [controller presentFromRect:self.printButton.frame inView:self.view animated:YES completionHandler:completionHandler];
    }else{
        [controller presentAnimated:YES completionHandler:completionHandler];  // iPhone
  
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
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
