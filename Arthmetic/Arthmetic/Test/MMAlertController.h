//
//  自定义alert控制器
//
//  Created by zawaliang on 15/11/26.
//  Copyright © 2015年 octech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAlertAction.h"

#define kMMAlertContentViewWidth 230 // 内容宽度, 230


// 对话框样式
typedef NS_ENUM (NSInteger, MMAlertControllerStyle) {
    MMAlertControllerStyleDefault = 0, // 默认样式,支持按钮配置
    MMAlertControllerStyleActive, // 活跃的样式,支持按钮配置;使用同MMAlertControllerStyleDefault,只是样式上不同,适用于营销型的提示
    MMAlertControllerStyleTips, // 提示型样式,不支持按钮配置
};

@interface MMAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title preferredStyle:(MMAlertControllerStyle)preferredStyle;

@property (nonatomic, strong) UIImage *icon; // 自定义icon,只支持MMAlertControllerStyleDefault与MMAlertControllerStyleActive; MMAlertControllerStyleActive必须提供图片
@property (nonatomic, strong) UIView *contentView; // 自定义内容视图
@property (nonatomic, assign) CGFloat contentHeight; // 自定义内容高度,默认取自定义视图高度

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message; // 消息内容,非自定义视图时提供
@property (nonatomic, assign) NSTextAlignment textAlignment; // 文字对齐(只对message有效),默认NSTextAlignmentCenter
@property (nonatomic, readonly) MMAlertControllerStyle preferredStyle;
@property (nonatomic, readonly) NSArray *actions;

/**
 *  自定义按钮
 *
 *  @param action
 */
- (void)addAction:(MMAlertAction *)action;

@end
