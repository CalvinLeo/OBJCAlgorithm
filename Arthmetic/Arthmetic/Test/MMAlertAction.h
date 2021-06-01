//
//  MMAlertSheet.h
//  MumUnion
//
//  Created by Mr Gao on 15/12/29.
//  Copyright © 2015年 octech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAlertAction : NSObject

// 按钮样式
typedef NS_ENUM(NSInteger, MMAlertActionStyle) {
    MMAlertActionStyleDefault = 0, // 主色调按钮
    MMAlertActionStyleCancel, // 灰色取消按钮
};

+ (instancetype)actionWithTitle:(NSString *)title style:(MMAlertActionStyle)style handler:(void (^)(MMAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MMAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, assign) BOOL dismiss; // 是否自动关闭,默认YES
@property (nonatomic, copy) void (^handler)(MMAlertAction *action);

@end
