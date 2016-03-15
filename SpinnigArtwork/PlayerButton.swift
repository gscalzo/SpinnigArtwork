//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import UIKit

class PlayerButton: UIImageView {
    override class func layerClass() -> AnyClass {
        return ProgressLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (layer as! ProgressLayer).computePath(bounds)
    }
}

extension PlayerButton: PlayerObserver {
    func progress(progress: Int){
        (layer as! ProgressLayer).progress(progress)
    }
}