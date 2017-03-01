//
//  ViewController.m
//  PrintControllerDemo
//
//  Created by WindXu on 17/3/1.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "ViewController.h"
#import "PdfViewController.h"
#import "TextViewController.h"
#import "WebViewController.h"
#import "HtmlViewController.h"

typedef NS_ENUM(NSInteger) {
    
    PDFType         = 0,
    TEXTType        = 1,
    WEBType         = 2,
    HTMLType        = 3,
    
}PrintType;
static NSString * const CellID = @"registCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray arrayWithObjects:@"PDF",@"TEXT",@"WEBView",@"HTML", nil];
    [self configureSetUpView];
}
- (void)configureSetUpView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case PDFType:
        {
            PdfViewController * pdfVC = [[PdfViewController alloc]init];
            pdfVC.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:pdfVC animated:YES];
        }
            break;
        case TEXTType:
        {
            TextViewController * textVC = [[TextViewController alloc]init];
            textVC.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:textVC animated:YES];
        }
            break;
        case WEBType:
        {
            WebViewController * webVC = [[WebViewController alloc]init];
            webVC.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case HTMLType:
        {
            HtmlViewController * htmlVC = [[HtmlViewController alloc]init];
            htmlVC.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:htmlVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
