//
//  AddViewController.swift
//  EACalendar
//
//  Created by Alex Mirabal on 4/3/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import EventKit
import FSCalendar
import DateTimePicker

class AddViewController: UIViewController {
    
    var savedEventID = String()
    var calendar: EKCalendar!
    
    @IBOutlet weak var eventName: UITextField!
    @IBAction func dismissKeyboard(_ sender: AnyObject?) {
        self.resignFirstResponder()
    }
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBAction func canceButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToCalendar", sender: self)
    }
    @IBAction func save(_ sender: UIButton) {
        
      //  self.performSegue(withIdentifier: "unwindToCalendar", sender: self)
        
        
        //MARK-> Add Events With EventKit 
        /**********************************************************************************************/
        /**********************************************************************************************/
        
        //Add Events
        // Create an Event Store instance
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
            let event = EKEvent(eventStore: eventStore)
            event.title = self.eventName.text ?? "Event Title"
            event.startDate = self.startDate.date //today
            event.endDate = self.endDate.date
            event.calendar = eventStore.defaultCalendarForNewEvents
            event.addAlarm(EKAlarm.init(relativeOffset: 60.0))
        
        //                let alarmDate:NSDate = NSDate()
        //                print("Alarm Date: \(alarmDate)")
        //                event.addAlarm(EKAlarm.init(absoluteDate: alarmDate))
            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
                self.savedEventID = event.eventIdentifier //save event id to access this particular event later
                self.performSegue(withIdentifier: "unwindToCalendar", sender: self)

            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startDate.setDate(initialDatePickerValue(), animated: false)
        self.endDate.setDate(initialDatePickerValue(), animated: false)
        
        
    }
    
    /**********************************************************************************************/
    /**********************************************************************************************/
    
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    
    
    
    
    
    
    
    

}
