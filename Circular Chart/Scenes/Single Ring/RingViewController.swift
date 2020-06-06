import UIKit

class RingViewController: UIViewController {

    // MARK: Properties
    var shapeRing = CAShapeLayer()
    var trackRing = CAShapeLayer()
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
    
    private func configureViewController() {
        
        view.backgroundColor = .backgroundColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    
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
        
        let radius: CGFloat = view.frame.width / 3 - 20
        trackRing = createRing(radius: radius, strokeColor:  UIColor.trackStrokeColor, fillColor: UIColor.clear)
        shapeRing = createRing(radius: radius, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.backgroundColor)
        
        view.layer.addSublayer(trackRing)
        view.layer.addSublayer(shapeRing)
    }
    
    
    private func addStrokeEndAnimation() { shapeRing.strokeEndAnimation(fromValue: 1, toValue: 0, duration: 15) }
    
    
    private func addPulseAnimation() {
        
        let center = view.center
        let radius = view.frame.width / 3 - 20
        let pulse = PulseLayer(numberOfPulses: 10, radius: radius, position: center, backgroundColor: .pulsatingFillColor)
        pulse.animationDuration = 1.5
        pulse.backgroundColor = UIColor.pulsatingFillColor.cgColor
        
        view.layer.insertSublayer(pulse, below: trackRing)
    }
}

