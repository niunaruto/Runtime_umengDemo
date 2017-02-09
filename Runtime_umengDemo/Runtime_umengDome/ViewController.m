//
//  ViewController.m
//  Runtime_umengDome
//
//  Created by niuting on 2017/2/9.
//  Copyright © 2017年 niuNaruto. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+AS.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView{
    [super loadView];
    self.title = @"当前是avc";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.umengLogAs = @"456";


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[BViewController new] animated:YES];
}
@end
