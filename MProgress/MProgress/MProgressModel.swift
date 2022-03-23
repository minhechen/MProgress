//
//  MProgressModel.swift
//  MProgress
//
//  Created by mchen on 2022/3/23.
//

import UIKit

class MProgressModel: NSObject {
    var context: AnyObject?
    var identifier: String?
    var title: String?
    var message: String?
    var progressType: ProgressType = .plane
}
