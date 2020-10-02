//
//  LoadingViewable.swift
//  ReactiveApp
//
//  Created by TungImac on 10/1/20.
//

import Foundation
import UIKit
protocol LoadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension LoadingViewable where Self : UIViewController {
    func startAnimating(){
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
class LoadingView: UIView {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animateView: AnimateloadingView!
    @IBOutlet var containerView: UIView!
    
    public var loadingViewMessage : String! {
        didSet {
            messageLabel.text = loadingViewMessage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        containerView.addBlurAreaForLoading(area: containerView.bounds, style: .dark)
        containerView.bringSubviewToFront(messageLabel)
    }
    public func startAnimation(){
        if animateView.isAnimating {return}
        animateView.startAnimating()
    }
    public func stopAnimation(){
        animateView.stopAnimating()
    }
}
extension UIView {
    func addBlurAreaForLoading(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        self.insertSubview(container, at: 1)
    }
}
class AnimateloadingView : UIView {
    
    public var color: UIColor = UIColor.white
    public var isAnimating : Bool = false
    /**
     Start animating.
     */
    public final func startAnimating() {
        isHidden = false
        layer.speed = 1
        setUpAnimation(in: layer, size: self.frame.size, color: color)
    }
    /**
     Stop animating.
     */
    public final func stopAnimating() {
        if isAnimating == false {return}
        isHidden = true
        layer.sublayers?.removeAll()
        isAnimating = false
    }
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.5
        let strokeEndDuration: Double = 1.1
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        let circle = circleLayer(size: size, color: color)
        let frame = CGRect(
            x: (layer.bounds.width - size.width) / 2,
            y: (layer.bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        
        circle.frame = frame
        circle.add(groupAnimation, forKey: "animation")
        layer.addSublayer(circle)
        isAnimating = true
    }
    func circleLayer(size: CGSize, color: UIColor) -> CALayer{
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = 2

        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }
}

