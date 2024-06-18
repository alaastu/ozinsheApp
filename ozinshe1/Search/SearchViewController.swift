//
//  SearchViewController.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 17.08.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var searchTextField: TextFieldWithPaddington!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Category] = []
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        downloadCategories ()
        //        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    func configureViews () {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 100
        collectionView.collectionViewLayout = layout
        
        tableView.delegate = self
        tableView.dataSource = self
        let MovieCellnib = UINib(nibName: "MovieCell",bundle: nil)
        tableView.register(MovieCellnib, forCellReuseIdentifier: "MovieCell")
        
        searchTextField.padding = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
    }
    
    @IBAction func textFieldEditingBegin(_ sender: TextFieldWithPaddington) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func textFieldEditingEnd(_ sender: TextFieldWithPaddington) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        //downloadSearchMovies()
        
    }
    func hideKeyboardWhenTappedAround (){
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard))
    
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
   
    @IBAction func clearTextField(_sender: Any) {
        searchTextField.text = ""
        downloadSearchMovies()
    }
    func  downloadSearchMovies() {}
    
    @IBAction func searchButton(_ sender: Any) {
        downloadSearchMovies()
    }
    
    
    /*
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
                cell.setData(movie: movies[indexPath.row])
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        152
        
    }
    
    func downloadCategories() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.CATEGORIES_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
//            var resultString = ""
//            if let data = response.data {
//                resultString = String(data: data, encoding: .utf8)!
//                print(resultString)
//            }
//            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let category = Category(json: item)
                        self.categories.append(category)
                    }
                    self.collectionView.reloadData() }
                else {
                    SVProgressHUD.showError(withStatus: "CONNECTION ERROR".localized())
                }
                
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = categories[indexPath.row].name
        
        let backgroundview = cell.viewWithTag(1000) as! UIView
        backgroundview.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let categoryTableViewController = storyboard?.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        categoryTableViewController.categoryID = categories[indexPath.row].id
        
        navigationController?.show(categoryTableViewController, sender: self)
        
    }
}
