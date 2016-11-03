//
//  ViewController.swift
//  2910_2_Animations
//
//  Created by Hamza on 03/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redLoopOnce = false
    var yellowLoopOnce = false
    var alphaLoopOnce = false
    
    // Get animation way, on completion callback, to have an infinite animation
    enum Ways {
        case forward
        case backward
    }
    
    // MARK Properties
    @IBOutlet weak var redBlockView: UIView!
    @IBOutlet weak var yellowBlockView: UIView!
    @IBOutlet weak var alphaBlockView: UIView!
    @IBOutlet weak var borderedBlockView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        borderedBlockView.layer.borderWidth = CGFloat(0.0)
        borderedBlockView.layer.borderColor = UIColor(hexString: "#ff9933ff")?.cgColor
        animateBlocks()
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Animate blocks
    func animateBlocks() {
        animateRedBlock(redBlockView, way: .forward)
        animateYellowBlock(yellowBlockView, way: .forward)
        animateAlphaBlock(alphaBlockView, way: .forward)
        animateAlphaBlock(borderedBlockView, way: .forward)
    }
    
    // Animate Red Block
    func animateRedBlock(_ block: UIView, way: Ways) {
        var scaleSize: CGFloat
        var opacityValue: CGFloat
        var bgColor: UIColor
        var waitMe: TimeInterval
        var animationTime: TimeInterval
        var newWay: Ways
        switch(way){
        case .forward:
            scaleSize = 1.66
            opacityValue = 0.7
            waitMe = 1.0
            if redLoopOnce {
                waitMe = 1.5
            }
            redLoopOnce = true
            animationTime = 1.0
            bgColor = UIColor(hexString: "#ff0000ff")!
            newWay = .backward
        case .backward:
            scaleSize = 1.0
            opacityValue = 1
            waitMe = 0.0
            animationTime = 0.6
            bgColor = UIColor(hexString: "#ff3300ff")!
            newWay = .forward
        }
        UIView.animate(withDuration: animationTime, delay: waitMe, options: [.curveEaseIn], animations: {
            block.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
            block.alpha = opacityValue
            block.backgroundColor = bgColor
        }, completion: { finished in
            if finished {
                self.animateRedBlock(block, way: newWay)
            }
            })
    }
    
    // Animate Yellow Block
    func animateYellowBlock(_ block: UIView, way: Ways) {
        var scaleSize: CGFloat
        var newWay: Ways
        var waitMe: TimeInterval
        var animationTime: TimeInterval
        switch(way){
        case .forward:
            scaleSize = 0.2
            waitMe = 1.4
            if yellowLoopOnce {
                waitMe = 1.9
            }
            yellowLoopOnce = true

            animationTime = 0.6
            newWay = .backward
        case .backward:
            scaleSize = 1.0
            waitMe = 0.0
            animationTime = 0.6
            newWay = .forward
        }

        UIView.animate(withDuration: animationTime, delay: waitMe, options: [.curveEaseOut], animations: {
            block.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
        }, completion: { finished in
            if finished {
                self.animateYellowBlock(block, way: newWay)
            }
        })
    }
    
    // Animate Alpha Yellow Block
    func animateAlphaBlock(_ block: UIView, way: Ways) {
        var scaleSize: CGFloat
        var newWay: Ways
        var waitMe: TimeInterval
        var animationTime: TimeInterval
        switch(way){
        case .forward:
            waitMe = 0.8
            animationTime = 1.2
            scaleSize = 0.48
            newWay = .backward
        case .backward:
            waitMe = 0.1
            animationTime = 1
            scaleSize = 1.0
            newWay = .forward
        }
        
        
        UIView.animate(withDuration: animationTime, delay: waitMe, options: [.curveEaseInOut], animations: {
            block.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
        }, completion: { finished in
              if finished {
                 self.animateAlphaBlock(block, way: newWay)
              }
            })
        }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
