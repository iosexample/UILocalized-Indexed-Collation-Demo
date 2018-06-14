//
//  CountryCode.swift
//  UILocalized​Indexed​Collation Demo
//
//  Created by lindongdong on 2017/9/21.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

class Country:NSObject {

   @objc var countryName   :String!
    var countryPinyin :String!
    var phoneCode     :String!
    var countryCode   :String!
  
    init(dictionary: JSON) {
        self.countryName   = dictionary["countryName"] as! String
        self.phoneCode     = dictionary["phoneCode"] as! String
        self.countryCode   = dictionary["countryCode"] as! String
    }
}

struct CountryFetcher {
    
    static func getCountries() -> [Country] {
        
        var countries = [Country]()
        
        if let filePath = Bundle.main.path(forResource: "Country", ofType: "json"){
            
            if  let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)){
                
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonData, options:[]) as! JSON
                    
                    if  let dicts = json["data"] as? [JSON] {
                        
                        countries = dicts.map({
                            return Country.init(dictionary: $0)
                        })
                    }
                    
                }catch let error as NSError{
                    print("解析出错: \(error.localizedDescription)")
                }
            }
            
        }
        return countries
    }
}
