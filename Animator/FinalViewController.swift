//
//  FinalViewController.swift
//  Animator
//
//  Created by Noah Labhart on 4/24/17.
//  Copyright © 2017 Touchtap. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var animatedSquare: UIView!
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collider : UICollisionBehavior!
    var dynamicBehavior : UIDynamicItemBehavior!
    var dynamicAnimatorNextAnimation : ((Void)->Void)?
    
    let sharedDuration = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity = UIGravityBehavior()
        gravity.magnitude = gravity.magnitude * 3
        
        collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        
        dynamicBehavior = UIDynamicItemBehavior()
        dynamicBehavior.elasticity = 0.25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 13 Total Animations
        
        self.animateFadeIn {
            self.animateSpin {
                self.animateHardDrop {
                    self.animateCenter {
                        self.animateDropAndSpringBounce {
                            self.animateCenter {
                                self.animateDropAndBounceLightly {
                                    self.animateCenter {}
                                    self.animateChangeColor(color: .red) {
                                        self.animateChangeColor(color: .blue) {
                                            self.animateChangeColor(color: .purple) {
                                                self.animateChangeColor(color: .lightGray) {}
                                                self.animateGrowAndShrink {}
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func animateFadeIn(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: sharedDuration,
                       animations: {
                        self.animatedSquare.alpha = 1.0
        }) { success in
            doNextAnimation()
        }
    }
    
    func animateSpin(doNextAnimation: @escaping (Void)->Void) {
        CATransaction.begin()
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 5.0)
        rotateAnimation.duration = sharedDuration / 1.5
        
        CATransaction.setCompletionBlock { 
            doNextAnimation()
        }
        
        animatedSquare.layer.add(rotateAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    func animateHardDrop(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: sharedDuration / 5,
                       animations: {
                        let asFrame = self.animatedSquare.frame
                        self.animatedSquare.frame = CGRect(x: asFrame.origin.x,
                                                           y: UIScreen.main.bounds.height - asFrame.size.height,
                                                           width: asFrame.size.width,
                                                           height: asFrame.size.height)
        }) { success in
            doNextAnimation()
        }
    }
    
    func animateCenter(doNextAnimation: @escaping (Void)->Void) {
        
        UIView.animate(withDuration: sharedDuration * 2,
                       delay: 0.25,
                       animations: {
                        self.animatedSquare.center = self.view.center
        }) { success in
            doNextAnimation()
        }
    }
    
    func animateDropAndSpringBounce(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: sharedDuration / 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 0.15,
                       initialSpringVelocity: 7,
                       options: UIViewAnimationOptions.curveLinear,
                       animations: {
                        let asFrame = self.animatedSquare.frame
                        self.animatedSquare.frame = CGRect(x: asFrame.origin.x,
                                                           y: UIScreen.main.bounds.height - asFrame.size.height,
                                                           width: asFrame.size.width,
                                                           height: asFrame.size.height)
        }) { success in
            doNextAnimation()
        }
    }
    
    func animateDropAndBounceLightly(doNextAnimation: @escaping (Void)->Void) {
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        animator.addBehavior(dynamicBehavior)
        animator.delegate = self
        
        collider.addItem(self.animatedSquare)
        gravity.addItem(self.animatedSquare)
        dynamicBehavior.addItem(self.animatedSquare)
        
        dynamicAnimatorNextAnimation = doNextAnimation
    }
    
    func animateChangeColor(color: UIColor, doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: sharedDuration / 4,
                       delay: 0.25,
                       animations: {
                        self.animatedSquare.backgroundColor = color
        }) { success in
            doNextAnimation()
        }
    }
    
    func animateGrowAndShrink(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: sharedDuration / 4,
                       delay: 0.15,
                       animations: {
                        self.animatedSquare.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.animatedSquare.center = self.view.center
        }) { success in
            UIView.animate(withDuration: self.sharedDuration / 4,
                           delay: 0.15,
                           animations: {
                            self.animatedSquare.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            self.animatedSquare.center = self.view.center
            }) { success in
                doNextAnimation()
            }
        }
    }
}

extension FinalViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        if let next = dynamicAnimatorNextAnimation {
            next()
            dynamicAnimatorNextAnimation = nil
        }
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}
