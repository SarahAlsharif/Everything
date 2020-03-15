//
//  JsonUpdateViewController.swift
//  everything
//
//  Created by Sarah Alsharif on 2/26/20.
//  Copyright © 2020 Raqmia. All rights reserved.
//

import UIKit

class JsonUpdateViewController: UITableViewController {

    var courses = [Course]()
    
    struct Course : Decodable {
        let id : Int?
        let name : String?
        let link : String?
        let imageUrl : String?
        let numberOfLessons : Int?
//MARK: - SWIFT 4.0 coding
        /*private enum CodingKeys : String, CodingKey {
            case numberOfLessons = "number_of_lessons"
            case imageUrl = "image_url"
            case id, name, link
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NAVIGATION CONTROLLER
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Course List"
        fetchJSON()
    }
    
   fileprivate func fetchJSON() {
        let strURL = "https://api.letsbuildthatapp.com/jsondecodable/courses_snake_case"
        guard let url = URL(string: strURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                // SWIFT 4.1
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                self.tableView.reloadData()
            } catch let err {
                print (err)
            }
        }.resume()
    }
    
//MARK: - TABLE VIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let course = courses[indexPath.row]
        cell.textLabel?.text = course.name
        cell.detailTextLabel?.text = String(course.link ?? "")
        
        return cell
    }
}
