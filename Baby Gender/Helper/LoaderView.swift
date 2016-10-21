import UIKit

class LoaderView: UIView {
    
    var startAngle:Double = 0
    var endAngle:Double = 0
    var percent:Double = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        startAngle = -M_PI_2
        endAngle = startAngle + (M_PI * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        startAngle = -M_PI_4
        endAngle = startAngle + (M_PI * 2)
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPath:UIBezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x:rect.size.width / 2, y:rect.size.height / 2),
                          radius: self.frame.size.width/2 - 10,
                          startAngle: CGFloat(startAngle),
                          endAngle: CGFloat((endAngle - startAngle) * Double(percent/100) + startAngle),
                          clockwise: true)
        bezierPath.lineWidth = 20
        UIColor.red.setStroke()
        bezierPath.stroke()
        
        
        
    }
}
    
//    - (void)drawRect:(CGRect)rect
//    {
//    // Display our percentage as a string
//    NSString* textContent = [NSString stringWithFormat:@"%d", self.percent];
//    
//    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
//    
//    // Create our arc, with the correct angles
//    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
//    radius:130
//    startAngle:startAngle
//    endAngle:(endAngle - startAngle) * (_percent / 100.0) + startAngle
//    clockwise:YES];
//    
//    // Set the display for the path, and stroke it
//    bezierPath.lineWidth = 20;
//    [[UIColor redColor] setStroke];
//    [bezierPath stroke];
//    
//    // Text Drawing
//    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 71/2.0, (rect.size.height / 2.0) - 45/2.0, 71, 45);
//    [[UIColor blackColor] setFill];
//    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 42.5] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
//    }
//
//}
