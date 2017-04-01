//
//  SecondViewController.swift
//  EACalendar
//
//  Created by Alex Mirabal on 3/30/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    
    
    @IBOutlet weak var cancelEvent: UIButton!
    
   
    @IBOutlet weak var addEventView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cancelEvent.layer.cornerRadius = cancelEvent.frame.size.width / 2
        
        addEventView.layer.cornerRadius = 5
    }
    /*
    
    func animatedIn(){
        self.view.addSubview(addEventView)
        addEventView.center = self.view.center
        
        addEventView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addEventView.alpha = 0
    
        UIView.animate(withDuration: 0.4){
            self.addEventView.alpha = 1
            self.addEventView.transform = CGAffineTransform.identity
            
        }
    }
 **/
 
 
 
    @IBAction func donePopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissSecondVC(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
