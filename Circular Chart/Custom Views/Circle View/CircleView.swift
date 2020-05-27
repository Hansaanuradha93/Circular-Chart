import UIKit

class CircleView: UIView {

    weak var circleView: UIView?
    lazy var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        let rectSide = (frame.size.width > frame.size.height) ? frame.size.height : frame.size.width
        let circleRect = CGRect(x: (frame.size.width-rectSide)/2, y: (frame.size.height-rectSide)/2, width: rectSide, height: rectSide)
        let circleView = UIView(frame: circleRect)
        circleView.backgroundColor = UIColor.yellow
        circleView.layer.cornerRadius = rectSide/2
        circleView.layer.borderWidth = 2.0
        circleView.layer.borderColor = UIColor.red.cgColor
        addSubview(circleView)
        self.circleView = circleView
    }
    
    func resizeCircle (summand: CGFloat) {
        
        guard let circleView = circleView else { return }
        frame.origin.x -= summand/2
        frame.origin.y -= summand/2
        frame.size.height += summand
        frame.size.width += summand
        
        circleView.frame.size.height += summand
        circleView.frame.size.width += summand
    }
    
    func animateChangingCornerRadius (toValue: Any?, duration: TimeInterval) {
        guard let circleView = circleView else { return }
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fromValue = circleView.layer.cornerRadius
        animation.toValue =  toValue
        animation.duration = duration
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.layer.add(animation, forKey:"cornerRadius")
    }
    
    
    private func circlePulseAinmation(_ summand: CGFloat, duration: TimeInterval, completionBlock:@escaping ()->()) {
        
        guard let circleView = circleView else { return }
        UIView.animate(withDuration: duration, delay: 0,  options: .curveEaseInOut, animations: { [weak self] in
            self?.resizeCircle(summand: summand)
        }) { _ in completionBlock() }
        
        animateChangingCornerRadius(toValue: circleView.frame.size.width/2, duration: duration)
    }
    
    func resizeCircleWithPulseAinmation(_ summand: CGFloat,  duration: TimeInterval) {
        if (!isAnimating) {
            isAnimating = true
            circlePulseAinmation(summand, duration:duration) { [weak self] in
                guard let self = self else { return }
                self.circlePulseAinmation((-1)*summand, duration:duration) {self.isAnimating = false}
            }
        }
    }

}
