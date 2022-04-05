//
//  Circle.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Circle: Progress {

    var circleLayers = [CAShapeLayer]()
    var contentColor: UIColor?

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        (0..<16).forEach { _ in
            let circleLayer = CAShapeLayer()
            circleLayers.append(circleLayer)
            layer.addSublayer(circleLayer)
        }
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
        let center = CGPoint(x: bounds.width / 2,
                             y: bounds.height / 2)
        let circleSize = CGSize(width: 0.7 * progressSize.width / CGFloat(circleLayers.count / 3),
                                height: 0.7 * progressSize.height / CGFloat(circleLayers.count / 3))
        let radius = (progressSize.width - circleSize.width) / 2
        circleLayers.enumerated().forEach { tupple in
            let layer = tupple.element
            let index = Double(tupple.offset)
            layer.path = UIBezierPath(ovalIn: CGRect(origin: .zero,
                                                  size: circleSize)).cgPath
            layer.bounds = layer.path!.boundingBox
            layer.position = CGPoint(x: center.x + radius * CGFloat(cos(index * Double.pi / 8)), y: center.y + radius * CGFloat(sin(index * Double.pi / 8)))
        }
//        self.startAnimation()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [0, 1]
        scaleAnim.keyTimes = [0.15, 1]
        scaleAnim.repeatCount = .infinity
        scaleAnim.autoreverses = true
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunction = .init(name: .easeOut)
        scaleAnim.duration = 0.7

        circleLayers.enumerated().forEach {
            scaleAnim.beginTime = CACurrentMediaTime() + 2 * Double($0.offset) * scaleAnim.duration / Double(circleLayers.count)
            $0.element.add(scaleAnim, forKey: nil)
            $0.element.fillColor = self.contentColor?.cgColor ?? UIColor.white.cgColor
        }
    }
}
