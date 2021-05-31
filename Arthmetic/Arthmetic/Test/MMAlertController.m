//
//  自定义alert控制器
//
//  Created by zawaliang on 15/11/26.
//  Copyright © 2015年 octech. All rights reserved.
//

#import "MMAlertController.h"
//#import "NSString+MMAdditions.h"

#define kMMAlertViewWidth 260 // 视图容器宽度(定宽),260

// MMAlertControllerStyleDefault
#define kDefaultHeaderViewHeight 16 // header高度
#define kDefaultFooterViewHeight 38 // footer高度
#define kDefaultContentPaddingTop 15 // 内容区距离header底边的paddingTop
#define kDefaultHeaderIconWidth 60 // 头部icon宽度
#define kDefaultHeaderIconHeight 62 // 头部icon高度

// MMAlertControllerStyleActive
#define kActiveHeaderViewHeight 16 // header高度
#define kActiveFooterViewHeight 60 // footer高度
#define kActiveHeaderIconWidth 120 // icon宽度
#define kActiveHeaderIconHeight 120 // icon高度
#define kActiveIconPaddingTop 25 // icon距离上边距
#define kActiveIconPaddingBottom 15 // icon距离下边距
#define kActiveContentPaddingTop 10 // 内容距离上边距
#define kActiveContentPaddingBottom 15 // 内容距离下边距
#define kActiveButtonHeight 30 // 按钮高度

// MMAlertControllerStyleTips
#define kTipsHeaderViewHeight 33 // header高度
#define kTipsCloseButtonHeight 25 // 关闭按钮尺寸

// 公用
#define kContentPaddingTopBottom 30 // 内容区上下padding
#define kContentPaddingLeftRight 15 // 内容区左右padding



typedef NS_ENUM (NSInteger, MMAlertControllerAnimationStyle) {
    MMAlertControllerAnimationStylePresenting,
    MMAlertControllerAnimationStyleDismissing
};


@interface MMAlertController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, assign, readwrite) MMAlertControllerStyle preferredStyle;
@property (nonatomic, strong) NSMutableArray *mutableActions;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIScrollView *bodyView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *closeButton;
@end


#pragma mark - 转场
@interface MMAlertControllerAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) MMAlertControllerAnimationStyle animationStyle;
@end


@implementation MMAlertControllerAnimationController
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.animationStyle == MMAlertControllerAnimationStyleDismissing) {
        return 0.3f;
    }
    
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    if (self.animationStyle == MMAlertControllerAnimationStylePresenting) {
        MMAlertController *toVC = (MMAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [containerView addSubview:toVC.view];
        
        if (toVC.preferredStyle == MMAlertControllerStyleTips) {
            UIView *alertView = toVC.alertView;
            toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            
            // 马上布局,防止获取frame失败
            [toVC.view layoutIfNeeded];
            
            [alertView updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(toVC.view);
            }];
            
            [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                [toVC.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else {
            toVC.view.alpha = 0;
            
            [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                toVC.view.alpha = 1;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
    } else if (self.animationStyle == MMAlertControllerAnimationStyleDismissing) {
        MMAlertController *fromVC = (MMAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        if (fromVC.preferredStyle == MMAlertControllerStyleTips) {
            // iOS7下没有动画效果,why???
//            UIView *alertView = [fromVC.view viewWithTag:kAlertViewTag];
//
//            [alertView updateConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(fromVC.view).offset(- (KScreenHeight + alertView.frame.size.height) / 2);
//            }];
//            
//            [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                fromVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//                [fromVC.view layoutIfNeeded];
//            } completion:^(BOOL finished) {
//                [transitionContext completeTransition:YES];
//            }];
            
            
            UIView *alertView = fromVC.alertView;
            UIButton *closeButton = fromVC.closeButton;
            CGRect frame = alertView.frame;
            CGRect buttonFrame = closeButton.frame;
            
            [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                fromVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                
                alertView.frame = CGRectMake(frame.origin.x, - (kScreenHeight + frame.size.height) / 2, frame.size.width, frame.size.height);
                closeButton.frame = CGRectMake(buttonFrame.origin.x, CGRectGetMaxY(alertView.frame), buttonFrame.size.width, buttonFrame.size.height);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else {
            [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                fromVC.view.alpha = 0;
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:YES];
            }];
        }
    }
}
@end




#pragma mark - Alert控制器
@implementation MMAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title preferredStyle:(MMAlertControllerStyle)preferredStyle
{
    MMAlertController *vc = [(MMAlertController *)[self alloc] initWithPreferredStyle:preferredStyle];
    vc.title = title;
    
    return vc;
}

- (instancetype)initWithPreferredStyle:(MMAlertControllerStyle)preferredStyle
{
    self = [super init];
    if (self) {
        self.preferredStyle = preferredStyle;
        self.mutableActions = [[NSMutableArray alloc] init];
        self.textAlignment = NSTextAlignmentCenter;
        
        self.modalPresentationStyle = UIModalPresentationCustom; // 自定义
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSubViews];
}

/**
 *  初始化子视图
 */
- (void)initSubViews
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self.view addSubview:self.alertView];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.closeButton];
    [self.alertView addSubview:self.headerLabel];
    [self.alertView addSubview:self.bodyView];
    [self.alertView addSubview:self.footerView];
    
    // 点击关闭键盘
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
    
    
    // 键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // 更新约束,防止UIViewControllerAnimatedTransitioning执行时约束还没建立
    [self updateViewConstraints];
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}


#pragma mark - 键盘
- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, frame.size.width, kScreenHeight);
    }];
}

