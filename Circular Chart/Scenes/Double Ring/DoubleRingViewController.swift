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
        innerRing.strokeEndAnimation(fromValue: 1, toValue: 0, duration: 15)
    }
}
