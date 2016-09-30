//
//  ViewController.m
//  LTMDemo-iOS
//
//  Created by 汪潇翔 on 29/09/2016.
//  Copyright © 2016 汪潇翔. All rights reserved.
//

#import "ViewController.h"

#if 0
#import <LTM/LTMUIView+Snapshot.h>
#else
#import <LTM/LTM.h>
#endif
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = [UIFont systemFontOfSize:18];
    printf("font:%f",[font ltm_lineHeight]);
    
    NSLog(@"\n%@\n",[self.view ltm_subtreeDescription]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
