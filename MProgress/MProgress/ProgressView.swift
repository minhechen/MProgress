//
//  ProgressView.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

class ProgressView: UIView {
    var progressModel: MProgressModel?
    private var progress: Progress = Progress()
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

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

        self.setupContentView()
        self.setupProgress(progressModel)
        self.backgroundColor = progressModel.backgroundColor
    }

    func setupContentView() {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progressScale).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: progressScale).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.layoutIfNeeded()
    }

    func setupProgress(_ progressModel: MProgressModel) {
        self.progress = self.progress(progressModel)
        contentView.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progressScale).isActive = true
        progress.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: progressScale).isActive = true
        progress.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progress.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progress.startAnimation()
        progress.layoutIfNeeded()
    }

    func progress(_ progressModel: MProgressModel) -> Progress {

        let type = progressModel.progressType
        switch type {
        case .plane:
            progress = Plane()
        case .chase:
            progress = Chase()
        case .bounce:
            progress = Bounce()
        case .wave:
            progress = Wave()
        case .pulse:
            progress = Pulse()
        case .flow:
            progress = Flow()
        case .swing:
            progress = Swing()
        case .circle:
            progress = Circle()
        case .fade:
            progress = Fade()
        case .grid:
            progress = Grid()
        case .fold:
            progress = Fold()
        case .wander:
            progress = Wander()
        case .pendulum:
            progress = Pendulum()
        case .loopCircle:
            progress = LoopCircle(progressModel)
        case .default:
            progress = Plane()
        }
        progress.backgroundColor = progressModel.progressBackgroundColor
        progress.setContentColor(progressModel.progressColor)
        return progress
    }
}
