//
//  Copyright © 2016 Giordano Scalzo. All rights reserved.
//
import UIKit

@IBDesignable
class SpinnableArtwork: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var playerButton: PlayerButton!

    @IBInspectable var imageName: String! {
        didSet {
            artworkImageView.image = UIImage(named: imageName)
        }
    }

    var player: Player?

    fileprivate var playing = false {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func artworkDidTap(_ sender: AnyObject) {
        if playing {
            player?.stop()
        } else {
            player?.play()
        }
        playing = !playing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension SpinnableArtwork {
    override func prepareForInterfaceBuilder() {
        let image = UIImage(named: "AbbeyRoadArtwork")
        artworkImageView.image = image
    }
}

extension SpinnableArtwork: PlayerObserver {
    var progress: Int {
        set(progress) {
            print("Progress: \(progress)")
            playerButton.progress = progress
        }
        get {
            return playerButton.progress
        }
    }
}

private extension SpinnableArtwork {
    func setup() {
        view = loadViewFromNib(theClassName)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        updateUI()
    }
    
    func loadViewFromNib(_ nibName: String) -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    var theClassName: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    //...
    func updateUI() {
        if playing {
            playerButton.image = UIImage(named: "large_pause")
        } else {
            playerButton.image = UIImage(named: "large_play")
        }
    }
}
