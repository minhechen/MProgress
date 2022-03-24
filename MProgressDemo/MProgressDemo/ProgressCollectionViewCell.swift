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
            MProgress.show("Hello world!", context: self, type: .chase, backgroundColor: MColor.colors()[0], progressColor: .white, progressBackgroundColor: MColor.colors()[0])
        case .bounce:
            titleText = "bounce"
            MProgress.show("Hello world!", context: self, type: .bounce, backgroundColor: MColor.colors()[1], progressColor: .white, progressBackgroundColor: MColor.colors()[1])
        case .wave:
            titleText = "wave"
        case .pulse:
            titleText = "pulse"
        case .flow:
            titleText = "flow"
        case .swing:
            titleText = "swing"
        case .circle:
            titleText = "circle"
        case .fade:
            titleText = "fade"
        case .grid:
            titleText = "grid"
        case .fold:
            titleText = "fold"
        case .wander:
            titleText = "wander"
        case .default:
            titleText = "default"
        }

        titleLabel.text = titleText
    }

}
