//
//  LoopCircle.swift
//  MProgress
//
//  Created by mchen on 2022/3/24.
//

import UIKit

class LoopCircle: Progress {
    private var contentColor: UIColor?

//    override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//    }
//
//    override public func draw(_ rect: CGRect) {
//        super.draw(rect)
//    }

    override func setContentColor(_ color: UIColor) {
        self.contentColor = color
    }

//    public override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//    }

    override func startAnimation() {
        layer.sublayers?.removeAll()
        guard let progressModel = self.progressModel else { return }
        let rect = self.progressContextRect(progressModel)
        let width = rect.width * progressScale * progressScale
        let height = width
        let space = rect.width >= 270.0 ? (rect.width * progressScale - width) / 2 : 0.0

        let beginTime: Double = 0.5
        let durationStart: Double = 1.2
        let durationStop: Double = 0.7

        let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
        animationRotation.byValue = 2 * Float.pi
        animationRotation.timingFunction = CAMediaTimingFunction(name: .linear)

        let animationStart = CABasicAnimation(keyPath: "strokeStart")
        animationStart.duration = durationStart
        animationStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
        animationStart.fromValue = 0
        animationStart.toValue = 1
        animationStart.beginTime = beginTime

        let animationStop = CABasicAnimation(keyPath: "strokeEnd")
        animationStop.duration = durationStop
        animationStop.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
        animationStop.fromValue = 0
        animationStop.toValue = 1

        let animation = CAAnimationGroup()
        animation.animations = [animationRotation, animationStop, animationStart]
        animation.duration = durationStart + beginTime
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

        let tempLayer = CAShapeLayer()
        tempLayer.frame = CGRect(x: space, y: 0, width: width, height: height)
        tempLayer.path = path.cgPath
        tempLayer.fillColor = nil
        tempLayer.strokeColor = contentColor?.cgColor
        tempLayer.lineWidth = 3

        tempLayer.add(animation, forKey: "animation")
        layer.addSublayer(tempLayer)
    }
}
