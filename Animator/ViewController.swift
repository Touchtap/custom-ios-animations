//
//  ViewController.swift
//  Animator
//
//  Created by Noah Labhart on 4/24/17.
//  Copyright © 2017 Touchtap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell")!
        
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15.0)
        cell.textLabel?.textColor = UIColor.white
        
        cell.detailTextLabel?.font = UIFont(name: "AvenirNext-Regular", size: 13.0)
        cell.detailTextLabel?.textColor = UIColor.lightGray
        
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        cell.selectedBackgroundView = view
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Workshop Animations"
            cell.detailTextLabel?.text = "This is where you do the work and learn."
            break
        case 1:
            cell.textLabel?.text = "Finished Product"
            cell.detailTextLabel?.text = "This is where you cheat... er, look for help."
            break
        case 2:
            cell.textLabel?.text = "Animation Chaining"
            cell.detailTextLabel?.text = "Same animations, less code (with Dance & Pop)."
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc : UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Workshop")
            break
        case 1:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Final")
            break
        case 2:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chaining")
            break
        default:
            break
        }
        
        if let viewController = vc {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

