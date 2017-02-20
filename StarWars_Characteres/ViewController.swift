//
//  ViewController.swift
//  StarWars_Characteres
//
//  Created by Saumya Raval on 2/18/17.
//  Copyright © 2017 PlayAgain. All rights reserved.
//

import UIKit
import HandySwift
import CSVImporter


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!

    var people = [People]()
    var filteredPeople = [People]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parseCSVImporter()
    }
    
    func parseCSVImporter() {
        let path1 = Bundle.main.path(forResource: "People", ofType: "csv")!
        
        let structImporter = CSVImporter<[String: String]>(path: path1)
        let structImport = structImporter.importRecords(structure: { (headerValues) in
            //print(headerValues)
        }) { $0 }
        
        for rec in structImport {
            //print(rec)
            //print(structImport.count)
            //print(rec["id"]!)
            //print(rec["identifier"]!)
            //print(rec["desc"]!)
            
            let nameID1 = Int(rec["id"]!)!
            let name1 = rec["identifier"]!
            let desc1 = rec["desc"]!
            
            let people1 = People(name: name1, nameID: nameID1, desc: desc1)
            //print(people1)
            self.people.append(people1)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath as IndexPath) as? PeopleCell {
            
            let peop: People
            
            if inSearchMode {
                peop = filteredPeople[indexPath.row]
            } else {
                peop = people[indexPath.row]
            }
            
            cell.configCell(peop)
            return cell
            
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let peoples: People!
        
        if inSearchMode {
            peoples = filteredPeople[indexPath.row]
        } else {
            peoples = people[indexPath.row]
        }
        
        performSegue(withIdentifier: "PeopleDetailVC", sender: peoples)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PeopleDetailVC" {
            if let detailVC = segue.destination as? PeopleDetailVC{
                if let peoples = sender as? People {
                    detailVC.people = peoples
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPeople.count
        }
        return people.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.capitalized
            filteredPeople = people.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
}


