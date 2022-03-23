//
//  Progress.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

public let progressScale = 270.0 / 428.0

class Progress: UIView {

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var cornerValue: CGFloat = 15.0

    lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.setColor(UIColor.white)
        self.setCorner(15.0)
    }

    func setColor(_ color: UIColor) {
        self.backgroundColor = color
    }

    func setCorner(_ cornerValue: CGFloat) {
        self.layer.cornerRadius = cornerValue
        self.clipsToBounds = true
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

    }

}
