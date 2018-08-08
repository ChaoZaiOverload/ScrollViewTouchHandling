//
//  DotView.swift
//  ScrollViewTouchHandling
//
//  Created by Yu, Huiting on 8/6/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import Foundation
import UIKit

class DotView: UIView {
    static func randomDotView() -> DotView {
        let color = UIColor(red: random(255)/255, green: random(255)/255, blue: random(255)/255, alpha: 1)
        let v = DotView()
        v.backgroundColor = color
        v.frame = .zero
        return v
    }
    
    static func arrangeRandomly(in view: UIView) {
        for v in view.subviews {
            if let dotV = v as? DotView {
                let y = random(view.bounds.size.height)
                let x = random(view.bounds.size.width)
                dotV.frame.origin = CGPoint(x: x, y: y)
                dotV.frame.size = CGSize(width: 40.0, height: 40.0)
            }
        }
        view.setNeedsLayout()
    }
    
    static func random(_ v: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(floor(v))))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
}
