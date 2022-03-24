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
}
