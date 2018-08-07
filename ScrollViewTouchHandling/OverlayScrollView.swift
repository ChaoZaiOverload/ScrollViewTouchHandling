//
//  OverlayScrollView.swift
//  ScrollViewTouchHandling
//
//  Created by Yu, Huiting on 8/6/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import Foundation
import UIKit
class OverlayScrollView: UIScrollView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let v = super.hitTest(point, with: event)
        if v == self {
            return nil
        }
        return v
    }
}
