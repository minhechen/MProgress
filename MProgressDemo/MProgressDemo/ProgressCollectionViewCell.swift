//
//  ProgressCollectionViewCell.swift
//  MProgressDemo
//
//  Created by mchen on 2022/3/22.
//

import UIKit
import MProgress

class ProgressCollectionViewCell: UICollectionViewCell {
    static let cellID = String(describing: ProgressCollectionViewCell.self)
    var progressClassName: String?

    lazy var topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        topContainer.frame = self.bounds
        titleLabel.frame = CGRect(x: 0, y: self.frame.height - 22, width: self.frame.width, height: 22)
        contentView.addSubview(topContainer)
        topContainer.addSubview(titleLabel)
    }

    func setupContent(_ progressType: ProgressType) {
        var titleText = "oops"
        switch progressType {
        case .plane:
            titleText = "plane"
            MProgress.show("plane...", message: nil, context: self, backgroundColor: MColor.colors()[0], progressColor: .white, progressBackgroundColor: MColor.colors()[0])
        case .chase:
            titleText = "chase"
            MProgress.show("chase...", message: "this is a chasing message", context: self, type: .chase, backgroundColor: MColor.colors()[1], progressColor: .white, progressBackgroundColor: MColor.colors()[1])
        case .bounce:
            titleText = "bounce"
            MProgress.show("bounce...", message: nil, context: self, type: .bounce, backgroundColor: MColor.colors()[2], progressColor: .white, progressBackgroundColor: MColor.colors()[2])
        case .wave:
            titleText = "wave"
            MProgress.show("wave...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[3], progressColor: .white, progressBackgroundColor: MColor.colors()[3])
        case .pulse:
            titleText = "pulse"
            MProgress.show("pulse...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        case .flow:
            titleText = "flow"
            MProgress.show("flow...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[5], progressColor: .white, progressBackgroundColor: MColor.colors()[5])
        case .swing:
            titleText = "swing"
            MProgress.show("swing...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[6], progressColor: .white, progressBackgroundColor: MColor.colors()[6])
        case .circle:
            titleText = "circle"
            MProgress.show("circle...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[7], progressColor: .white, progressBackgroundColor: MColor.colors()[7])
        case .fade:
            titleText = "fade"
            MProgress.show("fade...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[0], progressColor: .white, progressBackgroundColor: MColor.colors()[0])
        case .grid:
            titleText = "grid"
            MProgress.show("grid...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[1], progressColor: .white, progressBackgroundColor: MColor.colors()[1])
        case .fold:
            titleText = "fold"
            MProgress.show("fold...", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[2], progressColor: .white, progressBackgroundColor: MColor.colors()[3])
        case .wander:
            titleText = "wander"
            MProgress.show("wander", message: nil, context: self, type: progressType, backgroundColor: MColor.colors()[3], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        case .pendulum:
            titleText = "pendulum"
            MProgress.show("pendulum", message: "This is a progress message, you can custom what you want to custom message", context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[5])
        case .loopCircle:
            titleText = "loop circle"
            MProgress.show("loop circle", message: "This is a progress message, you can custom what you want to custom message", context: self, type: progressType, backgroundColor: MColor.colors()[5], progressColor: .white, progressBackgroundColor: MColor.colors()[6], shadeColor: UIColor.black.withAlphaComponent(0.3))
        case .default:
            titleText = "default"
            MProgress.show("default...", context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        }
        titleLabel.text = titleText
        titleLabel.textAlignment = .center
    }

}
