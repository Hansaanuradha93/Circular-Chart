import UIKit

class RingViewController: UIViewController {

    // MARK: Properties
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var isFirstTime: Bool = true

    
    // View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        setupNotification()
        addRings()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}


// MARK: - Objc Methods
extension RingViewController {
    
    @objc private func willEnterForeground() {
        
        if !isFirstTime {
            addPulseAnimation()
        } else {
            isFirstTime.toggle()
        }
    }
    
    
    @objc func handleTap() {
        
        addPulseAnimation()
        addStrokeEndAnimation()
    }
}


// MARK: - Methods
extension RingViewController {
    
    private func configureViewController() { view.backgroundColor = .backgroundColor }

    
    private func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
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
    
    
    private func addRings() {
        
        
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 15
        view.layer.addSublayer(trackLayer)
        
    
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        shapeLayer.fillColor = UIColor.backgroundColor.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 15
        shapeLayer.strokeEnd = 1
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    private func addStrokeEndAnimation() {
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 1
        strokeAnimation.toValue = 0
        strokeAnimation.duration = 15
        
        strokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(strokeAnimation, forKey: "strokeEnd")
    }
    
    
    private func addPulseAnimation() {
        let center = view.center
        let radius = view.frame.width / 3 - 20
        let pulse = PulseLayer(numberOfPulses: 10, radius: radius, position: center, backgroundColor: .pulsatingFillColor)
        pulse.animationDuration = 1.5
        pulse.backgroundColor = UIColor.systemPink.cgColor
        
        view.layer.insertSublayer(pulse, below: trackLayer)
    }
}

