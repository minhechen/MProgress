//
//  Fold.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Fold: Progress {

    private var firstDiamondLayer = CAShapeLayer()
    private var secondDiamondLayer = CAShapeLayer()
    private var firstReplicatorLayer = CAReplicatorLayer()
    private var secondReplicatorLayer = CAReplicatorLayer()
    private var contentColor: UIColor?
    var contentSize: CGSize {
        let insets = (pow(progressInsets.top, 2) + pow(progressInsets.left, 2)).squareRoot()
        let size = 0.7 * min(bounds.width - 2 * insets,
                       bounds.height - 2 * insets)
        return CGSize(width: size, height: size)
    }

    private var wrapper: UIView!

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        wrapper = UIView()
        firstReplicatorLayer.instanceCount = 4
        firstReplicatorLayer.addSublayer(firstDiamondLayer)

        secondReplicatorLayer.instanceCount = 3
        secondReplicatorLayer.addSublayer(secondDiamondLayer)

        wrapper.layer.addSublayer(firstReplicatorLayer)
        wrapper.layer.addSublayer(secondReplicatorLayer)

        addSubview(wrapper)
        wrapper.transform = CGAffineTransform(rotationAngle: .pi / 4)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        firstDiamondLayer.fillColor = color.cgColor
        firstDiamondLayer.strokeColor = color.cgColor
        secondDiamondLayer.fillColor = color.cgColor
        secondDiamondLayer.strokeColor = color.cgColor
        contentColor = color
        self.layoutIfNeeded()
        
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let diamondFrame = progressBounds.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))

        wrapper.layer.bounds = progressBounds
        wrapper.layer.position = CGPoint(x: bounds.width / 2,
                                         y: bounds.height / 2)

        firstDiamondLayer.frame = diamondFrame
        firstDiamondLayer.path = UIBezierPath(rect: diamondFrame).cgPath
        firstDiamondLayer.anchorPoint.x = 1

        secondDiamondLayer.frame = firstDiamondLayer.frame
        secondDiamondLayer.path = firstDiamondLayer.path
        secondDiamondLayer.anchorPoint.x = firstDiamondLayer.anchorPoint.x

        firstReplicatorLayer.frame = progressBounds
        secondReplicatorLayer.frame = progressBounds

        firstReplicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, .pi / 2, 0, 0, 1)
        secondReplicatorLayer.instanceTransform = firstReplicatorLayer.instanceTransform
        self.startAnimation()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        firstDiamondLayer.removeAllAnimations()
        secondDiamondLayer.removeAllAnimations()
        let totalDuration: Double =  4
        let delayFactor = 0.2

        let effectiveDuration = (1 - delayFactor) * totalDuration
        let individualDuration = effectiveDuration / Double(2 * firstReplicatorLayer.instanceCount)

        secondDiamondLayer.opacity = 0

        let fadeOutAnim = CABasicAnimation(keyPath: "opacity")
        fadeOutAnim.fromValue = 1
        fadeOutAnim.toValue = 0
        fadeOutAnim.fillMode = .forwards
        fadeOutAnim.duration = individualDuration

        let fadeOutWrapper = CAAnimationGroup()
        fadeOutWrapper.animations = [fadeOutAnim]
        fadeOutWrapper.duration = effectiveDuration / 2

        let colorAnim = CAKeyframeAnimation(keyPath: "fillColor")
        colorAnim.values = [UIColor.white.cgColor,
                            UIColor.white.cgColor,
                            UIColor.white.cgColor]
        colorAnim.keyTimes = [0, 0.8, 1]
        colorAnim.duration = individualDuration

        var transform = CATransform3DRotate(CATransform3DIdentity, CGFloat.pi, 0, 1, 0)
        transform.m34 = -1 / 200

        let rotateAnim = CABasicAnimation(keyPath: "transform")
        rotateAnim.fromValue = CATransform3DIdentity
        rotateAnim.toValue = transform
        rotateAnim.timingFunction = CAMediaTimingFunction(name: .linear)
        rotateAnim.duration = individualDuration + 0.2

        firstReplicatorLayer.instanceDelay = individualDuration
        secondReplicatorLayer.instanceDelay = individualDuration

        let firstAnimGroup = CAAnimationGroup()
        firstAnimGroup.animations = [fadeOutWrapper, rotateAnim, colorAnim]
        firstAnimGroup.duration = totalDuration
        firstAnimGroup.repeatCount = .infinity

        firstDiamondLayer.add(firstAnimGroup, forKey: nil)

        let secondAnimGroup = CAAnimationGroup()

        let fadeInAnim = CABasicAnimation(keyPath: "opacity")
        fadeInAnim.fromValue = 0
        fadeInAnim.toValue = 1
        fadeInAnim.fillMode = .forwards
        fadeInAnim.duration = individualDuration

        let fadeInWrapper = CAAnimationGroup()
        fadeInWrapper.animations = [fadeInAnim]
        fadeInWrapper.duration = fadeOutWrapper.duration

        secondAnimGroup.animations = [fadeInWrapper, rotateAnim, colorAnim]
        secondAnimGroup.duration = totalDuration
        secondAnimGroup.beginTime = CACurrentMediaTime() + effectiveDuration / 2
        secondAnimGroup.repeatCount = .infinity

        secondDiamondLayer.add(secondAnimGroup, forKey: nil)
    }
}
