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
            stopAnimation()
            player?.stop()
        } else {
            startAnimation()
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

private extension SpinnableArtwork {
    func startAnimation() {
        artworkImageView.addBlurEffect(fadeInDuration: 1.5)
        roundImage {
            self.startRotation()
        }
    }
    
    func stopAnimation() {
        stopRotation()
        artworkImageView.removeBlurEffect(fadeOutDuration: 1.5)
        restoreImage()
    }
    
    
    private func startRotation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = 6.0
        rotateAnimation.repeatDuration = .infinity
        rotateAnimation.isRemovedOnCompletion = false
        artworkImageView.layer.add(rotateAnimation, forKey: "rotate")
    }
    
    private func stopRotation() {
        artworkImageView.layer.removeAnimation(forKey: "rotate")
    }
    
    private func roundImage(onCompletion completion: @escaping () -> Void) {
        CATransaction.begin()
        
        view.layer.mask = maskLayer(forBounds: artworkImageView.bounds)
        view.layer.mask?.bounds = view.bounds
        
        CATransaction.setCompletionBlock(completion)
        
        let animation = maskAnimation(from: 1.5, to: 1.0, duration: 0.2)
        view.layer.mask?.add(animation, forKey: "apply_mask")
        
        CATransaction.commit()
    }
    
    private func restoreImage() {
        view.layer.mask?.bounds = view.bounds
        let animation = maskAnimation(from: 1.0, to: 1.5, duration: 0.5)
        view.layer.mask?.add(animation, forKey: "apply_mask")
    }
    
    private func maskAnimation(from fromValue: Double, to toValue: Double, duration: Double) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
   
        return animation
    }
    
    private func maskLayer(forBounds bounds: CGRect) -> CALayer {
        let maskLayer = CAShapeLayer()
        maskLayer.path = CGPath(ellipseIn: bounds, transform: nil)
        let point = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        maskLayer.position = point
        maskLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return maskLayer
    }
}

extension SpinnableArtwork {
    override func prepareForInterfaceBuilder() {
        let image = UIImage(named: "AbbeyRoadArtwork",
                            in: Bundle(for: type(of: self)),
                            compatibleWith: nil)
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
