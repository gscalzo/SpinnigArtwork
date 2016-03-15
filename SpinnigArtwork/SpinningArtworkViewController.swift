//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import UIKit

class SpinningArtworkViewController: UIViewController {
    @IBOutlet var spinnableArtwork: SpinnableArtwork! {
        didSet {
            let player = FakePlayer()
            player.playerObserver = spinnableArtwork
            spinnableArtwork.player = player
        }
    }
}