- (void)KeyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGRect frame = self.view.frame;
    CGFloat alertHeight = self.alertView.frame.size.height;

    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height = kScreenHeight - keyboardSize.height;
        height += (height - alertHeight) / 4; // 稍微往下一点,不用居中
        self.view.frame = CGRectMake(0, 0, frame.size.width, height);
    }];
}


- (void)updateViewConstraints
{
    BOOL existTitle = [self.title isKindOfClass:[NSString class]] && self.title.length > 0;
    BOOL existIcon = [self.icon isKindOfClass:[UIImage class]];
    
    CGFloat headerHeight = 0; // 标题高度
    CGFloat headerTop = 0; // 标题距离顶部距离
    CGFloat bodyTop = kContentPaddingTopBottom; // 内容视图距离header距离
    CGFloat bodyBottom = kContentPaddingTopBottom; // 内容视图距离footer距离
    CGFloat footerHeight = 0; // footer高度
    CGSize iconSize = CGSizeMake(0, 0);
    CGFloat alertViewOffset = 0;
    CGFloat iconOffsetTop = 0;
    CGFloat maxContentHeight = [self contentMaxHeight:self.contentHeight];
    CGFloat alertViewHeight;
    
    if (self.preferredStyle == MMAlertControllerStyleTips) {
        headerHeight = kTipsHeaderViewHeight;
        footerHeight = 0;
        
        self.footerView.hidden = YES;
        self.iconView.hidden = YES;
        self.closeButton.hidden = NO;
        
        self.headerLabel.hidden = NO;
        self.headerLabel.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
        self.headerLabel.textColor = MMColor1;
        
        alertViewHeight = maxContentHeight + kContentPaddingTopBottom * 2 + headerHeight + footerHeight;
    } else if (self.preferredStyle == MMAlertControllerStyleActive && existIcon) { // MMAlertControllerStyleActive必须提供图片,否则当MMAlertControllerStyleDefault处理
        footerHeight = kActiveFooterViewHeight;
        bodyBottom = kActiveContentPaddingBottom;
        iconOffsetTop = (kActiveIconPaddingTop + kActiveHeaderIconHeight);
        iconSize = CGSizeMake(kActiveHeaderIconWidth, kActiveHeaderIconHeight);
        headerTop = kActiveIconPaddingTop + kActiveHeaderIconHeight + kActiveIconPaddingBottom;
        
        CGFloat contentTop = 0;
        if (existTitle) {
            headerHeight = kActiveHeaderViewHeight;
            bodyTop = kActiveContentPaddingTop;
            contentTop = kActiveContentPaddingTop;
            
            self.headerLabel.hidden = NO;
            self.headerLabel.backgroundColor = [UIColor whiteColor];
            self.headerLabel.textColor = MMColor2;
        } else {
            bodyTop = 0;
            
            self.headerLabel.hidden = YES;
        }
        
        self.footerView.hidden = NO;
        self.iconView.hidden = !existIcon;
        self.closeButton.hidden = YES;
        
        alertViewHeight = maxContentHeight + contentTop + kActiveContentPaddingBottom + headerHeight + footerHeight + headerTop;
    } else {
        footerHeight = kDefaultFooterViewHeight;
        iconSize = CGSizeMake(kDefaultHeaderIconWidth, kDefaultHeaderIconHeight);
        
        CGFloat contentTop = 0;
        if (existTitle) {
            headerHeight = kDefaultHeaderViewHeight;
            headerTop = kContentPaddingTopBottom;
            bodyTop = kDefaultContentPaddingTop;
            contentTop = kDefaultContentPaddingTop;
            
            self.headerLabel.hidden = NO;
            self.headerLabel.backgroundColor = [UIColor whiteColor];
            self.headerLabel.textColor = MMColor2;
        } else {
            self.headerLabel.hidden = YES;
        }
        
        self.footerView.hidden = NO;
        self.iconView.hidden = !existIcon;
        self.closeButton.hidden = YES;
        
        alertViewHeight = maxContentHeight + kContentPaddingTopBottom * 2 + headerHeight + footerHeight + contentTop;
    }
    
    // 内容区滚动设置
    self.bodyView.contentSize = CGSizeMake(kMMAlertContentViewWidth, self.contentHeight);
    
    // MMAlertControllerStyleTips样式初始化时,默认处于隐藏状态
    if (self.preferredStyle == MMAlertControllerStyleTips) {
        alertViewOffset = - (kScreenHeight + alertViewHeight) / 2;
    }
    
    [self.alertView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(alertViewOffset);
        make.size.equalTo(CGSizeMake(kMMAlertViewWidth, alertViewHeight));
    }];
    
    [self.headerLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.top).offset(headerTop);
        make.left.equalTo(self.alertView.left);
        make.right.equalTo(self.alertView.right);
        make.height.equalTo(headerHeight);
    }];
    
    [self.footerView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.left).offset(-0.5);
        make.bottom.equalTo(self.alertView.bottom).offset(0.5);
        make.right.equalTo(self.alertView.right).offset(0.5);
        make.height.equalTo(footerHeight);
    }];
    
    [self.bodyView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerLabel.bottom).offset(bodyTop);
        make.left.equalTo(self.alertView.left).offset(kContentPaddingLeftRight);
        make.right.equalTo(self.alertView.right).offset(-kContentPaddingLeftRight);
        make.bottom.equalTo(self.footerView.top).offset(-bodyBottom);
    }];
    
    [self.iconView remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.alertView.top).offset(iconOffsetTop);
        make.centerX.equalTo(self.alertView);
        make.size.equalTo(iconSize);
    }];
    
    [self.closeButton remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.top).offset(-7);
        make.right.equalTo(self.alertView.right).offset(3);
        make.size.equalTo(CGSizeMake(kTipsCloseButtonHeight, kTipsCloseButtonHeight));
    }];
    
    
    // 初始化按钮
    if (self.preferredStyle != MMAlertControllerStyleTips) {
        [self makeButton];
    }
    
    [super updateViewConstraints];
}


