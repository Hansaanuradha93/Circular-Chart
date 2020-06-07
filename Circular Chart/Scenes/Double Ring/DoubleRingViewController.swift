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
        
        innerRing = addRing(radius: view.frame.width / 3 - 20 - 15, strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.backgroundColor)
        outerRing = addRing(radius: view.frame.width / 3 - 20, strokeColor: UIColor.trackStrokeColor, fillColor: UIColor.clear)
        view.layer.addSublayer(outerRing)
        view.layer.addSublayer(innerRing)
    }

    
    private func addStrokeEndAnimation() { innerRing.strokeEndAnimation(fromValue: 1, toValue: 0, duration: 15) }
}
