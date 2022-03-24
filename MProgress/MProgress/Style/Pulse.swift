//
//  Pulse.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Pulse: Progress {

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
//        progressLayer.masksToBounds = true
//        layer.addSublayer(progressLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
//        progressLayer.fillColor = UIColor.white.cgColor
    }

    override func setContentColor(_ color: UIColor) {
       
        self.layoutIfNeeded()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
//        progressLayer.path = UIBezierPath(rect: self.bounds).cgPath
//        progressLayer.frame = self.bounds
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.addAnimationGroup()
    }

    func addAnimationGroup() {
        var yRotation = CATransform3DRotate(CATransform3DIdentity, .pi, 1.0, 0, 0)
        yRotation.m34 = -1.0/180
        var zRoatation = CATransform3DRotate(CATransform3DIdentity, .pi, 0, 0, 1.0)
        zRoatation.m34 = -1.0/180

        let rotation = CAKeyframeAnimation(keyPath: "transform")
        rotation.values = [CATransform3DIdentity, yRotation, zRoatation]
        rotation.keyTimes = [0, 0.5, 1]
        rotation.duration = 1.2

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotation]
        animationGroup.repeatCount = .infinity
        animationGroup.duration = 1.2 * rotation.duration
//        progressLayer.add(animationGroup, forKey: nil)
    }
}
