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
        let outerRingRadius: CGFloat = view.frame.width / 3 - 20
        let fillerRingRadius: CGFloat = outerRingRadius - gap / 2
        let innerRingRadius: CGFloat = outerRingRadius - gap
        
        outerRing = addRing(radius: outerRingRadius, strokeColor: .outlineStrokeColor, fillColor: .clear, lineWidth: 5)
        fillerRing = addRing(radius: fillerRingRadius, strokeColor: .outlineStrokeColor, fillColor: .backgroundColor, lineWidth: gap, strokeEnd: 0)
        innerRing = addRing(radius: innerRingRadius, strokeColor: .outlineStrokeColor, fillColor: .backgroundColor, lineWidth: 5)
        
        view.layer.addSublayer(outerRing)
        view.layer.addSublayer(fillerRing)
        view.layer.addSublayer(innerRing)
    }
    
    
    private func addStrokeEndAnimation() { fillerRing.strokeEndAnimation(fromValue: 0, toValue: 1, duration: 15) }
}
