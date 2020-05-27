import UIKit

class ViewController: UIViewController {

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCircularBar()
    }
    
    
    private func addCircularBar() {
        let center = view.center
         
         
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width / 2 - 20, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
         
         let trackLayer = CAShapeLayer()
         trackLayer.path = circularPath.cgPath
         trackLayer.strokeColor = UIColor.lightGray.cgColor
         trackLayer.fillColor = UIColor.clear.cgColor
         trackLayer.lineWidth = 10
         view.layer.addSublayer(trackLayer)
         
        
         shapeLayer.path = circularPath.cgPath
         shapeLayer.strokeColor = UIColor.red.cgColor
         shapeLayer.fillColor = UIColor.clear.cgColor
         shapeLayer.lineCap = CAShapeLayerLineCap.round
         shapeLayer.lineWidth = 10
         shapeLayer.strokeEnd = 1

         view.layer.addSublayer(shapeLayer)

         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = 10
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        shapeLayer.add(basicAnimation, forKey: "circularWheel")
    }


}

