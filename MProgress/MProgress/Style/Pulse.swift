//
//  Pulse.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Pulse: Progress {

    private var pulseLayer = CAShapeLayer()
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        pulseLayer.masksToBounds = true
        layer.addSublayer(pulseLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        pulseLayer.fillColor = color.cgColor
        self.layoutIfNeeded()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        pulseLayer.frame = progressRect
        pulseLayer.path = UIBezierPath(rect: progressBounds).cgPath
        pulseLayer.cornerRadius = min(progressSize.width, progressSize.height) / 2
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 1.2
        opacityAnimation.fillMode = .forwards

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 1.2

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.duration = 1.2

        pulseLayer.add(animationGroup, forKey: nil)
    }
}
