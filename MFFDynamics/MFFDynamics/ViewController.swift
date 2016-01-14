//
//  ViewController.swift
//  MFFDynamics
//

import UIKit

class ViewController: UIViewController
{
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let square = UIView(frame: CGRect(x: 150, y: 70, width: 100, height: 100))
        square.backgroundColor = UIColor.greenColor()
        view.addSubview(square)
        
        let barrier = UIView(frame: CGRect(x: 0, y: 400, width: 130, height: 20))
        barrier.backgroundColor = UIColor.grayColor()
        view.addSubview(barrier)
        
        let circle = UIView(frame: CGRect(x: 200, y: 200, width: 80, height: 80))
        circle.backgroundColor = UIColor.grayColor()
        circle.layer.cornerRadius = circle.frame.size.width / 2
        view.addSubview(circle)
        
        
        // According to a given set of rules, the animator adjusts the location of each object each time the screen is redrawn.
        animator = UIDynamicAnimator(referenceView: view)
        
        // Gravity
        let gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
    }
    
}

