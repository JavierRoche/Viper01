//
//  RegisterView.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class RegisterView: BaseViewController, RegisterViewContract {
    @IBOutlet weak var userLoggedLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var repeatText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var hidePanelButton: UIButton!
    
	var presenter: RegisterPresenterContract!
    
    /// SigIn / SignUp panel
    var onSignUpInterface: Bool = false

    
	// MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.delegate = self
        passwordText.delegate = self
        repeatText.delegate = self
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.viewWillAppear()
    }
    
    
    // MARK: User Interactions
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        /// Launch register or open register panel
        view.endEditing(true)
        !onSignUpInterface ? signUpInterface() : signUp()
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        signIn()
    }
    
    @IBAction func hideRegisterPanelTapped(_ sender: Any) {
        signInInterface()
    }
    
    
    // MARK: Private Functions
    
    fileprivate func signUpInterface() {
        let originalTransform = signUpButton.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: 90.0)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.signUpButton.transform = translatedTransform
            self.signInButton.transform = translatedTransform

        }) { _ in
            self.onSignUpInterface = true
            /// Show register interface
            self.signInButton.isHidden = true
            self.hidePanelButton.isHidden = false
            self.repeatLabel.isHidden = false
            self.repeatText.isHidden = false
        }
    }
    
    fileprivate func signInInterface() {
        onSignUpInterface = false
        /// Hide register interface
        self.signInButton.isHidden = false
        self.hidePanelButton.isHidden = true
        self.repeatLabel.isHidden = true
        self.repeatText.isHidden = true
        
        let originalTransform = signUpButton.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: -90.0)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.signUpButton.transform = translatedTransform
            self.signInButton.transform = translatedTransform
        })
    }
    
    fileprivate func signUp() {
        /// Empty fields check
        guard let email = emailText.text?.lowercased(), let password = passwordText.text, let repeatPass = repeatText.text,
            !email.isEmpty, !password.isEmpty, !repeatPass.isEmpty else {
            presenter.badDataIntput(message: Constants.missingData)
            return
        }
        
        if password != repeatPass {
            presenter.badDataIntput(message: Constants.dismatchPassword)
            return
        }
        
        /// Inicializamos un User con los datos introducidos por el usuario y registramos
        if presenter.saveCredentials(email: email, password: password) {
            userLoggedLabel.text = presenter.loadCredentials(email: email, password: password)
        }
    }
    
    fileprivate func signIn() {
        /// Empty fields check
        guard let email = emailText.text?.lowercased(), let password = passwordText.text,
            !email.isEmpty, !password.isEmpty else {
            presenter.badDataIntput(message: Constants.missingData)
            return
        }
        
        userLoggedLabel.text = presenter.loadCredentials(email: email, password: password)
    }
}
