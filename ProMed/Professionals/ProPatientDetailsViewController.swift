//
//  ProPatientDetailsViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/24/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class ProPatientDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var generalInfoView: UIView!
    @IBOutlet weak var addRecordView: UIView!
    @IBOutlet weak var checkRecordView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var emergencyView: UIView!
    @IBOutlet weak var shareView: UIView!
    
    @IBOutlet weak var backButtonView: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()

        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
      
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.34, green:0.27, blue:0.50, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        
        self.backButtonView.layer.shadowColor = UIColor.black.cgColor
        self.backButtonView.layer.shadowOpacity = 1
        self.backButtonView.layer.shadowRadius = 10
        
        generalInfoView.backgroundColor = .white
        generalInfoView.layer.shadowColor = UIColor.darkGray.cgColor
        self.generalInfoView.layer.shadowOpacity = 1
        self.generalInfoView.layer.shadowRadius = 10
        self.generalInfoView.layer.cornerRadius = 10
        
        addRecordView.backgroundColor = .white
        addRecordView.layer.shadowColor = UIColor.darkGray.cgColor
        self.addRecordView.layer.shadowOpacity = 1
        self.addRecordView.layer.shadowRadius = 10
        self.addRecordView.layer.cornerRadius = 10
        
        checkRecordView.backgroundColor = .white
        checkRecordView.layer.shadowColor = UIColor.darkGray.cgColor
        self.checkRecordView.layer.shadowOpacity = 1
        self.checkRecordView.layer.shadowRadius = 10
        self.checkRecordView.layer.cornerRadius = 10
        
        scheduleView.backgroundColor = .white
        scheduleView.layer.shadowColor = UIColor.darkGray.cgColor
        self.scheduleView.layer.shadowOpacity = 1
        self.scheduleView.layer.shadowRadius = 10
        self.scheduleView.layer.cornerRadius = 10
        
        emergencyView.backgroundColor = .white
        emergencyView.layer.shadowColor = UIColor.darkGray.cgColor
        self.emergencyView.layer.shadowOpacity = 1
        self.emergencyView.layer.shadowRadius = 10
        self.emergencyView.layer.cornerRadius = 10
        
        shareView.backgroundColor = .white
        shareView.layer.shadowColor = UIColor.darkGray.cgColor
        self.shareView.layer.shadowOpacity = 1
        self.shareView.layer.shadowRadius = 10
        self.shareView.layer.cornerRadius = 10
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
