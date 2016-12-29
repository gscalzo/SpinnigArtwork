//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import UIKit

extension UIImageView {
    func addBlurEffect(fadeInDuration delay: Double) {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        UIView.animate(withDuration: delay) {
            blurEffectView.effect = UIBlurEffect(style: .light)
        }
    }
    
    func removeBlurEffect(fadeOutDuration delay: Double) {
        guard let blurEffectView = (subviews.filter {
            return $0 is UIVisualEffectView
        }).first as? UIVisualEffectView else {
            return
        }
        
        UIView.animate(withDuration: delay, animations: {
            blurEffectView.effect = nil
        }) { _ in
            blurEffectView.removeFromSuperview()
        }
    }
}
