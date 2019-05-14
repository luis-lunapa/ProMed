//
//  ProfessionalAgendaViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/23/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit
import EventKit

class CitaTableViewCell: UITableViewCell {

    let backGroundColors = [
        UIColor(red:0.36, green:0.64, blue:0.68, alpha:1.0),
        UIColor(red:0.36, green:0.62, blue:0.29, alpha:1.0),
        UIColor(red:0.28, green:0.49, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.49, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.39, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.39, blue:0.51, alpha:1.0),
        UIColor(red:0.65, green:0.02, blue:0.25, alpha:1.0),
        UIColor(red:0.65, green:0.59, blue:0.04, alpha:1.0),
        UIColor(red:0.78, green:0.45, blue:0.04, alpha:1.0)
    ]

    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.backgroundColor = self.backGroundColors.randomElement()!
        self.backView.layer.cornerRadius = 8
    }

}

class ProAgendaViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Class members
    
//
//    /var citas = ["Monica Perez",
//                 "Tommy Luna",
//                 "Ricardo Luna",
//                 "Junior Luna",
//                 "Melanie Luna",
//                 "Daisy Luna",
//                 "Judy Luna",
//                 "Muñeca Luna"]
    
    var citas = [Appointment]()
    
    var dias = [Date]()
    
    var calendar: EKCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleBars()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setUpDates()
       
        //citas.append(Patient(name: "Muñeca Luna", birthDate: "16/06/2013"))
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getAppointments()
    }

    // MARK: IBActions

    @IBAction func addAppointmentPressed(_ sender: Any) {
    }

    


    // MARK: Common Setup

    /**
     This function sets the navigation bar and the tab bar to
     translucent
     
     - Author: Luis Gerardo Luna
     - Copyright: © Luis Luna
     
     */

    func styleBars() {
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setUpDates() {
        
        let days = 6 // Numero de dias a agregar
        
        let calendar = Calendar.current
        let today = Date()
        
        
        var sumaDias = 0
        
        for _ in 0...days {
            let newDate = calendar.date(byAdding: Calendar.Component.day, value: sumaDias, to: today)
        
            
            self.dias.append(newDate!)
            
            sumaDias += 1
            
        }

        
    }
    
    func getAppointments() {
        
        APIManager.shared.networking.getAppointments().done {
            appointments in
            
            self.citas = appointments
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            
        }
        
    }
    
    
    // MARK: - General class functions
    
   

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension ProAgendaViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fechaSection = self.dias[section]
        /// Get componets year, month and day
        
        let sectionDate = Calendar.current.dateComponents([.year, .month, .day], from: fechaSection)
        
        return self.getAppointmentsNumber(in: sectionDate)
        

    }
    
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! CitaTableViewCell
        print("Fecha cita = \(self.citas[indexPath.row].date)")
        print("Cita = \(self.citas[indexPath.row].nombrePaciente)")
        cell.nameLabel.text = self.citas[indexPath.row].nombrePaciente
        cell.dateLabel.text = APIManager.shared.dateFormatHMS().string(from: self.citas[indexPath.row].date ?? Date())
        cell.typeLabel.text = self.citas[indexPath.row].nssPaciente
        
        
        
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dias.count
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let cal = Calendar.current
        
        var titulo = ""
        
        if cal.isDateInToday(self.dias[section]) {
            titulo = "Hoy"
            
        } else if cal.isDateInTomorrow(self.dias[section]) {
            
            titulo = "Mañana"
            
        } else {
            
            titulo = self.getNameOfWeekDay(day: cal.component(Calendar.Component.weekday, from: self.dias[section]))
            
            
        }
        return titulo
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = UIColor.white
        let dayLabel = UILabel(frame: CGRect(x: 15, y: 0, width: view.bounds.width, height: CGFloat(50)))
        
        dayLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        
        dayLabel.text = self.getDayOfWeek(date: self.dias[section], section: section)
        
        let dateLabel = UILabel(frame: CGRect(x: 15, y: 30, width: view.bounds.width, height: CGFloat(50)))
        
        dateLabel.text = APIManager.shared.dateFormatDiaMesAnio().string(from: self.dias[section])
        
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        
        
       
        headerView.addSubview(dayLabel)
        headerView.addSubview(dateLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    // MARK: TableView Delegate
    
    
    
    // MARK: Helper functions for table
    
    func getNameOfWeekDay(day: Int) -> String {
        
        switch day {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thrusday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Later"
        }
        
    }
    
    func getDayOfWeek(date: Date, section: Int) -> String {
        let cal = Calendar.current
        
        if cal.isDateInToday(self.dias[section]) {
            return "Today"
            
        } else if cal.isDateInTomorrow(self.dias[section]) {
            
            return "Tomorrow"
            
        } else {
            
            return self.getNameOfWeekDay(day: cal.component(Calendar.Component.weekday, from: self.dias[section]))
            
            
        }
        
        
    }
    
    func getAppointmentsNumber(in components: DateComponents) -> Int {
        var count = 0
        for app in self.citas {
            
            let comp = Calendar.current.dateComponents([.year,.month,.day], from: app.date!)
            
            if components == comp {
                count += 1
            }
            
            
        }
        
        
       return count
    }
    
    
    
    
    
}
