//
//  MProgressModel.swift
//  MProgress
//
//  Created by mchen on 2022/3/23.
//

import UIKit

class MProgressModel: NSObject {

    /// background color alpha value
    var alpha: CGFloat = 0.3
    var context: AnyObject?
    var identifier: String?
    var title: String?
    var message: String?
    var progressType: ProgressType = .plane
    /// ProgressView background color
    var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    /// Porgess color
    var progressColor: UIColor = UIColor.white
    /// Progress background color
    var progressBackgroundColor: UIColor = UIColor.white
    /// default progress style
    var defaultUIStyle: Bool = true
    /// default corner radius value
    var cornerRadiuValue: CGFloat = 5.0
    /// default progress width
    let defaultWidth: CGFloat = 270
    var shadeColor: UIColor = UIColor.black.withAlphaComponent(0.3)

    func contextRect() -> CGRect {
        if let context = self.context {
            if context.isKind(of: UIView.classForCoder()) {
                if let contentView = context as? UIView {
                    return contentView.bounds
                }
            } else if context.isKind(of: UIViewController.classForCoder()) {
                if let viewController = context as? UIViewController {
                    return viewController.view.bounds
                }
            } else if context.isKind(of: UIWindow.classForCoder()) {
                if let window = context as? UIWindow {
                    return window.bounds
                }
            } else {
                // Error
                fatalError("does not recognize context")
            }
        } else {
            let rect = CGRect(x: 0, y: 0, width: 270, height: 0)
            return rect
        }
        return MProgress.shared.window?.bounds ?? CGRect.zero
    }

    func contentHeight(_ progressHeight: CGFloat) -> CGFloat {
        let topMargin = 17.0
        let bottomMargin = 17.0
        let totalHeight = topMargin + progressHeight + bottomMargin
        var titleHeight: CGFloat = 0
        if let title = self.title {
            titleHeight = self.labelHeight(0, lineCount: 1, font: UIFont.boldSystemFont(ofSize: 14.0), text: title)
        }

        var messageHeight: CGFloat = 0
        if let message = self.message {
            messageHeight = self.labelHeight(0, lineCount: 1, font: UIFont.systemFont(ofSize: 13.0), text: message)
        }


        return totalHeight
    }

    func labelHeight(_ width: CGFloat, lineCount: Int, font: UIFont, text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        label.numberOfLines = lineCount
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
