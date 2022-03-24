//
//  Discrete.swift
//  MProgress
//
//  Created by mchen on 2022/3/24.
//

import UIKit

class Discrete: Progress {
    private var contentColor: UIColor?

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
        self.contentColor = color
        self.layoutIfNeeded()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.startAnimation()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        layer.sublayers?.removeAll()
        let width = self.bounds.width
        let height = self.bounds.height

        let spacing: CGFloat = 3
        let radius = (width - 4 * spacing) / 5.0
        let radiusX = (width - radius) / 2

        let duration: CFTimeInterval = 1.5

        let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        let pathPosition = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: radiusX, startAngle: 1.5 * .pi, endAngle: 3.5 * .pi, clockwise: true)

        var layers: [CAShapeLayer] = [CAShapeLayer]()
        for i in 0..<5 {
            let rate = Float(i) * 1 / 5
            let fromScale = 1 - rate
            let toScale = 0.2 + rate
            let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.1 + rate, 0.25, 1)

            let animationScale = CABasicAnimation(keyPath: "transform.scale")
            animationScale.duration = duration
            animationScale.repeatCount = HUGE
            animationScale.fromValue = fromScale
            animationScale.toValue = toScale

            let animationPosition = CAKeyframeAnimation(keyPath: "position")
            animationPosition.duration = duration
            animationPosition.repeatCount = HUGE
            animationPosition.calculationMode = .discrete

            animationPosition.path = pathPosition.cgPath

            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [animationScale, animationPosition]
            animationGroup.timingFunction = timeFunc
            animationGroup.duration = duration
            animationGroup.repeatCount = HUGE
            animationGroup.isRemovedOnCompletion = false
//            animationGroup.autoreverses = true

            let chaseLayer = CAShapeLayer()
            chaseLayer.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
            chaseLayer.path = path.cgPath
            chaseLayer.fillColor = contentColor?.cgColor ?? UIColor.white.cgColor

            chaseLayer.add(animationGroup, forKey: "animation")

            layer.addSublayer(chaseLayer)
            layers.append(chaseLayer)
        }

    }
}
