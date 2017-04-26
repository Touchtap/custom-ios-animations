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
    
    func animateFadeIn(doNextAnimation: @escaping (Void)->Void) {
        
    }
    
    func animateSpin(doNextAnimation: @escaping (Void)->Void) {
        
    }
    
    func animateHardDrop(doNextAnimation: @escaping (Void)->Void) {
        
    }
    
    func animateCenter(doNextAnimation: @escaping (Void)->Void) {
        
    }
    
    func animateDropAndSpringBounce(doNextAnimation: @escaping (Void)->Void) {

    }
    
    func animateDropAndBounceLightly(doNextAnimation: @escaping (Void)->Void) {

    }
    
    func animateChangeColor(color: UIColor, doNextAnimation: @escaping (Void)->Void) {

    }
    
    func animateGrowAndShrink(doNextAnimation: @escaping (Void)->Void) {

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
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}

