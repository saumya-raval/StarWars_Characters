//
//  PeopleCell.swift
//  StarWars_Characteres
//
//  Created by Saumya Raval on 2/20/17.
//  Copyright © 2017 PlayAgain. All rights reserved.
//

import UIKit

class PeopleCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabl: UILabel!
        
    var people: People!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configCell (_ people: People) {
        self.people = people
        //print(self.people.nameID)
        //print(people.nameID)
        let i = self.people.nameID!
        nameLabl.text = self.people.name
        thumbImg.image = UIImage(named: "\(i)")
        
    }
    
}
