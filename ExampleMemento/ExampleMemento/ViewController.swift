//
//  ViewController.swift
//  ExampleMemento
//
//  Created by Kalandarov Vakil on 06.03.2024.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Visual Components
    //
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var saveBuutton: UIButton!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.layer.borderColor = UIColor.black.cgColor
        loginLabel.layer.borderWidth = 1
        passwordLabel.layer.borderColor = UIColor.black.cgColor
        passwordLabel.layer.borderWidth = 1
    }

    
    //MARK: - Private Methods
    @IBAction func save(_ sender: Any) {
        let user = User(emailTitle: loginTextField.text ?? "", passwordTitle: passwordTextField.text ?? "")
        let caratacer = UserManager()
        caratacer.save(users: user)
    }
    
}

