//
//  ViewController.m
//  LTMDemo_iOS_Pod
//
//  Created by 汪潇翔 on 14/11/2016.
//  Copyright © 2016 汪潇翔. All rights reserved.
//

#import "ViewController.h"
#import <LTM/LTM.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = [LTMURLCoder decode:@"https://www.baidu.com/s?ie=UTF-8&wd=Cocoapods%20framework"];
    NSLog(@"%@",string);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
