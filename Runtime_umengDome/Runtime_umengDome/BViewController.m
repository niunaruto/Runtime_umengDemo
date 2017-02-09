//
//  BViewController.m
//  Runtime_umengDome
//
//  Created by niuting on 2017/2/9.
//  Copyright © 2017年 niuNaruto. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"
@interface BViewController ()

@end

@implementation BViewController
- (void)loadView{
    [super loadView];
    self.title = @"当前是bvc";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[CViewController new] animated:YES];
}

@end
