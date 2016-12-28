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
    func progress(value progress: Int){
        (layer as! ProgressLayer).progress(value: progress)
    }
}
