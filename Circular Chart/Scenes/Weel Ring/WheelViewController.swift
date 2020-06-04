import UIKit

class WheelViewController: UIViewController {

    // MARK: Properties
    var outerRing = CAShapeLayer()
    var innerRing = CAShapeLayer()
    var fillerRing = CAShapeLayer()
    
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addRings()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}


// MARK: - Objc Methods
extension WheelViewController {
    
    @objc func handleTap() { addStrokeEndAnimation() }
}


// MARK: - Methods
extension WheelViewController {
    
    private func configureViewController() {
        view.backgroundColor = .backgroundColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    private func addRings() {
        outerRing = createRing(radius: view.frame.width / 3 - 20, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.clear)
        view.layer.addSublayer(createOuterRing())
        view.layer.addSublayer(createFillerRing())
        view.layer.addSublayer(createInnerRing())
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

    
    
    private func createOuterRing() -> CAShapeLayer {
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        outerRing.path = circularPath.cgPath
        outerRing.strokeColor = UIColor.outlineStrokeColor.cgColor
        outerRing.fillColor = UIColor.clear.cgColor
        outerRing.lineWidth = 5
        
        return outerRing
    }
    
    
    private func createInnerRing() -> CAShapeLayer {
        
        let center = view.center
        let gap: CGFloat = 10
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20 - gap, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        innerRing.path = circularPath.cgPath
        innerRing.strokeColor = UIColor.outlineStrokeColor.cgColor
        innerRing.fillColor = UIColor.backgroundColor.cgColor
        innerRing.lineCap = CAShapeLayerLineCap.round
        innerRing.lineWidth = 5
        innerRing.strokeEnd = 1
        
        return innerRing
    }
    
    
    private func createFillerRing() -> CAShapeLayer {
        
        let center = view.center
        let gap: CGFloat = 10
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20 - gap / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        fillerRing.path = circularPath.cgPath
        fillerRing.strokeColor = UIColor.outlineStrokeColor.cgColor
        fillerRing.fillColor = UIColor.backgroundColor.cgColor
        fillerRing.lineCap = CAShapeLayerLineCap.round
        fillerRing.lineWidth = gap
        fillerRing.strokeEnd = 0
        
        return fillerRing
    }
    
    
    private func addStrokeEndAnimation() {
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 1
        strokeAnimation.duration = 15
        
        strokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeAnimation.isRemovedOnCompletion = false
        
        fillerRing.add(strokeAnimation, forKey: "strokeEnd")
    }
}
