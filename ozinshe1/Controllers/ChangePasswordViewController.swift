//
//  ChangePasswordViewController.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 14.08.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var secondPasswordTextField: TextFieldWithPaddington!
        @IBOutlet weak var passwordTextField: TextFieldWithPaddington!
        override func viewDidLoad() {
            super.viewDidLoad()
            hideKeyboardWhenTappedAround()
        }
        
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
    @IBAction func changePassword(_ sender: UIButton) {
        if passwordTextField.text! == secondPasswordTextField.text! {
            changePass()
        } else{
            SVProgressHUD.showError(withStatus: "posword error")
        }
        
    }
    
        func changePass() {
            let password = passwordTextField.text!
            let parameters = ["password": password]

            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
            ]

            AF.request(Urls.CHANGE_PASSWORD, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                var resultString = ""
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
            }
        }
}
