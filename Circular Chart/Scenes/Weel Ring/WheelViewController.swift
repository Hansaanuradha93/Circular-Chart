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
        
        let gap: CGFloat = 10

        outerRing = createRing(radius: view.frame.width / 3 - 20, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.clear)
        fillerRing = createRing(radius: view.frame.width / 3 - 20 - gap / 2, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.backgroundColor, strokeEnd: 0, lineWidth: gap)
        innerRing = createRing(radius:  view.frame.width / 3 - 20 - gap, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.backgroundColor)
        
        view.layer.addSublayer(outerRing)
        view.layer.addSublayer(fillerRing)
        view.layer.addSublayer(innerRing)
    }
    
    
    private func createRing(radius: CGFloat, strokeColor: UIColor, fillColor: UIColor, strokeEnd: CGFloat = 1, lineWidth: CGFloat = 5) -> CAShapeLayer {
        
        let center = view.center
        let ring = CAShapeLayer()
         
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        ring.path = circularPath.cgPath
        ring.strokeColor = strokeColor.cgColor
        ring.fillColor = fillColor.cgColor
        ring.lineCap = CAShapeLayerLineCap.round
        ring.lineWidth = lineWidth
        ring.strokeEnd = strokeEnd
        
        return ring
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
