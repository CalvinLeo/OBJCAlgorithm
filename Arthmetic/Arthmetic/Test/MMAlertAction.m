//
//  MMAlertSheet.m
//  MumUnion
//
//  Created by Mr Gao on 15/12/29.
//  Copyright © 2015年 octech. All rights reserved.
//

#import "MMAlertAction.h"

@interface MMAlertAction ()
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) MMAlertActionStyle style;
@end

@implementation MMAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(MMAlertActionStyle)style handler:(void (^)(MMAlertAction *action))handler
{
    MMAlertAction *action = [(MMAlertAction *)[self alloc] init];
    action.title = title;
    action.style = style;
    action.enabled = YES;
    action.dismiss = YES;
    action.handler = handler;
    
    return action;
}

@end
