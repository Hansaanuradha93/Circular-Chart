import UIKit

class DoubleRingViewController: UIViewController {

    // MARK: Properties
    var outerRing = CAShapeLayer()
    var innerRing = CAShapeLayer()
    
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addRings()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}


// MARK: - Objc Methods
extension DoubleRingViewController {
    
    @objc func handleTap() { addStrokeEndAnimation() }
}


// MARK: - Methods
extension DoubleRingViewController {
    
    private func configureViewController() {
        view.backgroundColor = .backgroundColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    private func addRings() {
        innerRing = createRing(radius: view.frame.width / 3 - 20 - 15, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.backgroundColor)
        outerRing = createRing(radius: view.frame.width / 3 - 20, strokeColor: UIColor.trackStrokeColor, fillColor: UIColor.clear)
        view.layer.addSublayer(outerRing)
        view.layer.addSublayer(innerRing)
    }
    
    
    private func createOuterRing() -> CAShapeLayer {
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        outerRing.path = circularPath.cgPath
        outerRing.strokeColor = UIColor.trackStrokeColor.cgColor
        outerRing.fillColor = UIColor.clear.cgColor
        outerRing.lineWidth = 15
        
        return outerRing
    }
    
    
    private func createInnerRing() -> CAShapeLayer {
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20 - 15, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        innerRing.path = circularPath.cgPath
        innerRing.strokeColor = UIColor.outlineStrokeColor.cgColor
        innerRing.fillColor = UIColor.backgroundColor.cgColor
        innerRing.lineCap = CAShapeLayerLineCap.round
        innerRing.lineWidth = 15
        innerRing.strokeEnd = 1
        
        return innerRing
    }
    
    private func createRing(radius: CGFloat, strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        
        let center = view.center
        let ring = CAShapeLayer()
         
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        ring.path = circularPath.cgPath
        ring.strokeColor = strokeColor.cgColor
        ring.fillColor = fillColor.cgColor
        ring.lineCap = CAShapeLayerLineCap.round
        ring.lineWidth = 15
        ring.strokeEnd = 1
        
        return ring
    }
    
    
    private func addStrokeEndAnimation() {
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 1
        strokeAnimation.toValue = 0
        strokeAnimation.duration = 15
        
        strokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeAnimation.isRemovedOnCompletion = false
        
        innerRing.add(strokeAnimation, forKey: "strokeEnd")
    }
}
