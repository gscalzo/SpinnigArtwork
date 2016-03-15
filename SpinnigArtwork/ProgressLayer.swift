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
    
    func computePath(rect: CGRect) {
        strokeColor = UIColor.whiteColor().CGColor
        lineWidth = 8
        lineCap = kCALineCapButt;
        strokeEnd = 0.00;
        fillColor = UIColor.clearColor().CGColor
        
        let side = rect.width / 2.0
        let radius = side - lineWidth
        
        let path = CGPathCreateMutable()
        CGPathAddArc(path, nil, side, side, radius, Constants.startAngle, Constants.endAngle, false)
        self.path = path
    }
    
    func progress(progress: Int) {
        if strokeEnd >= 1 {
            strokeStart = (CGFloat(progress)-1)/100.0
        } else {
            strokeStart = 0
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.5
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.removedOnCompletion = false
        strokeEnd = CGFloat(progress)/100.0

        addAnimation(animation, forKey: "strokeEnd animation")
    }
}
