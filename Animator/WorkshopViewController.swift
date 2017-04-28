//
//  WorkshopViewController.swift
//  Animator
//
//  Created by Noah Labhart on 4/24/17.
//  Copyright © 2017 Touchtap. All rights reserved.
//

import UIKit

class WorkshopViewController: UIViewController {
    
    @IBOutlet weak var animatedSquare: UIView!
    @IBOutlet weak var animatedImage: UIImageView!
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collider : UICollisionBehavior!
    var dynamicBehavior : UIDynamicItemBehavior!
    var dynamicAnimatorNextAnimation : ((Void)->Void)?
    
    let sharedDuration = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "Workshop"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetForAnimations()
        executeAnimations()
    }
    
    func executeAnimations() {
        // 13 Total Animations
        
        self.animateImage()
        
        self.animateFadeIn {
            self.animateSpin {
                self.animateHardDrop {
                    self.animateCenter {
                        self.animateDropAndSpringBounce {
                            self.animateCenter {
                                self.animateDropAndBounceLightly {
                                    self.animateCenter {
                                        self.animateChangeColor(color: .red) {
                                            self.animateChangeColor(color: .blue) {
                                                self.animateChangeColor(color: .purple) {
                                                    self.animateChangeColor(color: .lightGray) {}
                                                    self.animateGrowAndShrink {
                                                        self.toggleRefresh(show: true)
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
        }
    }
    
    func animateImage() {
        
        let orig = self.animatedImage.frame
        
        UIView.animate(withDuration: 2.0,
                       animations: { 
                        
                        self.animatedImage.frame =
                        CGRect(x: 0, y: UIScreen.main.bounds.height - self.animatedImage.frame.size.height, width: self.animatedImage.frame.size.width, height: self.animatedImage.frame.size.height)
                        
        }) { (success) in
            
            UIView.animate(withDuration: 0.5,
                           animations: { 
                            
                            self.animatedImage.frame = orig
            },
                           completion: { (success) in
                            
            })
            
        }
    }
    
    func animateFadeIn(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: 0.5, animations: { 
            self.animatedSquare.alpha = 1.0
        }) { (success) in
            doNextAnimation()
        }
    }
    
    func animateSpin(doNextAnimation: @escaping (Void)->Void) {
        CATransaction.begin()
        
        let spin = CABasicAnimation(keyPath: "transform.rotation")
        spin.duration = 1.0
        spin.toValue = Double.pi * 5.0
        spin.fromValue = 0
        
        CATransaction.setCompletionBlock { 
            doNextAnimation()
        }
        
        self.animatedSquare.layer.add(spin, forKey: nil)
        
        CATransaction.commit()
    }
    
    func animateHardDrop(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: 0.15,
                       delay: 0.25,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { 
                        
                        let asFrame = self.animatedSquare.frame
                        self.animatedSquare.frame = CGRect(x: asFrame.origin.x,
                                                           y: UIScreen.main.bounds.height - asFrame.size.height,
                                                           width: asFrame.size.width,
                                                           height: asFrame.size.height)
                        
                        
        }) { (success) in
            doNextAnimation()
        }
    }
    
    func animateCenter(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.25,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { 
                        
                        self.animatedSquare.center = self.view.center
                        
        }) { (success) in
            doNextAnimation()
        }
    }
    
    func animateDropAndSpringBounce(doNextAnimation: @escaping (Void)->Void) {
        UIView.animate(withDuration: 0.15,
                       delay: 0.25,
                       usingSpringWithDamping: 0.15,
                       initialSpringVelocity: 7,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { 
                        
                        let asFrame = self.animatedSquare.frame
                        self.animatedSquare.frame = CGRect(x: asFrame.origin.x,
                                                           y: UIScreen.main.bounds.height - asFrame.size.height,
                                                           width: asFrame.size.width,
                                                           height: asFrame.size.height)
                        
        }) { (success) in
            doNextAnimation()
        }
    }
    
    func animateDropAndBounceLightly(doNextAnimation: @escaping (Void)->Void) {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity = UIGravityBehavior()
        gravity.magnitude = gravity.magnitude * 3
        
        collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        
        dynamicBehavior = UIDynamicItemBehavior()
        dynamicBehavior.elasticity = 0.25
        
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
        UIView.animate(withDuration: 0.25,
                       animations: { 
                        
                        self.animatedSquare.backgroundColor = color
                        
        }) { (success) in
            doNextAnimation()
        }
    }
    
    func animateGrowAndShrink(doNextAnimation: @escaping (Void)->Void) {

        UIView.animate(withDuration: 0.5,
                       delay: 0.15,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { 
                        
                        self.animatedSquare.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.animatedSquare.center = self.view.center
                        
        }) { (success) in
            UIView.animate(withDuration: 0.5,
                           delay: 0.15,
                           options: UIViewAnimationOptions.curveEaseInOut,
                           animations: { 
                            
                            self.animatedSquare.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            self.animatedSquare.center = self.view.center
                            
            },
                           completion: { (success) in
                            doNextAnimation()
            })
        }
    }
    
    // Utility Functions
    
    func toggleRefresh(show: Bool = true) {
        if show {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ChainingViewController.refresh))
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func refresh() {
        toggleRefresh(show: false)
        
        resetForAnimations()
        executeAnimations()
    }
    
    func resetForAnimations() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity = UIGravityBehavior()
        gravity.magnitude = gravity.magnitude * 3
        
        collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        
        dynamicBehavior = UIDynamicItemBehavior()
        dynamicBehavior.elasticity = 0.25
        
        self.animatedSquare.alpha = 0
        self.animatedSquare.center = self.view.center
    }

}

extension WorkshopViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        if let doNext = dynamicAnimatorNextAnimation {
            doNext()
        }
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}

