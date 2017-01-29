//
//  SignInViewController.swift
//  link2golfApp
//
//  Created by Kevin Curry on 1/8/17.
//  Copyright © 2017 masters. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth


class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    @IBOutlet var emailLoginField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
  
    @IBOutlet var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    

let loginButton = FBSDKLoginButton()
   view.addSubview(loginButton)
  loginButton.frame = CGRect(x: 16, y: 600, width: view.frame.width - 30, height: 50)
        
          loginButton.delegate = self
        // login data from user: email pub flie, DOB, ect
        loginButton.readPermissions = ["email", "public_profile"]
    
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("You are now logged out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
    }
    
        
        func showEmailAddress() {
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString
                
                else {
                
                    return }
            
            let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                if error != nil {
                
                print(" Some user has an issue logging in.", Any.self)
                
                    return
                }
            
                print("You have succesfully logged in to Facebook: ", error ?? " ")
            })
        
        }
    
    
    @IBAction func accountCreated(_ sender: UIButton) {
        
        FIRAuth.auth()?.createUser(withEmail: emailLoginField.text!, password: passwordField.text!, completion: {
            user, error in
            
            if error != nil{
            
                self.login()
                
            }
            
            else {
                print("user created")
                self.login()
                
            }
        
        
        })

    }
    
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: emailLoginField.text!, password: passwordField.text!, completion: {
            
            user, error in
            
            if error != nil {
                
                print("Email or Passowrd in invalid.")
                
            } else {
                
                print("Login and password are correct!")
            }
            
        })

    }

}








