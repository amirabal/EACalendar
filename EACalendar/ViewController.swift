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

class ViewController: UIViewController, KCFloatingActionButtonDelegate, FSCalendarDelegate, FSCalendarDataSource, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate
{

    
  //  @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var calendar: FSCalendar!
    
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
    
   // let transition = CircularTransition()
    var addEvent = KCFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // addEventButton.layer.cornerRadius = addEventButton.frame.size.width / 2
        layoutFAB()
        if UIDevice.current.model.hasPrefix("iPad"){
            self.calendarHeightContraint.constant = 400
        }
        self.calendar.select(Date())
        self.view.addGestureRecognizer(self.gesture)
        self.tableView.panGestureRecognizer.require(toFail: self.gesture)
        self.calendar.scope = .month
        calendar.appearance.headerDateFormat = "MMMM yy"
        calendar.appearance.weekdayTextColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 0.65)
        calendar.appearance.headerTitleColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 0.65)
        calendar.clipsToBounds = true
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendar.appearance.todaySelectionColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 0.65)
        calendar.appearance.todayColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 0.60)
        calendar.appearance.selectionColor = UIColor(red: 255/255, green: 61/255, blue: 0/255, alpha: 0.65)
    }
    deinit {
        print("\(#function)")
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
        self.calendarHeightContraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Did select date \(self.dateFormatter.string(from: date))")
        let selectedDate = calendar.selectedDate.map({self.dateFormatter.string(from: $0)})
        print("Selected Dates are \(selectedDate)")
        if monthPosition == .next || monthPosition == .previous{
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    /***********************************************************************************************/
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            let scope: FSCalendarScope = (indexPath.row == 0) ? .month : .week
            self.calendar.setScope(scope, animated: true)
        }
    }
    
    
    
    
    
    
    
    /***********************************************************************************************/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func layoutFAB() {
        addEvent.addItem(title: "Add Event")
        
        addEvent.fabDelegate = self
        
        addEvent.sticky = true
        
        print(tableView!.frame)
        
        addEvent.buttonColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1)
        addEvent.plusColor = UIColor.white
        //addEvent.overlayColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1)
        addEvent.openAnimationType = .slideLeft
        addEvent.tintColor = UIColor.white
        
        
        
        self.view.addSubview(addEvent)
        
    }
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
    /************************************************************************************************************************
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
    
    
    ************************************************************************************************************************/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
  
   
   


}

