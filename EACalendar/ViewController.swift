//
//  ViewController.swift
//  EACalendar
//
//  Created by Alex Mirabal on 3/27/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import FSCalendar
import KCFloatingActionButton

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, KCFloatingActionButtonDelegate
{

    
  //  @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
   // let transition = CircularTransition()
    var fab = KCFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // addEventButton.layer.cornerRadius = addEventButton.frame.size.width / 2
       layoutFAB()
       fab.buttonColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func layoutFAB() {
        fab.addItem("Add Event", icon: UIImage(named: "icmap")) { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fab.fabDelegate = self
        
        fab.sticky = true
        
        print(tableView!.frame)
        
        self.view.addSubview(fab)
        
    }
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        return cell
    }

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = addEventButton.center
        transition.circleColor = addEventButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = addEventButton.center
        transition.circleColor = addEventButton.backgroundColor!
        
        return transition
    }
    
    
    **/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    /***********************************************************************************************/
    //UITableView DataSource
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2,20][section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = ["cell_month", "cell_week"][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            return cell
        }
        
    }
 
    
    
    //UITableView Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    **/
    /***********************************************************************************************/
   
   


}

