//
//  ViewController.swift
//  todo
//
//  Created by admin on 26.10.2023.
//

import UIKit

final class AuthViewController: ParentViewController {
    @IBOutlet private var emailTextField: TextInput!
    @IBOutlet private var passwordTextField: TextInput!

    @IBOutlet private var signInButton: PrimaryButton!
    @IBOutlet private var signUpButton: TextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = L10n.Auth.title
        navigationController?.navigationBar.prefersLargeTitles = true

        emailTextField.setup(placeholder: L10n.Auth.emailTextField, text: nil)
        passwordTextField.setup(placeholder: L10n.Auth.passwordTextField, text: nil)
        
        signInButton.setTitle(L10n.Auth.signInButton, for: .normal)
        signUpButton.setTitle(L10n.Auth.signUpButton, for: .normal)

        passwordTextField.enableSecurityMode()
        
        addTapToHideKeyboardGesture()
    }
    
    @IBAction private func didTabSignIn() {
        let emailTFIsValid = emailTFValidation()
        let passwordTFIsValid = passwordTFValidation()
        
        if emailTFIsValid && passwordTFIsValid {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NavMainVC")
            view.window?.rootViewController = vc
        }
    }
    
    private func emailTFValidation() -> Bool {
        if ValidationManager.isValid(commonText: emailTextField.text) {
            if ValidationManager.isValid(email: emailTextField.text) {
                return true
            } else {
                emailTextField.show(error: L10n.ErrorValidation.email)
                return false
            }
        } else {
            emailTextField.show(error: L10n.ErrorValidation.emptyField)
            return false
        }
    }
    
    private func passwordTFValidation() -> Bool {
        if ValidationManager.isValid(commonText: passwordTextField.text) {
            return true
        } else {
            passwordTextField.show(error: L10n.ErrorValidation.emptyField)
            return false
        }
    }
}
