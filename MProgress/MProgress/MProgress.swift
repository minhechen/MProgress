//
//  MProgress.swift
//  MProgress
//
//  Created by mchen on 2022/3/22.
//

import UIKit

public class MProgress {
    static var shared = MProgress()
    private var progresses: [Progress] = [Progress]()
    private var progressViews: [ProgressView] = [ProgressView]()
    let window = UIApplication.shared.windows.first
    public class func show(_ title: String? = nil, message: String? = nil, context: AnyObject? = nil, identifer: String? = nil, type: ProgressType? = nil, backgroundColor: UIColor? = nil, progressColor: UIColor? = nil, progressBackgroundColor: UIColor? = nil, shadeColor: UIColor? = nil, interactionEnabled: Bool? = false) {

        let progressModel = MProgressModel()
        progressModel.backgroundColor = backgroundColor ?? UIColor.white
        progressModel.progressColor = progressColor ?? UIColor.white
        progressModel.progressBackgroundColor = progressBackgroundColor ?? UIColor.white
        progressModel.title = title
        progressModel.message = message
        progressModel.context = context
        progressModel.identifier = identifer
        progressModel.progressType = type ?? .default
        progressModel.shadeColor = shadeColor ?? UIColor.black.withAlphaComponent(0.3)
        progressModel.interactionEnabled = interactionEnabled ?? false
        let progressView = self.showProgressView(progressModel)
        MProgress.shared.progressViews.append(progressView)
    }

    class func showProgressView(_ model: MProgressModel) -> ProgressView {
        let progress = ProgressView(model)
        if let context = model.context {
            if context.isKind(of: UIView.classForCoder()) {
                if let contentView = context as? UIView {
                    contentView.addSubview(progress)
                    progress.center = contentView.center
                }
            } else if context.isKind(of: UIViewController.classForCoder()) {
                if let viewController = context as? UIViewController {
                    viewController.view.addSubview(progress)
                    progress.center = viewController.view.center
                }
            } else if context.isKind(of: UIWindow.classForCoder()) {
                if let window = context as? UIWindow {
                    window.addSubview(progress)
                    progress.center = window.center
                }
            } else {
                // Error
                fatalError("does not recognize context")
            }
        } else {
            MProgress.shared.window?.addSubview(progress)
            progress.center = MProgress.shared.window?.center ?? CGPoint(x: 0, y: 0)
        }
        progress.frame = progress.superview?.bounds ?? CGRect.zero
        return progress
    }

    /// Remove specify progress view
    /// - Parameters:
    ///   - context: in which context
    ///   - identifer: progress view identifier
    class func dismiss(_ context: AnyObject? = nil, identifer: String? = nil) {
        self.dismissProgressView(context, identifer: identifer)
    }

    /// Remove all progress view
    class func dismissAll() {
        let progressViews = MProgress.shared.progressViews
        for progressView in progressViews {
            progressView.dismissView()
        }
    }

    /// Remove specify progress view
    /// - Parameters:
    ///   - context: in which context
    ///   - identifer: progress view identifier
    class func dismissProgressView(_ context: AnyObject? = nil, identifer: String? = nil) {
        let progressViews = MProgress.shared.progressViews
        for progressView in progressViews {
            guard let progressModel = progressView.progressModel else {
                progressView.dismissView()
                return
            }

            if let context = context {
                guard let progressContext = progressModel.context else {
                    progressView.dismissView()
                    return
                }
                if progressContext === context {
                    if progressModel.identifier == identifer {
                        progressView.dismissView()
                    } else {
                        continue
                    }
                } else {
                    continue
                }
            } else {
                if progressModel.identifier == identifer {
                    progressView.dismissView()
                } else {
                    continue
                }
            }
        }
    }

}
