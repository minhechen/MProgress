//
//  Swing.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Swing: Progress {

    private var leftCircleLayer = CAShapeLayer()
    private var rightCircleLayer = CAShapeLayer()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        layer.addSublayer(rightCircleLayer)
        layer.addSublayer(leftCircleLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        self.layoutIfNeeded()
        leftCircleLayer.fillColor = color.cgColor
        rightCircleLayer.fillColor = color.cgColor
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let circleSize = CGSize(width: progressSize.width / 3, height: progressSize.height / 3)
        leftCircleLayer.frame = CGRect(origin: progressOrigin,
                                       size: circleSize)
        leftCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath

        rightCircleLayer.frame = CGRect(origin: progressOrigin,
                                        size: circleSize)
        rightCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {

        guard let progressModel = self.progressModel else { return }
        let rect = progressModel.progressRect()
        let width = rect.width
        let height = rect.height

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.2
        scaleAnimation.toValue = 1
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.duration = 1.6
        scaleAnimation.fillMode = .backwards
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: width / 4 + leftCircleLayer.frame.size.width / 32, y: height / 4 + leftCircleLayer.frame.size.height / 32), size: CGSize(width: width / 2, height: height / 2 ))).cgPath
        positionAnimation.repeatCount = .infinity
        positionAnimation.fillMode = .backwards
        positionAnimation.duration = 1.6
        positionAnimation.calculationMode = .paced

        leftCircleLayer.add(positionAnimation, forKey: nil)
        leftCircleLayer.add(scaleAnimation, forKey: nil)

        positionAnimation.beginTime = CACurrentMediaTime() + 0.4
        scaleAnimation.toValue = CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)
        scaleAnimation.fromValue = CATransform3DIdentity

        rightCircleLayer.add(positionAnimation, forKey: nil)
        rightCircleLayer.add(scaleAnimation, forKey: nil)
    }
}
