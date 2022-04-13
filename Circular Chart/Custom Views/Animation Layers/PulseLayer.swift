import UIKit

class PulseLayer: CALayer {

    // MARK: Properites
    var animationGroup = CAAnimationGroup()
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 3
    var radius: CGFloat = 200
    var numberOfPulses: Float = Float.infinity
    
    
    // MARK: Initializers
    override init(layer: Any) { super.init(layer: layer) }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    init(numberOfPulses: Float = Float.infinity, radius: CGFloat, position: CGPoint, backgroundColor: UIColor) {
        super.init()
        self.backgroundColor = backgroundColor.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async { self.add(self.animationGroup, forKey: "pulse") }
        }
    }
}

// MARK: - Methods
private extension PulseLayer {
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 1.2
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0, 0.2, 0.4]
        opacityAnimation.keyTimes = [0, 0.4, 0.6]
        return opacityAnimation
    }
    
    
    func setupAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses
        animationGroup.autoreverses = true
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationGroup.timingFunction = defaultCurve
        animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
}