#pragma mark - 懒加载
/**
 *  icon视图
 *
 *  @return
 */
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    
    return _iconView;
}

/**
 *  对话框视图
 *
 *  @return
 */
- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 15;
    }
    
    return _alertView;
}

- (UILabel *)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.font = [UIFont systemFontOfSize:16];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.hidden = YES;
    }
    
    return _headerLabel;
}

- (UIScrollView *)bodyView
{
    if (!_bodyView) {
        _bodyView = [[UIScrollView alloc] init];
        _bodyView.clipsToBounds = YES;
    }
    
    return _bodyView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.layer.borderWidth = 0.5;
        _footerView.layer.borderColor = [UIColor colorWithHex:0xbdbdbd].CGColor;
        _footerView.hidden = YES;
    }
    
    return _footerView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"button_close_heighlight"] forState:UIControlStateNormal];
        [_closeButton setImage:[UIImage imageNamed:@"button_close_heighlight"] forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}


#pragma mark - getter/setter
- (NSArray *)actions
{
    return [NSArray arrayWithArray:self.mutableActions];
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    
    self.iconView.image = icon;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    
    CGFloat linespacing = 3;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespacing];
    NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAttribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, messageAttribute.length)];

    
    UIFont *font = [UIFont systemFontOfSize:14];
    CGFloat textHeight = [self heightWithText:message font:font rectWidth:kMMAlertContentViewWidth lineSpace:linespacing];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMMAlertContentViewWidth, textHeight)];
    label.attributedText = messageAttribute;
    label.font = font;
    label.textColor = MMColor2;
    label.numberOfLines = 0;
    label.textAlignment = self.textAlignment;
    self.contentView = label;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    if (self.message != nil && [self.contentView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.contentView;
        label.textAlignment = self.textAlignment;
    }
}

