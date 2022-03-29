//
//  Fade.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class Fade: Circle {

    override func startAnimation() {
        let scaleAnim = CAKeyframeAnimation(keyPath: "opacity")
        scaleAnim.values = [0, 1]
        scaleAnim.keyTimes = [0.33, 1]
        scaleAnim.repeatCount = .infinity
        scaleAnim.autoreverses = true
        scaleAnim.fillMode = .both
        scaleAnim.timingFunction = .init(name: .easeOut)
        scaleAnim.duration = 0.7

        circleLayers.enumerated().forEach {
            scaleAnim.beginTime = CACurrentMediaTime() + 2 * Double($0.offset) * scaleAnim.duration / Double(circleLayers.count)
            $0.element.add(scaleAnim, forKey: nil)
            $0.element.fillColor = self.contentColor?.cgColor ?? UIColor.white.cgColor
        }
    }
}
