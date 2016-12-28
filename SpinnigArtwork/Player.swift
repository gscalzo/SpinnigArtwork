//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//

import UIKit

protocol Player {
    func play()
    func stop()
}

protocol PlayerObserver: class {
    var progress: Int { set get }
}

class FakePlayer: Player {
    private var timer: Timer!
    private var progress = 0
    weak var playerObserver: PlayerObserver?

    func play() {
        timer = Timer.scheduledTimer(timeInterval: 0.5,
            target: self,
            selector: #selector(FakePlayer.timerDidFire),
            userInfo: nil,
            repeats: true)
        progress = 0
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc func timerDidFire() {
        progress += 1
        if progress > 100 {
            timer.invalidate()
            return
        }
        
        playerObserver?.progress = progress
    }
}
