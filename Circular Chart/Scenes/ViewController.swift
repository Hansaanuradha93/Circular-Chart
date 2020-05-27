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
         shapeLayer.fillColor = UIColor.white.cgColor
         shapeLayer.lineCap = CAShapeLayerLineCap.round
         shapeLayer.lineWidth = 10
         shapeLayer.strokeEnd = 1

         view.layer.addSublayer(shapeLayer)

         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        let center = view.center

        let radius = view.frame.width / 2 + 10
        let pulse = PulseLayer(numberOfPulses: 1, radius: radius, position: center)
        pulse.animationDuration = 0.5
        pulse.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(pulse, below: shapeLayer)
    }


}

