import UIKit

class StrokeLayer: CALayer {
    
    var center: CGPoint!
    var radius: CGFloat!
    var strokeColor: UIColor!
    
    override init(layer: Any) { super.init(layer: layer) }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    init(center: CGPoint, radius: CGFloat, strokeColor: UIColor) {
        super.init()
        
        self.center = center
        self.radius = radius
        self.strokeColor = strokeColor
    }
}
