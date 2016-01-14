//
//  ViewController.swift
//  MFFDynamics
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate
{
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior?
    var snap: UISnapBehavior?
    var square: UIView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        square = UIView(frame: CGRect(x: 150, y: 70, width: 100, height: 100))
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
        
        // Collisions
        let collision = UICollisionBehavior(items: [square])
        collision.collisionDelegate = self
        // Add a boundaries that has the same frame as barriers
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        collision.addBoundaryWithIdentifier("circle", forPath: UIBezierPath(roundedRect: circle.frame, cornerRadius: circle.layer.cornerRadius))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        // Physical properties
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        // Bouncines. Usually between 0 (inelastic) and 1 (collide elastically)
        itemBehaviour.elasticity = 0.6
        // Sliding ressistance. 0 being no friction between objects slide along each other
        itemBehaviour.friction = 0.5
        animator.addBehavior(itemBehaviour)
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint)
    {
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.redColor()
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = UIColor.greenColor()
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        // Add gravity after first touch
        if gravity == nil {
            gravity = UIGravityBehavior(items: [square])
            animator.addBehavior(gravity!)
        } else {
            // On every next touch...
            if snap != nil {
                // Unsnap object (gravity is applied again)
                animator.removeBehavior(snap!)
                snap = nil
            } else {
                // Snap object to touch location. That "overrides" gravity.
                if let touch = touches.first {
                    snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
                    animator.addBehavior(snap!)
                }
            }
        }
    }
}

