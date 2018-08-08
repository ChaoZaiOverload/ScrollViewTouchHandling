//
//  ViewController.swift
//  ScrollViewTouchHandling
//
//  Created by Yu, Huiting on 8/6/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//
// https://developer.apple.com/videos/play/wwdc2014/235/

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: UIView!
    @IBOutlet var scrollView: OverlayScrollView!
    @IBOutlet var drawerView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        canvasView.backgroundColor = UIColor.darkGray
        let touchesDelay = TouchDelayGestureRecognizer(target: nil, action: nil)
        canvasView.addGestureRecognizer(touchesDelay)
        
        addDots(count: 25, to: canvasView)
        DotView.arrangeRandomly(in: canvasView)
        
        addDots(count: 25, to: drawerView.contentView)
        DotView.arrangeRandomly(in: drawerView.contentView)
        
        
        scrollView.contentSize = CGSize(width: canvasView.bounds.size.width, height: canvasView.frame.size.height + drawerView.frame.size.height)
        
        //scrollView.isUserInteractionEnabled = false
        self.view.addGestureRecognizer(scrollView.panGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func addDots(count: Int, to view: UIView) {
        for _ in 0..<count {
            let dotView = DotView.randomDotView()
            let lp = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            lp.cancelsTouchesInView = false
            dotView.addGestureRecognizer(lp)
            lp.delegate = self
            
            view.addSubview(dotView)
        }

    }
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let v = gesture.view as? DotView else {
            print("cannot get view from gesture, gesture.view= \(gesture.view)")
            return
        }
        switch gesture.state {
        case .began:
            self.grab(v, with: gesture)
        case .changed:
            self.move(v, with: gesture)
        case .ended, .cancelled:
            self.drop(v, with: gesture)
        default:
            break
        }
    }
    
    func grab(_ dotView: UIView, with gesture: UILongPressGestureRecognizer) {
        dotView.center = self.view.convert(dotView.center, from: dotView.superview)
        self.view.addSubview(dotView)
        UIView.animate(withDuration: 0.2) {
            dotView.alpha = 0.8
            dotView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.move(dotView, with: gesture)
        }
        scrollView.panGestureRecognizer.isEnabled = false
        scrollView.panGestureRecognizer.isEnabled = true
    }
    
    func move(_ dotView: UIView, with gesture: UILongPressGestureRecognizer) {
        dotView.center = gesture.location(in: self.view)
    }
    
    func drop(_ dotView: UIView, with gesture: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            dotView.alpha = 1
            dotView.transform = CGAffineTransform.identity
        }
        let locationInDrawer = gesture.location(in: drawerView)
        if drawerView.bounds.contains(locationInDrawer) {
            drawerView.contentView.addSubview(dotView)
        } else {
            canvasView.addSubview(dotView)
        }
        dotView.center = self.view.convert(dotView.center, to: dotView.superview)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
