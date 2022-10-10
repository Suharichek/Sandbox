//
//  LoginViewController.swift
//  Sandbox2
//
//  Created by Suharik on 02.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //    private lazy var  loginview : UIView = {
    //        let loginview = UIView()
    //        loginview.translatesAutoresizingMaskIntoConstraints = false
    //        return loginview
    //    }()
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 3
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Создать пароль", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textfield)
        view.addSubview(button)
        setup()
    }
    
    func setTitle() {
        
    }
    
    func setup(){
        NSLayoutConstraint.activate([
                                        textfield.topAnchor.constraint(equalTo: view.centerYAnchor),
                                        textfield.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
                                        textfield.heightAnchor.constraint(equalToConstant: 40),
                                        textfield.widthAnchor.constraint(equalToConstant: 180),
                                        
                                        button.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 16),
                                        button.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
                                        button.heightAnchor.constraint(equalToConstant: 40),
                                        button.widthAnchor.constraint(equalToConstant: 180)])
    }
    
}
