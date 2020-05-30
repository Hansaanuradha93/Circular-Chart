import UIKit

class ViewController: UIViewController {

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addCircularBar()
    }
    
    
    private func configureViewController() { view.backgroundColor = .backgroundColor }
    
    
    private func addCircularBar() {
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
    
    
    @objc func handleTap() {
        
        let center = view.center
        let radius = view.frame.width / 3 - 20
        let pulse = PulseLayer(numberOfPulses: 10, radius: radius, position: center)
        pulse.animationDuration = 1.5
        pulse.backgroundColor = UIColor.systemPink.cgColor
        
        trackLayer.insertSublayer(pulse, below: trackLayer)
        addStrokeEndAnimation()
    }
}

