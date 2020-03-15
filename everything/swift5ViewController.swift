//
//  swift5ViewController.swift
//  everything
//
//  Created by Sarah Alsharif on 2/27/20.
//  Copyright © 2020 Raqmia. All rights reserved.
//

import UIKit

class swift5ViewController: UIViewController {

    struct  Course : Decodable {
        let id : Int?
        let name : String?
        let link : String?
        let imageUrl : String?
        let numberOfLessons : Int?
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       /* fetchJson { (res) in
            switch res {
            case .success(let courses):
                courses.forEach { (course) in
                    print(course.name ?? "")
                }
            case .failure(let err):
                print(err)
            }
        }*/
        
        //------------------------
        fetchJsonCourses { (res) in
            switch res {
            case .success(let courses):
                courses.forEach { (course) in
                    print(course.name ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func fetchJson(completion: @escaping (Result<[Course],Error>) -> ()){
        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        // make URL
        guard let url = URL(string: jsonURLString) else { return }
        
        // start a session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check for error
            if let err = error {
                completion(.failure(err))
                return
            }
            // check for 200 OK status
            do {
                guard let data = data else { return }
                let courses = try JSONDecoder().decode([Course].self, from: data)
                completion(.success(courses))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
        }.resume()
    }

    
    
    //-----------------------SAME JUST PRACTICING MORE-------------------------------
    fileprivate func fetchJsonCourses (completion: @escaping (Result<[Course],Error>) -> ()){
        let urlStr =  "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                guard let data = data else { return }
                let courses = try JSONDecoder().decode([Course].self, from: data)
                completion(.success(courses))
            } catch let jsonErr {
                completion(.failure(jsonErr))
                print(jsonErr)
            }
        }.resume()
        
    }
    
}
