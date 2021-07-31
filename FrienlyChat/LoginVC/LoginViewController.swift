//
//  LoginViewController.swift
//  FrienlyChat
//
//  Created by anmol rattan on 30/07/21.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
class LoginViewController: UIViewController {

    fileprivate var _authHandle:AuthStateDidChangeListenerHandle!
     var user:User?
     var authUI:FUIAuth?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAuth()

       
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loadLoginSession()
    }
    
    func configureAuth(){
        
        _authHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let activeUser = user{
                if self.user != activeUser{
                    self.user = activeUser
                    print(activeUser)
                    self.pushToFCViewController(user: activeUser)
                    
                }
            }else{
                print("Login Failed")
                self.loadLoginSession()
            }
        })
        
    }
    
    private func pushToFCViewController(user:User){
        let vc = UIStoryboard.loadFCViewController()
        vc.user = user
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    
    func loadLoginSession(){
         authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        if let authUI = self.authUI{
        let providers: [FUIAuthProvider] = [FUIEmailAuth(),FUIGoogleAuth(authUI: authUI)]
        authUI.providers = providers
        let vc = authUI.authViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        }
    }
    deinit{
        Auth.auth().removeStateDidChangeListener(_authHandle)
        
    }


}



extension LoginViewController:FUIAuthDelegate{
    
}
