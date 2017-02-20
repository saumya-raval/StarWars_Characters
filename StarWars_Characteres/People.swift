//
//  People.swift
//  StarWars_Characteres
//
//  Created by Saumya Raval on 2/18/17.
//  Copyright © 2017 PlayAgain. All rights reserved.
//

import Foundation
import Alamofire

class People {
    
    fileprivate var _name: String!
    fileprivate var _nameID: Int!
    
    private var _desc: String!
    private var _height: String!
    private var _weight:String!
    private var _hairColor: String!
    private var _skinColor: String!
    private var _birthYear: String!
    private var _gender: String!
    private var _peopleURL: String!
    
    var name: String! {
        return _name
    }
    
    var nameID: Int! {
        return _nameID
    }
    
    var peopleURL: String! {
        return _peopleURL
    }
    
    var desc: String! {
        return _desc
    }
    
    var height: String! {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String! {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var hairColor: String! {
        if _hairColor == nil {
            _hairColor = ""
        }
        return _hairColor
    }
    
    var skinColor: String! {
        if _skinColor == nil {
            _skinColor = ""
        }
        return _skinColor
    }
    
    var gender: String! {
        if _gender == nil {
            _gender = ""
        }
        return _gender
    }
    
    var birthYear: String! {
        if _birthYear == nil {
            _birthYear = ""
        }
        return _birthYear
    }
    
    init(name: String, nameID: Int, desc: String) {
        self._name = name
        self._nameID = nameID
        
        if self.nameID < 17 {
            self._peopleURL = "\(URL_base)\(self._nameID!)/"
        } else {
            
            self._peopleURL = "\(URL_base)\(self._nameID!+1)/"
        }
        
        
        self._desc = desc
        
    }
    
    func downloadPeopleDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_peopleURL).responseJSON { (response: DataResponse<Any>) in
            //print(response.response!)
            //print(response.result)
            //print(response.result.value.debugDescription)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["mass"] as? String {
                    self._weight = weight
                }
                
                if let skinColor = dict["skin_color"] as? String {
                    self._skinColor = skinColor
                }
                
                if let hairColor = dict["hair_color"] as? String {
                    self._hairColor = hairColor
                }
                
                if let gender = dict["gender"] as? String {
                    self._gender = gender
                }
                
                if let birthYear = dict["birth_year"] as? String {
                    self._birthYear = birthYear
                }
                
                //print(self._height)
                //print(self._weight)
                //print(self._skinColor)
                //print(self._hairColor)
                //print(self._gender)
                //print(self._birthYear)
            }
            
            completed()
            
        }
        
        
    }
}
