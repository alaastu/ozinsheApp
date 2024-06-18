//
//  EditProfileViewController.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 14.08.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController {
    var userData = UserInfo()
    var userID: Int?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileInfo()
        // Do any additional setup after loading the view.
    }
    
    func configView() {
            emailTextField.text = userData.user.email
            nameTextField.text = userData.name
            phoneNumberTextField.text = userData.phoneNumber
//            dateString = userData.birthday
        }
    func getProfileInfo() {
            
            SVProgressHUD.show()
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
            ]
            
            AF.request(Urls.PROFILE_URL, method: .get, headers: headers).responseData { [weak self] response in
                SVProgressHUD.dismiss()
                
                print("Alamofire")
                print(response.response?.statusCode)
                if response.response?.statusCode == 200 {
                    let json = JSON(response.data!)
                    let data = UserInfo(json: json)
                    print("345678")
                    self?.userData = data
                    self?.configView()
                    self?.userID = json["id"].int
                }
                else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                    var ErrorString = "CONNECTION_ERROR".localized()
                    if let sCode = response.response?.statusCode {
                        ErrorString = ErrorString + " \(sCode)"
                    }
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                    self?.navigationController?.popViewController(animated: true)
                }
            }
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
