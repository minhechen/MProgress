//
//  Wander.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Wander: Progress {

    private var leftSquareLayer = CAShapeLayer()
    private var rightSquareLayer = CAShapeLayer()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        layer.addSublayer(leftSquareLayer)
        layer.addSublayer(rightSquareLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        leftSquareLayer.fillColor = color.cgColor
        rightSquareLayer.fillColor = color.cgColor
        self.layoutIfNeeded()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(rect: CGRect(origin: .zero,
                                             size: CGSize(width: progressSize.width / 4, height: progressSize.height / 4)))
        leftSquareLayer.path = path.cgPath
        leftSquareLayer.frame = CGRect(origin: progressOrigin,
                                       size: CGSize(width: progressSize.width / 4,
                                                    height: progressSize.height / 4))

        rightSquareLayer.path = path.cgPath
        rightSquareLayer.frame = leftSquareLayer.frame.applying(CGAffineTransform(translationX: 6 * progressSize.width / 8, y: 6 * progressSize.width / 8))
        self.startAnimation()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        
        let rotateAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnim.values = [0, Double.pi / 2, Double.pi, 3 * Double.pi / 2, 2 * Double.pi]
        rotateAnim.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        rotateAnim.timingFunctions = [.init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut)]

        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [1, 0.5, 1, 0.5, 1]
        scaleAnim.keyTimes = rotateAnim.keyTimes
        scaleAnim.timingFunctions = rotateAnim.timingFunctions

        let animGroup = CAAnimationGroup()
        animGroup.duration = 2.2
        animGroup.repeatCount = .infinity

        // LEFT
        let translateLeftAnim = CAKeyframeAnimation(keyPath: "position")
        translateLeftAnim.values = [NSValue(cgPoint: leftSquareLayer.position),
                                NSValue(cgPoint: CGPoint(x: rightSquareLayer.position.x, y: leftSquareLayer.position.y)),
                                NSValue(cgPoint: rightSquareLayer.position),
                                NSValue(cgPoint: CGPoint(x: leftSquareLayer.position.x, y: rightSquareLayer.position.y)),
                                NSValue(cgPoint: leftSquareLayer.position)]
        translateLeftAnim.keyTimes = rotateAnim.keyTimes
        translateLeftAnim.timingFunctions = rotateAnim.timingFunctions

        animGroup.animations = [translateLeftAnim, rotateAnim, scaleAnim]
        leftSquareLayer.add(animGroup, forKey: nil)

        // RIGHT
        let translateRightAnim = CAKeyframeAnimation(keyPath: "position")
        translateRightAnim.values = [NSValue(cgPoint: rightSquareLayer.position),
                                     NSValue(cgPoint: CGPoint(x: leftSquareLayer.position.x, y: rightSquareLayer.position.y)),
                                     NSValue(cgPoint: leftSquareLayer.position),
                                     NSValue(cgPoint: CGPoint(x: rightSquareLayer.position.x, y: leftSquareLayer.position.y)),
                                     NSValue(cgPoint: rightSquareLayer.position)]
        translateRightAnim.keyTimes = rotateAnim.keyTimes
        translateRightAnim.timingFunctions = rotateAnim.timingFunctions

        animGroup.animations = [translateRightAnim, rotateAnim, scaleAnim]
        rightSquareLayer.add(animGroup, forKey: nil)
    }
}
