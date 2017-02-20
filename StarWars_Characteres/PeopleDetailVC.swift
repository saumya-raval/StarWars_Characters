//
//  PeopleDetailVC.swift
//  StarWars_Characteres
//
//  Created by Saumya Raval on 2/20/17.
//  Copyright © 2017 PlayAgain. All rights reserved.
//

import UIKit

class PeopleDetailVC: UIViewController {
    
    var people: People!
    
    @IBOutlet weak var testNameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var hariColorLbl: UILabel!
    @IBOutlet weak var skinColorLbl: UILabel!
    
    @IBOutlet weak var birthYearLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testNameLbl.text = people.name
        mainImg.layer.cornerRadius = 5.0
        mainImg.clipsToBounds = true
        
        people.downloadPeopleDetails { () -> () in
            
            self.updateUI()
            
        }

    }
    
    func updateUI() {
        descLbl.text = people.desc
        heightLbl.text = people.height
        weightLbl.text = people.weight
        hariColorLbl.text = people.hairColor.capitalized
        skinColorLbl.text = people.skinColor.capitalized
        birthYearLbl.text = people.birthYear
        genderLbl.text = people.gender.capitalized
        
        let i = people.nameID + 0
        mainImg.image = UIImage(named: "\(i)")
        
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

}
