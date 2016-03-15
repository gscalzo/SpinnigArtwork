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

    private var playing = false {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func artworkDidTap(sender: AnyObject) {
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
        let image = UIImage(named: "AbbeyRoadArtwork", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
        artworkImageView.image = image
    }
}

extension SpinnableArtwork: PlayerObserver {
    func progress(progress: Int){
        print("Progress: \(progress)")
        playerButton.progress(progress)
    }
}

private extension SpinnableArtwork {
    func setup() {
        view = loadViewFromNib(theClassName)
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        updateUI()
    }
    
    func loadViewFromNib(nibName: String) -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    var theClassName: String {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
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