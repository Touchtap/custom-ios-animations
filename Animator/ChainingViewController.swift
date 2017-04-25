//
//  ChainingViewController.swift
//  Animator
//
//  Created by Noah Labhart on 4/24/17.
//  Copyright © 2017 Touchtap. All rights reserved.
//

import UIKit
import Cheetah

class ChainingViewController: UIViewController {

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
        self.title = "Chaining"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetForAnimations()
        executeAnimations()
    }
    
    func executeAnimations() {
        
        // 13 Total Animations
        
        let asFrame = self.animatedSquare.frame
        let yChangeToBottom = UIScreen.main.bounds.height - asFrame.size.height - asFrame.origin.y
        
        self.animatedSquare.cheetah
            .alpha(1.0).duration(sharedDuration)
            .wait(0.5)
            .rotate(Double.pi * 5.0).duration(sharedDuration / 1.5)
            .wait(0.01)
            .move(0, yChangeToBottom).duration(sharedDuration / 5)
            .wait(0.25)
            .move(0,-yChangeToBottom).duration(sharedDuration * 2)
            .wait(0.5)
            .move(0, yChangeToBottom).duration(sharedDuration / 5).spring().duration(sharedDuration / 1.5)
            .wait(0.25)
            .move(0,-yChangeToBottom).duration(sharedDuration * 2)
            .wait(0.25)
            .move(0, yChangeToBottom).duration(sharedDuration / 2).easeOutBounce
            .wait(0.25)
            .move(0,-yChangeToBottom).duration(sharedDuration * 2)
            .wait()
            .backgroundColor(.red).duration(sharedDuration / 4)
            .wait()
            .backgroundColor(.blue).duration(sharedDuration / 4)
            .wait()
            .backgroundColor(.purple).duration(sharedDuration / 4)
            .wait()
            .backgroundColor(.lightGray).duration(sharedDuration / 4)
            .wait()
            .delay(0.25).scaleXY(1.5, 1.5).duration(sharedDuration / 4)
            .wait()
            .delay(0.25).scaleXY(1.0, 1.0).duration(sharedDuration / 4)
            .run()
            .completion {
                self.toggleRefresh(show: true)
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
        self.animatedSquare.alpha = 0
        self.animatedSquare.center = self.view.center
    }
}
