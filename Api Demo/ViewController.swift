//
//  ViewController.swift
//  Api Demo
//
//  Created by MacStudent on 2020-01-17.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var weatherLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func selectCity(_ sender: UIButton) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityTxt.text!.replacingOccurrences(of: " ", with: "%20  "))&appid=c17d8d7682b67d8f504e1225bde825c4")!
               
               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let error = error{
                       print(error)
                   }else if let urlContent = data {
                           do{
                               let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                          //     print(jsonResult!)
                               
                               if let description = ((jsonResult?["weather"] as? NSArray)?[0] as? NSDictionary)? ["description"] as? String{
                                   print(description)
                                DispatchQueue.main.async {
                                    self.weatherLbl.text = description
                                }
                               }
                           }catch{
                               print(error)
                           }
                       }
                   }
               
               //satart the task
               task.resume()
    }
    
}

