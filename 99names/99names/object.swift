//
//  object.swift
//  99names
//
//  Created by Helal Chowdhury on 4/16/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import Foundation

struct object: Decodable{
    let name: String
    let transliteration: String
    let meaning: String
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }

    init(json:[String:Any]) throws {
        guard let name = json["name"] as? String else {throw SerializationError.missing("name is missing")}
        guard let transliteration = json["transliteration"] as? String else {throw SerializationError.missing("name is missing")}
        guard let meaning = json["meaning"] as? String else {throw SerializationError.missing("name is missing")}
        self.name = name
        self.transliteration = transliteration
        self.meaning = meaning
    }

    static let basePath = "http://api.aladhan.com/asmaAlHusna/"

    static func getNames(completion: @escaping ([object]) -> ()) {
        let url = basePath + "1"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var namesArray:[object] = []
            
            if let data = data{
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let oneName = json["data"] as? [[String:Any]]{
                            for dataPoint in  oneName{
                                if let nameObject = try? object(json: dataPoint){
                                    namesArray.append(nameObject)
                                }
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
                completion(namesArray)
            }
            
            
            
        }
        
        task.resume()
    }
}
