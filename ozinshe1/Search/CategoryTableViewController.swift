//
//  CategoryTableViewController.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 19.08.2023.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class CategoryTableViewController: UIViewController {
    
    var categoryID = 0
    var movies:[Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let MovieCellnib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(MovieCellnib, forCellReuseIdentifier: "MovieCell")
        
        downloadMoviesByCategory()
        
    }
    
    func downloadMoviesByCategory () {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters = ["categoryID": categoryID]
        
        AF.request(Urls.MOVIES_BY_CATEGORY_URL, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            
            
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if json["content"].exists() {
                    if let array = json["content"].array {
                        for item in array {
                            let movie = Movie(json: item)
                            self.movies.append(movie)
                        }
                        self.tableView.reloadData()
                    }
                } else{
                    var ErrorString = "CONNECTION ERROR".localized()
                    SVProgressHUD.showError(withStatus: "CONNECTION ERROR".localized())
                    if let sCode = response.response?.statusCode {
                        ErrorString = ErrorString + "\(sCode)"
                    }
                }
            }
            
            // Do any additional setup after loading the view.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
