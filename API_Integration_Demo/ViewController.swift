//
//  ViewController.swift
//  API_Integration_Demo
//
//  Created by Sai Deep Konduri on 25/03/22.
//

import UIKit
import Foundation

// MARK: - Welcome
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}


struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String
}


struct Company: Codable {
    let name, catchPhrase, bs: String
}

struct UserEmail: Codable {
    let email: String
}


class ViewController: UIViewController {

    @IBAction func onClick(_ sender: Any) {
        getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var getOutlet: UILabel!
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBAction func onPost(_ sender: Any) {
        postData()
    }
    
    @IBOutlet weak var postResponseOutlet: UILabel!
    func getData() {
        // 1) create URL
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/users/1") else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode(User.self, from: data);
                DispatchQueue.main.async {
                    self.getOutlet.text = "Name: \(decoded.name)"
                }
               
            } catch let error {
                print("Error in JSON parsing", error)
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    
    
    func postData() {
        // 1) create URL
        guard let url = URL(string:"http://localhost:3000/email") else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        let email = emailOutlet.text!
        let parameters: [String: Any] = ["email": email, "emai3l": email ,"ema3il": email]

        httpRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode(UserEmail.self, from: data);
                DispatchQueue.main.async {
                    self.postResponseOutlet.text = "email: \(decoded.email)"
                }
               
            } catch let error {
                print("Error in JSON parsing", error)
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    
   
    
    
    
    


}

