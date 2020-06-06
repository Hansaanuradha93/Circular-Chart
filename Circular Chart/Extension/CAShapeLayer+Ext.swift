import UIKit

extension CAShapeLayer {
    
    func strokeEndAnimation(fromValue: CGFloat, toValue: CGFloat, duration: CFTimeInterval) {
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 1
        strokeAnimation.toValue = 0
        strokeAnimation.duration = 15
        
        strokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeAnimation.isRemovedOnCompletion = false
        
        self.add(strokeAnimation, forKey: "strokeEnd")
    }
}
