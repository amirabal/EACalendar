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
import EventKit
import DateTimePicker

class ViewController: UIViewController, KCFloatingActionButtonDelegate, FSCalendarDelegate, FSCalendarDataSource, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, FSCalendarDelegateAppearance
{

    
  //  @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var calendar: FSCalendar!

    @IBOutlet weak var background: UIView!
    
    @IBAction func selectToday(_ sender: AnyObject?) {
        
        self.calendar.setCurrentPage(Date(), animated: true)
        
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
        
    }
    
    
 
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format
    }()

    private lazy var gesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    
    var addEvent = KCFloatingActionButton()
    
    
    var datesWithEvents = ["2017-04-11", "2017-04-14", "2017-04-30"]
    var events = [["Time": "10", "event": "Birthday"],["Time": "11:30", "event": "Date Night"]]

    
    
    override func viewDidAppear(_ animated: Bool) {
        layoutFAB()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model.hasPrefix("iPad"){
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.select(Date())
        self.view.addGestureRecognizer(self.gesture)
        self.tableView.panGestureRecognizer.require(toFail: self.gesture)
        self.calendar.scope = .month
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Set Calendar's Weekday Text Color
        calendar.appearance.weekdayTextColor = UIColor.white
        
        // Set Calendar's Header Title Color
        calendar.appearance.headerTitleColor = UIColor.white
        
        calendar.clipsToBounds = true
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        
        // Set Calendar's Today Selection Color
        calendar.appearance.todaySelectionColor = UIColor(red: 255/255, green: 138/255, blue: 101/255, alpha: 1)
        
        // Set Calendar's Today Color
        calendar.appearance.todayColor = UIColor(red: 255/255, green: 138/255, blue: 101/255, alpha: 1)
        
        // Set Calendar's Selection Color
        calendar.appearance.selectionColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1)
        
        // Set Calendar's Background Color
        calendar.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        
        // Set Calendar's Day Title Color
        calendar.appearance.titleDefaultColor = UIColor.white
        
        // Set background Header Color
        background.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        
       // Set Calendar's WeekDay View to Single Letter
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    deinit {
        print("\(#function)")
    }
    
    /*
    var eventsArray: [String] = []
    var datesWithEvent:[NSDate] = []
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        for data in eventsArray{
            let order = NSCalendar.currentCalendar.compareDate(data.eventDate!, toDate: date, toUnitGranularity: .day)
            if order == NSComparisonResult.OrderedSame{
                let unitFlags: NSCalendar.Unit = [ .day, .month, .year]
                let calendar2: NSCalendar = NSCalendar.current as NSCalendar
                let components: NSDateComponents = calendar2.components(unitFlags, fromDate: (data as AnyObject).eventDate!)
                datesWithEvent.append(calendar2.date(from: components as DateComponents)! as NSDate)
            }
        }
        return datesWithEvent.contains(date as NSDate)
    }
    **/
    
    func layoutFAB() {
        addEvent.removeFromSuperview()
        addEvent = KCFloatingActionButton()
        
        let item1 = KCFloatingActionButtonItem()
        item1.buttonColor = UIColor.yellow
        item1.circleShadowColor = UIColor.black
        item1.titleShadowColor = UIColor.black
        item1.title = "Add Event"
        item1.handler = {item in
            //call Function
            self.performSegue(withIdentifier: "AddEvent", sender:self)
            
        }
        
        addEvent.addItem(item: item1)
        addEvent.fabDelegate = self
        
        addEvent.sticky = true
        
        //print(tableView!.frame)
        
        addEvent.buttonColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        addEvent.plusColor = UIColor.white
        addEvent.openAnimationType = .slideLeft
        addEvent.tintColor = UIColor.white
        
        self.view.addSubview(addEvent)
        
    }
    
    /*
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.datesWithEvents.contains(dateString){
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString){
            return 3
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter.string(from: date)
        if self.datesWithMultipleEvents.contains(key){
            return [UIColor.purple, UIColor.blue, UIColor.white]
        }
        if self.datesWithEvents.contains(key){
            return [UIColor.white]
        }
        return nil
    }
    
    **/
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }
    
   
    
    /***********************************************************************************************/
    //UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let begin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if begin{
            let velocity = self.gesture.velocity(in: self.view)
            switch self.calendar.scope{
            case .month:
                return velocity.y < 0
                
            case .week:
                return velocity.y > 0
            }
        }
        return begin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("Selected Dates are \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous{
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    /***********************************************************************************************/
    //UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventTableViewCell
        let eventsObj = events[indexPath.row]
        
        cell.time.text = eventsObj["Time"]
        cell.event.text = eventsObj["event"]
        return cell
        
    }
    
    
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    **/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
 
   
    
    /***********************************************************************************************/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
  
   
   


}

