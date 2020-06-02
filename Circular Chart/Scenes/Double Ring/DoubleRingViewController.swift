import UIKit

class DoubleRingViewController: UIViewController {

    // MARK: Properties
    let outerLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addCircularBar()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    private func configureViewController() { view.backgroundColor = .backgroundColor }
    
    
    private func addCircularBar() {
        
        let center = view.center
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 3 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
        outerLayer.path = circularPath.cgPath
        outerLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.lineWidth = 15
        view.layer.addSublayer(outerLayer)
    }

}