- (NSString *)title
{
    return self.headerLabel.text;
}

- (void)setTitle:(NSString *)title
{
    self.headerLabel.text = title;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    // 清空内容视图
    [self removeSubviewsInView:self.bodyView];
    
    // 获取并设置视图高度
    CGFloat height = contentView.frame.size.height;
    _contentHeight = height;
    
    // 插入新视图
    [self.bodyView addSubview:contentView];
}

- (void)setContentHeight:(CGFloat)contentHeight
{
    _contentHeight = contentHeight;
}


#pragma mark - private method
/**
 *  移除子视图
 *
 *  @param view
 */
- (void)removeSubviewsInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        [v removeFromSuperview];
    }
}

/**
 *  获取内容区高度最大值
 *
 *  @return
 */
- (CGFloat)contentMaxHeight:(CGFloat)height
{
    BOOL existTitle = [self.title isKindOfClass:[NSString class]] && self.title.length > 0;
    BOOL existIcon = [self.icon isKindOfClass:[UIImage class]];
    CGFloat maxHeight = kScreenHeight - kStatusBarHeight * 3;
    
    if (self.preferredStyle == MMAlertControllerStyleActive && existIcon) {
        maxHeight -= (kActiveIconPaddingTop + kActiveHeaderIconHeight + kActiveIconPaddingBottom); // icon
        maxHeight -= kActiveFooterViewHeight; // footer
        maxHeight -= kActiveContentPaddingBottom;
        
        // 有标题
        if (existTitle) {
            maxHeight -= (kActiveHeaderViewHeight + kActiveContentPaddingTop);
        }
    } else if (self.preferredStyle == MMAlertControllerStyleTips) {
        maxHeight -= kContentPaddingTopBottom * 2;
        maxHeight -= kTipsCloseButtonHeight; // 关闭按钮
        maxHeight -= kTipsHeaderViewHeight; // header
    } else {
        maxHeight -= kContentPaddingTopBottom * 2;
        maxHeight -= kDefaultFooterViewHeight; // footer
        
        // 有icon
        if (existIcon) {
            maxHeight -= kDefaultHeaderIconHeight * 2; // icon不占垂直居中的位置,所以需要x2
        }
        
        // 有标题
        if (existTitle) {
            maxHeight -= (kDefaultHeaderViewHeight + kDefaultContentPaddingTop);
        }
    }
    
    return MIN(height, maxHeight);
}

- (void)addAction:(MMAlertAction *)action
{
    [self.mutableActions addObject:action];
}

/**
 *  生成按钮
 */
