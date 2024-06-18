//
//  ProfileViewController.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 16.03.2023.
//
import UIKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    
    @IBOutlet weak var myProfileLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func LogOutButton(_ sender: Any) {
        let exitVC = storyboard?.instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
        exitVC.modalPresentationStyle = .overFullScreen
        self.present(exitVC, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    func configureViews() {
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
    }
    
    @IBAction func languageShow(_ sender: Any){
        
        let languageVC = storyboard?.instantiateViewController(identifier: "LanguageViewController") as! LanguageViewController
    
        languageVC.modalPresentationStyle = .overFullScreen
      
        languageVC.delegate = self
     
        present(languageVC, animated: true, completion: nil)
    }
    
    func languageDidChange() {
        configureViews()
    }
    
    
    @IBAction func EditProfile(_ sender: Any) {
        let dataVC = storyboard?.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
        dataVC.title = "Жеке деректер"
        navigationItem.title = ""
        show(dataVC, sender: true)
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        let dataVC = storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as! ChangePasswordViewController
        dataVC.title = "Құпия сөзді өзгерту"
        navigationItem.title = ""
        show(dataVC, sender: true)
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
            
       
