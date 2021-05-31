//
//  DMAlertController.swift
//  QdamaECMall
//
//  Created by Calvin Gao on 2021/5/31.
//  Copyright © 2021 Qdama. All rights reserved.
//

import UIKit

class DMAlertController: UIViewController {
    
    enum DMAlertControllerStyle {
        case alert
        case tips
    }
    
    // 私有
    private let kDMAlertViewWidth = 260
    private let kDefaultHeaderViewHeight = 16
    private let kDefaultFooterViewHeight = 38

    private var _contentView: UIView?
    private var _contentHeight: CGFloat?
    
    // 对外属性
    var alertStyle = DMAlertControllerStyle.alert
    var contentView: UIView? {
        get {return _contentView}
        set {
            guard newValue != nil else {
                return
            }
            _contentView = newValue
            _contentHeight = (_contentView?.frame.size.height)!
            self.bodyView.addSubview(_contentView!)
        }
    }
    var headerText: String? {
        get {return self.headerLabel.text}
        set {self.headerLabel.text = newValue}
    }
    
    // MARK: - Init
    init(title: String, style: DMAlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.alertStyle = style
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
    }
    
    func initSubViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(alertView)
        self.alertView.addSubview(headerLabel)
        self.alertView.addSubview(bodyView)
        self.alertView.addSubview(footerView)
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        var alertViewOffset = 0.0
        var maxContentHeight = 0.0
        self.alertView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(alertViewOffset)
//            make.size.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Lazy
    lazy var alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = 15
        return alertView
    }()
    
    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel();
        headerLabel.font = UIFont(size: 16, weight: .regular);
        headerLabel.textAlignment = .center;
        headerLabel.isHidden = true;
        return headerLabel
    }()
    
    lazy var bodyView: UIView = {
        let body = UIScrollView()
        body.clipsToBounds = true
        return body
    }()
    
    lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.layer.borderWidth = 0.5
        footerView.layer.borderColor = UIColor.lineColor.cgColor
        footerView.isHidden = true;
        return footerView
    }()
    
    
}

// DMAlertController 专场动画拓展
extension DMAlertController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMAlertControllerAnimationController(type: .MMAlertAnimationStylePresenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMAlertControllerAnimationController(type: .MMAlertAnimationStyleDismissing)
    }
}

// 自定义专场类
class DMAlertControllerAnimationController : NSObject {
    enum DMAlertAnimationStyle {
        case MMAlertAnimationStylePresenting
        case MMAlertAnimationStyleDismissing
    }
    
    var animationType: DMAlertAnimationStyle = .MMAlertAnimationStylePresenting
    
    convenience init(type: DMAlertAnimationStyle) {
        self.init()
        self.animationType = type
    }
}

/// 动画类
extension DMAlertControllerAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let animatDuration = self.animationType == .MMAlertAnimationStylePresenting ? 1.0 : 0.3
        return animatDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
    }
}