- (void)makeButton
{
    // 移除子视图
    [self removeSubviewsInView:self.footerView];
    
    BOOL isActive = (self.preferredStyle == MMAlertControllerStyleActive);
    
    NSUInteger count = self.mutableActions.count;
    NSUInteger buttonCount = MAX(count, 1);
    
    CGFloat buttonWidth = 0;
    CGFloat buttonHeight = 0;
    CGFloat offsetTop = 0;
    CGFloat offsetLeft = 0;
    if (isActive) {
        offsetLeft = 10;
        buttonWidth = (kMMAlertViewWidth - offsetLeft * buttonCount * 2) / buttonCount;
        buttonHeight = kActiveButtonHeight;
        offsetTop = (kActiveFooterViewHeight - buttonHeight) / 2;
    } else {
        buttonWidth = kMMAlertViewWidth / buttonCount;
        buttonHeight = kDefaultFooterViewHeight;
    }
    
    if (count > 0) { // 自定义action
        UIButton *lastButton;
        
        for (NSInteger i = 0; i < self.mutableActions.count; i++) {
            MMAlertAction *action = [self.mutableActions objectAtIndex:i];
            
            UIButton *button = [[UIButton alloc] init];
            button.tag = i;
            [button setTitle:action.title forState:UIControlStateNormal];
            [button setTitle:action.title forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.clipsToBounds = YES;
            
            UIColor *titleColor;
            if (isActive) {
                UIColor *bgColor;
                
                if (action.style == MMAlertActionStyleDefault) {
                    titleColor = [UIColor whiteColor];
                    bgColor = MMColor1;
                } else {
                    titleColor = MMColor1;
                    bgColor = [UIColor whiteColor];
                }
                
                button.layer.borderWidth = 0.5;
                button.layer.borderColor = MMColor1.CGColor;
                button.layer.cornerRadius = buttonHeight / 2;
                button.backgroundColor = bgColor;
            } else {
                titleColor = (action.style == MMAlertActionStyleDefault) ? MMColor1 : MMColor3;
            }
            
            [button setTitleColor:titleColor forState:UIControlStateNormal];
            [button setTitleColor:titleColor forState:UIControlStateHighlighted];
            
            [button addTarget:self action:@selector(footerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.footerView addSubview:button];
            
            // 分割线
            if (!isActive) {
                CALayer *borderLeft = [CALayer layer];
                borderLeft.frame = CGRectMake(0, 0, 0.5, buttonHeight);
                borderLeft.backgroundColor = [UIColor colorWithHex:0xbdbdbd].CGColor;
                [button.layer addSublayer:borderLeft];
            }
            
            CGFloat left = (lastButton == nil) ? offsetLeft : offsetLeft * 2;
            [button makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.footerView).offset(offsetTop);
                make.left.equalTo((lastButton == nil) ? self.footerView : lastButton.right).offset(left);
                make.size.equalTo(CGSizeMake(buttonWidth, buttonHeight));
            }];
            
            lastButton = button;
        }
    } else { // 默认取消按钮
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIColor *titleColor = isActive ? [UIColor whiteColor] : MMColor3;
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];
        
        if (isActive) {
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.cornerRadius = buttonHeight / 2;
            button.backgroundColor = MMColor1;
        }
        
        [button addTarget:self action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:button];
        
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footerView).offset(offsetTop);
            make.left.equalTo(0).offset(offsetLeft);
            make.size.equalTo(CGSizeMake(buttonWidth, buttonHeight));
        }];
    }
}

/**
 *  footer按钮点击
 */
- (void)footerButtonClick:(UIButton *)button
{
    MMAlertAction *action = [self.mutableActions objectAtIndex:button.tag];
    
    if (!action.enabled) {
        return;
    }
    
    [self dismissKeyboard];
    
    if (action.dismiss) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (action.handler) {
                action.handler(action);
            }
        }];
    } else {
        if (action.handler) {
            action.handler(action);
        }
    }
}

/**
 *  关闭alert
 */
- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font rectWidth:(CGFloat)width lineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing = lineSpace;
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font,
                                               NSParagraphStyleAttributeName:paragraph}
                                     context:nil];
    return rect.size.height;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    MMAlertControllerAnimationController *animationController = [[MMAlertControllerAnimationController alloc] init];
    animationController.animationStyle = MMAlertControllerAnimationStylePresenting;
    
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    MMAlertControllerAnimationController *animationController = [[MMAlertControllerAnimationController alloc] init];
    animationController.animationStyle = MMAlertControllerAnimationStyleDismissing;
    
    return animationController;
}
@end
