//
//  CodeTableViewController.swift
//  UILocalized​Indexed​Collation Demo
//
//  Created by lindongdong on 2017/9/21.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class CodeTableViewController: UITableViewController {
    
    var countries = [Country]()
    var countriesWithSections = [[Country]]()
    var sectionTitles = [String]()
    let collation = UILocalizedIndexedCollation.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setup()
    
    }
    
    func setup(){
        
        countries = CountryFetcher.getCountries()
        
        let(countryArr, titlesArr) = collation.partitionObjects(array: countries, collationStringSelector: #selector(getter: Country.countryName))
        countriesWithSections = countryArr as![[Country]]
        sectionTitles = titlesArr
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesWithSections[section].count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countriesWithSections[indexPath.section][indexPath.row]
        cell.textLabel?.text = country.countryName
        
        let phoneCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 24))
        phoneCodeLabel.textAlignment = .right
        phoneCodeLabel.textColor = UIColor.lightGray
        phoneCodeLabel.font = UIFont.systemFont(ofSize: 15)
        phoneCodeLabel.text = "+" + country.phoneCode
        cell.accessoryView  = phoneCodeLabel
        return cell
    }
    

}
