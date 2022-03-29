//
//  Flow.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Flow: Progress {

    private var circleLayer = CAShapeLayer()
    private var circlesReplicatorLayer = CAReplicatorLayer()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        circlesReplicatorLayer.instanceCount = 3
        circlesReplicatorLayer.addSublayer(circleLayer)
        layer.addSublayer(circlesReplicatorLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        circleLayer.fillColor = color.cgColor
        self.layoutIfNeeded()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero,
                                                       size: CGSize(width: progressSize.width / 4,
                                                                    height: progressSize.height / 4))).cgPath
        circleLayer.frame = circleLayer.path!.boundingBox.applying(CGAffineTransform(translationX: progressSize.width / 32,
                                                                                     y: 3 / 8 * progressSize.height))
        circlesReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, progressSize.width / 3, 0, 0)
        circlesReplicatorLayer.frame = progressRect
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

    }

    override func startAnimation() {
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.keyTimes = [0, 0.4, 0.8]
        scaleAnim.values = [0.2, 1, 0.2]
        scaleAnim.repeatCount = .infinity
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunctions = [.init(name: .easeInEaseOut), .init(name: .easeInEaseOut), .init(name: .easeInEaseOut)]
        scaleAnim.duration = 1.6

        circlesReplicatorLayer.instanceDelay = scaleAnim.duration / Double(circlesReplicatorLayer.instanceCount) / 3
        circleLayer.add(scaleAnim, forKey: nil)
    }
}
