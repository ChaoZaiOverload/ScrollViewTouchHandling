//
//  TouchDelayGestureRecognizer.swift
//  ScrollViewTouchHandling
//
//  Created by Yu, Huiting on 8/8/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import Foundation
import UIKit
class TouchDelayGestureRecognizer: UIGestureRecognizer {
    var timer: Timer?
    
    override init(target: Any?, action: Selector?) // designated initializer
    {
        super.init(target: target, action: action)
        self.delaysTouchesBegan = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { [weak self] (t) in
            self?.fail()
        })
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        fail()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        fail()
    }
    func fail() {
        self.state = .failed
    }
    
    override func reset() {
        timer?.invalidate()
        timer = nil
    }
}
