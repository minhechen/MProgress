//
//  Wave.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Wave: Progress {

    private var contentColor: UIColor?
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        self.layoutIfNeeded()
        contentColor = color
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.startAnimation()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {

        let width = self.bounds.width
        let height = self.bounds.height
        let lineWidth = width / 9

        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.5, 0.4, 0.3, 0.2, 0.1]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.4, 1]
        animation.duration = 1
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width/2)

        for i in 0..<5 {
            let lineLayer = CAShapeLayer()
            lineLayer.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
            lineLayer.path = path.cgPath
            lineLayer.backgroundColor = nil
            lineLayer.fillColor = contentColor?.cgColor ?? UIColor.white.cgColor
            animation.beginTime = beginTime - beginTimes[i]
            lineLayer.add(animation, forKey: "animation")
            layer.addSublayer(lineLayer)
        }
    }
}
