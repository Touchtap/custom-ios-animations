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
}

extension WorkshopViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}

