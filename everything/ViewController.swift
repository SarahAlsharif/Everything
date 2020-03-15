//
//  ViewController.swift
//  everything
//
//  Created by Sarah Alsharif on 2/26/20.
//  Copyright © 2020 Raqmia. All rights reserved.
//

import UIKit

// MAKE STRUCT VARIABLES OPTIONAL TO PREVENT CRASHING WHEN VARIABLE IS EMPTY
struct WebDescription : Decodable {
    let name : String?
    let description : String?
    let courses : [Course]?
}

struct Course : Decodable {
    let id : Int?
    let name : String?
    let link : String?
    let imageUrl : String?
    
//MARK: - For SWIFT 2 & 3 JSON
   /* init(json: [String:Any]){
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }*/
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // JSON URL
        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        // make URL
        guard let url = URL(string: jsonURLString) else { return }
        
        // start a session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check for error
            // check for 200 OK status
            
            guard let data = data else { return }
//MARK: - JSON using SWIFT 4
            do {
                let webDesc = try JSONDecoder().decode(WebDescription.self, from: data)
                print(webDesc.name ?? "",webDesc.description ?? "")
            } catch let err {
                print ("Json Err", err)
            }
            
            /*do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
            } catch let err {
                print("JSON Error", err)
            }*/
            
//MARK: - use Course Struct before init added to Course
            // use Course Struct
            /* let myCourse = Course(id: 1, name: "courseOne", link: "linkToCourse", imageURL: "courseImage")
            print(myCourse)*/
//MARK: - Print JSON as a string
            // print data as a string to see it
           /* let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)*/
            
//MARK: - SWIFT 2 JSON
            // SWIFT 3 & 2 JSON Serialization
            /*do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                //print(json)
                let myCourse = Course(json: json)
                print(myCourse)
            } catch  let err {
                print(err)
            }
            */
//MARK: - DONT FORGET RESUME
        }.resume()
        
        
        
        
    }


}

