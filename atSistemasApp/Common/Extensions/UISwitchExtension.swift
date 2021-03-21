//
//  UISwitchExtension.swift
//  atSistemasApp
//
//  Created by APPLE on 21/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

extension UISwitch {
    /// Scale an UISwitch to a size
    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31.0
        let standardWidth: CGFloat = 51.0
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        self.transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
