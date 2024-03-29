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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - Methods
private extension DoubleRingViewController {
    
    @objc func handleTap() {
        addStrokeEndAnimation()
    }

    
    func configureViewController() {
        view.backgroundColor = .backgroundColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    func addRings() {
        let outerRingRadius: CGFloat = view.frame.width / 3 - 20
        let innerRingRadius: CGFloat = view.frame.width / 3 - 20 - 15
        
        outerRing = addRing(radius: outerRingRadius, strokeColor: .trackStrokeColor, fillColor: .clear)
        innerRing = addRing(radius: innerRingRadius, strokeColor: .outlineStrokeColor, fillColor: .backgroundColor)
        
        view.layer.addSublayer(outerRing)
        view.layer.addSublayer(innerRing)
    }

    
    func addStrokeEndAnimation() { innerRing.strokeEndAnimation(fromValue: 1, toValue: 0, duration: 15)
    }
}
