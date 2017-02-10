//
//  ViewController.m
//  runtime_umengDemo_
//
//  Created by niuting on 2017/2/9.
//  Copyright © 2017年 niuNaruto. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)loadView{
    [super loadView];
    self.title = @"当前是avc"; // 这个 “当前是avc”就是被友盟统计到的路径页面信息
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[BViewController new] animated:YES];

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
