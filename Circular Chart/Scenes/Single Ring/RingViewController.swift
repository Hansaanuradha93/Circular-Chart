import UIKit

class RingViewController: UIViewController {

    // MARK: Properties
    var shapeRing = CAShapeLayer()
    var trackRing = CAShapeLayer()
    var isFirstTime: Bool = true
    var radius: CGFloat = 0

    
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
    
    
    private func addRings() {
        radius = view.frame.width / 3 - 20
        
        trackRing = addRing(radius: radius, strokeColor:  .trackStrokeColor, fillColor: .clear)
        shapeRing = addRing(radius: radius, strokeColor: .outlineStrokeColor, fillColor: .backgroundColor)
        
        view.layer.addSublayer(trackRing)
        view.layer.addSublayer(shapeRing)
    }
    
    
    private func addStrokeEndAnimation() { shapeRing.strokeEndAnimation(fromValue: 1, toValue: 0, duration: 15) }
    
    
    private func addPulseAnimation() {
        let center = view.center
        radius = view.frame.width / 3 - 20
        
        let pulse = PulseLayer(numberOfPulses: 10, radius: radius, position: center, backgroundColor: .pulsatingFillColor)
        pulse.animationDuration = 1.5
        pulse.backgroundColor = UIColor.pulsatingFillColor.cgColor
        
        view.layer.insertSublayer(pulse, below: trackRing)
    }
}

