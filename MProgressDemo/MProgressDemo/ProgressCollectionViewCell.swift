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
        label.font = .systemFont(ofSize: 22, weight: .heavy)
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
            MProgress.show("Hello world!", context: self, backgroundColor: MColor.colors()[0], progressColor: .white, progressBackgroundColor: MColor.colors()[0])
        case .chase:
            titleText = "chase"
            MProgress.show("Hello world!", context: self, type: .chase, backgroundColor: MColor.colors()[1], progressColor: .white, progressBackgroundColor: MColor.colors()[1])
        case .bounce:
            titleText = "bounce"
            MProgress.show("Hello world!", context: self, type: .bounce, backgroundColor: MColor.colors()[2], progressColor: .white, progressBackgroundColor: MColor.colors()[2])
        case .wave:
            titleText = "wave"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[3], progressColor: .white, progressBackgroundColor: MColor.colors()[3])
        case .pulse:
            titleText = "pulse"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        case .flow:
            titleText = "flow"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[5], progressColor: .white, progressBackgroundColor: MColor.colors()[5])
        case .swing:
            titleText = "swing"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[6], progressColor: .white, progressBackgroundColor: MColor.colors()[6])
        case .circle:
            titleText = "circle"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[7], progressColor: .white, progressBackgroundColor: MColor.colors()[7])
        case .fade:
            titleText = "fade"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[0], progressColor: .white, progressBackgroundColor: MColor.colors()[0])
        case .grid:
            titleText = "grid"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[1], progressColor: .white, progressBackgroundColor: MColor.colors()[1])
        case .fold:
            titleText = "fold"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[2], progressColor: .white, progressBackgroundColor: MColor.colors()[2])
        case .wander:
            titleText = "wander"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[3], progressColor: .white, progressBackgroundColor: MColor.colors()[3])
        case .pendulum:
            titleText = "pendulum"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        case .loopCircle:
            titleText = "loopCircle"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[5], progressColor: .white, progressBackgroundColor: MColor.colors()[5])
        case .default:
            titleText = "default"
            MProgress.show("Hello world!", context: self, type: progressType, backgroundColor: MColor.colors()[4], progressColor: .white, progressBackgroundColor: MColor.colors()[4])
        }

        titleLabel.text = titleText
    }

}
