//
//  AddViewController.swift
//  EACalendar
//
//  Created by Alex Mirabal on 4/3/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import EventKit

class AddViewController: UIViewController {

    @IBAction func done(_sender: UIButton){
        self.performSegue(withIdentifier: "unwindToCalendar", sender: self)
    }
    
    /**
     let min = Date()
     let picker = DateTimePicker.show(minimumDate: min)
     picker.highlightColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
     picker.doneButtonTitle = " DONE "
     picker.todayButtonTitle = "Today"
     picker.is12HourFormat = true
     picker.dateFormat = "hh:mm aa MM/dd/YYYY"
     picker.isDatePickerOnly = false
     picker.completionHandler = { date in
     let formatter = DateFormatter()
     formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
     self.calendar.select(date, scrollToDate: true)
     }
     **/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
