//
//  InterfaceController.m
//  LTMDemo-watchOS Extension
//
//  Created by 汪潇翔 on 29/09/2016.
//  Copyright © 2016 汪潇翔. All rights reserved.
//

#import "InterfaceController.h"
#import <LTM/LTM.h>


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



