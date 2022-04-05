//
//  Grid.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Grid: Progress {

    private var cubeLayer = CAShapeLayer()
    private var cubeRowReplicatorLayer = CAReplicatorLayer()
    private var gridReplicatorLayer = CAReplicatorLayer()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        cubeRowReplicatorLayer.instanceCount = 3
        gridReplicatorLayer.instanceCount = 3

        cubeRowReplicatorLayer.addSublayer(cubeLayer)
        gridReplicatorLayer.addSublayer(cubeRowReplicatorLayer)
        layer.addSublayer(gridReplicatorLayer)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func setContentColor(_ color: UIColor) {
        self.layoutIfNeeded()
        cubeLayer.fillColor = color.cgColor
        cubeLayer.strokeColor = cubeLayer.fillColor
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let cubeRect = progressBounds.applying(CGAffineTransform(scaleX: 1 / 3, y: 1 / 3))
        cubeLayer.path = UIBezierPath(rect: cubeRect).cgPath
        cubeLayer.frame = cubeRect
        cubeRowReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 1, cubeRect.width, 0)
        gridReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, cubeRect.height, 0, 0)
        gridReplicatorLayer.frame = progressRect

        let transform = CATransform3DIdentity
        gridReplicatorLayer.transform = CATransform3DRotate(transform, .pi, 1, 0, 0)

    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func startAnimation() {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 0.05
        scaleAnim.repeatCount = .infinity
        scaleAnim.autoreverses = true
        scaleAnim.fillMode = .forwards
        scaleAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0.2, 0.4, 0.6)
        scaleAnim.duration = 0.6

        cubeRowReplicatorLayer.instanceDelay = scaleAnim.duration / Double(cubeRowReplicatorLayer.instanceCount) / 2
        gridReplicatorLayer.instanceDelay = scaleAnim.duration / Double(gridReplicatorLayer.instanceCount) / 2

        cubeLayer.add(scaleAnim, forKey: nil)
        
    }
}
