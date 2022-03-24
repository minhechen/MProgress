//
//  Progress.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

public let progressScale = 270.0 / 428.0

// UIActivityIndicatorView 37.0

class Progress: UIView {

    var progressInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12) {
        didSet {
            setNeedsLayout()
        }
    }

    var progressSize: CGSize {
        let size = min(bounds.width - (progressInsets.left + progressInsets.right), bounds.height - (progressInsets.top + progressInsets.bottom))
        return CGSize(width: size, height: size)
    }

    var progressOrigin: CGPoint {
        return CGPoint(x: (bounds.width - progressSize.width) / 2, y: (bounds.height - progressSize.height) / 2)
    }

    var progressBounds: CGRect {
        return CGRect(origin: .zero, size: progressSize)
    }

    var progressRect: CGRect {
        return CGRect(origin: progressOrigin, size: progressSize)
    }

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()

    var cornerValue: CGFloat = 15.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.setContentColor(UIColor.white)
//        self.setCorner(15.0)
    }

    func setContentColor(_ color: UIColor) {
        self.layoutIfNeeded()
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

    func startAnimation() {
        // default
    }

}
