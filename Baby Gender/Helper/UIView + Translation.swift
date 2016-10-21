import Foundation
import UIKit

extension UIView{
    static func translateView(view:UIView, bundle:Bundle) {
        if let idView:UILabel = view as? UILabel {
           idView.text = NSLocalizedString(idView.text!, comment: "")
        }else if let idView:UIButton = view as? UIButton{

            idView.setTitle(NSLocalizedString((idView.title(for: UIControlState.normal))!, comment: ""), for: UIControlState.normal)
            idView.titleLabel?.textAlignment = NSTextAlignment.center
        }
        for localeView in view.subviews{
            UIView .translateView(view: localeView, bundle: bundle)
        }
//        if (idView.responds(to: Selector("text") && view.responds(to: "setText:")){
//           UIViewew setText: NSLocalizedString([idView text], nil)];
//            }
//        if ([idView respondsToSelector:@selector(title)] && [view respondsToSelector:@selector(setTitle:)])
//        [idView setTitle:NSLocalizedString([idView title], nil)];
//        if ([idView respondsToSelector:@selector(placeholder)] && [view respondsToSelector:@selector(setPlaceholder:)])
//        [idView setPlaceholder:NSLocalizedString([idView placeholder],nil)];
//        if ([idView respondsToSelector:@selector(prompt)] && [view respondsToSelector:@selector(setPrompt:)])
//        [idView setPrompt:NSLocalizedString([idView prompt],nil)];
//        if ([idView respondsToSelector:@selector(titleForState:)] && [view respondsToSelector:@selector(setTitle:forState:)])
//        [idView setTitle:NSLocalizedString([idView titleForState:UIControlStateNormal],nil) forState:UIControlStateNormal];
//        if ([idView isKindOfClass:[UITabBar class]] || [idView isKindOfClass:[UIToolbar class]])
//        for (UIBarItem *item in [idView items])
//            [item setTitle:NSLocalizedString([item title],nil)];
//        for (UIView *subview in [view subviews])
//            [UIView translateView:subview bundle:bundle];
    }

}
