//
//  ProgressView.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class ProgressView: UIView {
    var progressModel: MProgressModel?
    private var backgroundView: UIView?
    private var progress: Progress?

    init(_ model: MProgressModel) {
        super.init(frame: CGRect.zero)
        self.progressModel = model
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let progressModel = self.progressModel else { return }
        backgroundView = UIView()
        let type = progressModel.progressType
        switch type {
        case .plane:
            progress = Plane()
        case .chase:
            progress = Plane()
        case .bounce:
            progress = Plane()
        case .wave:
            progress = Plane()
        case .pulse:
            progress = Plane()
        case .flow:
            progress = Plane()
        case .swing:
            progress = Plane()
        case .circle:
            progress = Plane()
        case .fade:
            progress = Plane()
        case .grid:
            progress = Plane()
        case .fold:
            progress = Plane()
        case .wander:
            progress = Plane()
        case .default:
            progress = Plane()
        }
        guard let progress = progress else {
            return
        }
        progress.backgroundColor = UIColor.red
        self.backgroundColor = UIColor.yellow
        self.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progressScale).isActive = true
        progress.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: progressScale).isActive = true
        progress.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progress.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progress.layoutIfNeeded()
    }
}
