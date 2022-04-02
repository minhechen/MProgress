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
    var titleColor: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 17.0)
    var message: String?
    var messageColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    var messageFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    /// vertical UI space
    var verticalSpace: CGFloat = 8.0
    /// text label space
    var textSpace: CGFloat = 4.0
    /// progress type
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
    var marginSpace: CGFloat = 17.0
    /// Porgress super view
    /// - Returns: context rect
    func contextRect() -> CGRect {
        var resultRect = CGRect.zero
        if let context = self.context {
            if context.isKind(of: UIView.classForCoder()) {
                if let contentView = context as? UIView {
                    resultRect = contentView.bounds
                }
            } else if context.isKind(of: UIViewController.classForCoder()) {
                if let viewController = context as? UIViewController {
                    resultRect = viewController.view.bounds
                }
            } else if context.isKind(of: UIWindow.classForCoder()) {
                if let window = context as? UIWindow {
                    resultRect = window.bounds
                }
            } else {
                // Error
                fatalError("does not recognize context")
            }
        } else {
            resultRect = MProgress.shared.window?.bounds ?? CGRect.zero
        }
        return resultRect
    }

    /// Progress content rect
    /// - Returns: progress rect
    func progressRect() -> CGRect {
        var resultRect = CGRect.zero
        let contextRect = self.contentRect()
        if contextRect.width > 270.0 {
            resultRect = CGRect(x: 0, y: 0, width: 270, height: 0)
        } else {
            let width = (contextRect.height > contextRect.width ? contextRect.width : contextRect.height) * progressScale
            resultRect = CGRect(x: 0, y: 0, width: width, height: width)
        }
        resultRect = CGRect(x: 0, y: 0, width: resultRect.width, height: resultRect.height)
        return resultRect
    }

    /// Display content rect
    /// - Returns: display content rect
    func contentRect() -> CGRect {
        let contextRect = self.contextRect()
        var resultRect = CGRect.zero
        if contextRect.width > 270.0 {
            resultRect = CGRect(x: 0, y: 0, width: 270, height: 0)
        } else {
            let width = (contextRect.height > contextRect.width ? contextRect.width : contextRect.height) * progressScale
            resultRect = CGRect(x: 0, y: 0, width: width, height: 0)
        }
        let rectHeight = self.contentHeight(resultRect.width)
        return CGRect(x: 0, y: 0, width: resultRect.width, height: rectHeight)
    }

    /// Display content height
    /// - Parameters:
    ///   - progressHeight: progress height
    ///   - labelWidth: label width
    /// - Returns: total display content height
    func contentHeight(_ contentWidth: CGFloat) -> CGFloat {
        let labelWidth = contentWidth * progressScale
        let progressHeight = contentWidth * progressScale
        var titleHeight: CGFloat = 0
        var spaceHeight: CGFloat = 0
        if let title = self.title, title.count > 0 {
            titleHeight = self.labelHeight(labelWidth, lineCount: 1, font: self.titleFont, text: title)
            spaceHeight += verticalSpace
        }
        var messageHeight: CGFloat = 0
        if let message = self.message, message.count > 0 {
            messageHeight = self.labelHeight(labelWidth, lineCount: 3, font: self.messageFont, text: message)
            spaceHeight += textSpace
        }
        let totalHeight = progressHeight + titleHeight + messageHeight + spaceHeight
        if (totalHeight + 2 * marginSpace) >= contentWidth {
            if totalHeight >= contentWidth {
                if (totalHeight + 2 * marginSpace) > self.contextRect().height {
                    if totalHeight > self.contextRect().height {
                        marginSpace = 0.0
                        return self.contextRect().height
                    } else {
                        marginSpace = (self.contextRect().height - totalHeight) / 2
                        return self.contextRect().height
                    }
                } else {
                    return totalHeight + 2 * marginSpace
                }
            } else {
                marginSpace = (contentWidth - totalHeight) / 2
                return contentWidth
            }
        } else {
            marginSpace = (contentWidth - totalHeight) / 2
            return contentWidth
        }
    }

    /// Caculate label height
    /// - Parameters:
    ///   - width: label width
    ///   - lineCount: labe line count
    ///   - font: label font
    ///   - text: display text
    /// - Returns: label height
    func labelHeight(_ width: CGFloat, lineCount: Int, font: UIFont, text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        label.numberOfLines = lineCount
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
