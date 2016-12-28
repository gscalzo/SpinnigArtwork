//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import UIKit

class PlayerButton: UIImageView {
    override class var layerClass : AnyClass {
        return ProgressLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (layer as! ProgressLayer).compute(path: bounds)
    }
}

extension PlayerButton: PlayerObserver {
    var progress: Int {
        set(progress) {
            (layer as! ProgressLayer).progress = progress
        }
        get {
            return (layer as! ProgressLayer).progress
        }
    }
}
