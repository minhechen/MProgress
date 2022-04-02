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
//        view.clipsToBounds = true
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
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

        self.setupContentView(progressModel)
        self.setupProgress(progressModel)
        self.setupTitle(progressModel)
        self.setupMessage(progressModel)
        self.backgroundColor = progressModel.shadeColor
    }

    func setupContentView(_ model: MProgressModel) {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = model.cornerRadiuValue
        contentView.clipsToBounds = true
        if model.defaultUIStyle {
            contentView.widthAnchor.constraint(equalToConstant: CGFloat(model.contentRect().width)).isActive = true
            contentView.heightAnchor.constraint(equalToConstant: CGFloat(model.contentRect().height)).isActive = true
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        } else {
            contentView.widthAnchor.constraint(equalToConstant: CGFloat(model.contentRect().width)).isActive = true
            contentView.heightAnchor.constraint(equalToConstant: CGFloat(model.contentRect().height)).isActive = true
//            contentView.heightAnchor.constraint(equalToConstant: CGFloat(model.contextRect().height)).isActive = true
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        contentView.backgroundColor = model.backgroundColor
        contentView.layoutIfNeeded()
    }

    func setupProgress(_ model: MProgressModel) {
        self.progress = self.progress(model)
        contentView.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        if model.defaultUIStyle {
            progress.widthAnchor.constraint(equalToConstant: model.progressRect().width).isActive = true

            progress.heightAnchor.constraint(equalToConstant: model.progressRect().height).isActive = true
            progress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: model.marginSpace).isActive = true
            progress.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        } else {
            progress.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: progressScale).isActive = true
            progress.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: progressScale).isActive = true
            progress.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            progress.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        }

        progress.startAnimation()
        progress.layoutIfNeeded()
    }

    /// Set up title label text
    /// - Parameter model: progress model
    func setupTitle(_ model: MProgressModel) {

        guard let title = model.title, title.count > 0 else { return }
        contentView.addSubview(titleLabel)
        titleLabel.text = model.title
        titleLabel.textColor = model.titleColor
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if model.defaultUIStyle {
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: progressScale).isActive = true

            titleLabel.heightAnchor.constraint(equalToConstant: 17.0).isActive = true
            titleLabel.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 8.0).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: progress.centerXAnchor).isActive = true
        } else {
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: progressScale).isActive = true
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: progressScale).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        }
    }

    /// Set up message label text
    /// - Parameter model: progress model
    func setupMessage(_ model: MProgressModel) {
        guard let message = model.message, message.count > 0 else { return }
        contentView.addSubview(messageLabel)
        messageLabel.text = model.message
        messageLabel.textColor = model.messageColor
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        if model.defaultUIStyle {
            messageLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: progressScale).isActive = true
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: progress.centerXAnchor).isActive = true
        } else {
            messageLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: progressScale).isActive = true
            messageLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: progressScale).isActive = true
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        }
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
