//
//  NSBundleExtension.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
extension NSBundle {
    class func infoVar(named: String) -> String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(named) as? String
    }
}