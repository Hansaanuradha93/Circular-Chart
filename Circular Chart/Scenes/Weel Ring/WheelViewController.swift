import UIKit

class WheelViewController: UIViewController {

    // MARK: Properties
    let outerRing = CAShapeLayer()
    let innerRing = CAShapeLayer()
    
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addRings()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}


// MARK: - Methods
extension WheelViewController {
    
    private func configureViewController() {
        view.backgroundColor = .backgroundColor
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    private func addRings() {
        view.layer.addSublayer(createOuterRing())
        view.layer.addSublayer(createInnerRing())
    }
    
    
    private func createOuterRing() -> CAShapeLayer {
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        outerRing.path = circularPath.cgPath
        outerRing.strokeColor = UIColor.trackStrokeColor.cgColor
        outerRing.fillColor = UIColor.clear.cgColor
        outerRing.lineWidth = 5
        
        return outerRing
    }
    
    
    private func createInnerRing() -> CAShapeLayer {
        
        let center = view.center
        let gap: CGFloat = 10
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20 - gap, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        innerRing.path = circularPath.cgPath
        innerRing.strokeColor = UIColor.trackStrokeColor.cgColor
        innerRing.fillColor = UIColor.backgroundColor.cgColor
        innerRing.lineCap = CAShapeLayerLineCap.round
        innerRing.lineWidth = 5
        innerRing.strokeEnd = 1
        
        return innerRing
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
