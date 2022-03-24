//
//  Bounce.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Bounce: Progress {

    private var easeInLayer = CAShapeLayer()
    private var easeOutLayer = CAShapeLayer()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        layer.addSublayer(easeInLayer)
        layer.addSublayer(easeOutLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        easeInLayer.fillColor = color.withAlphaComponent(0.5).cgColor
        easeOutLayer.fillColor = color.cgColor
        self.layoutIfNeeded()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        easeInLayer.path = UIBezierPath(ovalIn: progressBounds).cgPath
        easeInLayer.frame = progressRect

        easeOutLayer.path = UIBezierPath(ovalIn: progressBounds.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))).cgPath
        easeOutLayer.frame = CGRect(x: progressSize.width / 4 + progressOrigin.x, y: progressSize.height / 4 + progressOrigin.y, width: progressSize.width / 2, height: progressSize.height / 2)
    }
    

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        super.startAnimation()
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.fromValue = 1.0
        animation.toValue = 0.5
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        easeInLayer.add(animation, forKey: nil)

        animation.fromValue = 0.0
        animation.toValue = 1.0
        easeOutLayer.add(animation, forKey: nil)
    }
}
