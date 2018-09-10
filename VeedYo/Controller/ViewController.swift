//
//  ViewController.swift
//  VeedYo
//
//  Created by Sidhant Chadha on 9/6/18.
//  Copyright © 2018 AMoDynamics, Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate {
   
    let googleButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleButtons()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    
        //Observer for successfull sign-in notification//
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)


    }
    
    @objc func didSignIn()  {
        googleButton.hero.id = "gbutton"
        googleButton.hero.modifiers = [.fade, .spring(stiffness: 250, damping: 2500)]
        performSegue(withIdentifier: "goToSearch", sender: self)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupGoogleButtons() {
        //Add google sign in button
        googleButton.colorScheme = .dark
        googleButton.frame = CGRect(x: 16, y: 416 + 66, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    

}

