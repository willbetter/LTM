//
//  ViewController.m
//  LTMDemo-macOS
//
//  Created by 汪潇翔 on 29/09/2016.
//  Copyright © 2016 汪潇翔. All rights reserved.
//

#import "ViewController.h"
#import <LTM/LTM.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @":!*();@/&?+$,='";
    
    NSString *encode1 = [LTMURLCoder encode:string];
    NSString *encode2 = [LTMURLCoder encode:encode1];
#if TARGET_OS_IPHONE
     NSLog(@"Hello iOS");
#endif
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
