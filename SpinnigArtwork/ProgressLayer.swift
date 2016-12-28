//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import Foundation
import UIKit

class ProgressLayer: CAShapeLayer {
    private struct Constants {
        static let startAngle = -CGFloat(M_PI_2)
        static let endAngle: CGFloat = CGFloat(2*M_PI) + startAngle
    }
    
    func compute(path rect: CGRect) {
        strokeColor = UIColor.white.cgColor
        lineWidth = 8
        lineCap = kCALineCapButt;
        strokeEnd = 0.00;
        fillColor = UIColor.clear.cgColor
        
        let side = rect.width / 2.0
        let radius = side - lineWidth
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: side, y: side),
                    radius: radius,
                    startAngle: Constants.startAngle,
                    endAngle: Constants.endAngle,
                    clockwise: false)
        self.path = path
    }
    
    var progress: Int = 0  {
        didSet {
            if strokeEnd >= 1 {
                strokeStart = (CGFloat(progress)-1)/100.0
            } else {
                strokeStart = 0
            }
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 0.5
            animation.fillMode = kCAFillModeForwards
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.isRemovedOnCompletion = false
            strokeEnd = CGFloat(progress)/100.0
            
            add(animation, forKey: "strokeEnd animation")
        }
    }
}
