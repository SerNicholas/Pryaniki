//
//  ViewController.swift
//  Pryaniki
//
//  Created by Nikola on 14/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var networkPryanikiManager = NetworkPryanikiManager()
    
    lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.backgroundColor = .systemYellow
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 2
        button.backgroundColor = .systemPurple
        button.layer.shadowColor   = UIColor.black.cgColor
        return button
    }()
    
    lazy var button4: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    lazy var buttonArray = [button1, button2, button3, button4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
}



extension ViewController {
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        networkPryanikiManager.fetchData { (pryanikiData) in
            DispatchQueue.main.sync {
                switch sender.tag {
                case 0:
                    guard let title = pryanikiData.data[0].data.text else {return}
                    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                case 1:
                    self.performSegue(withIdentifier: "goToSelectorVC", sender: self.button2)
                default:
                    self.performSegue(withIdentifier: "goToPictureVC", sender: self.button3)
                }
            }
        }
    }
    
    func btnUISettings() {
        
        networkPryanikiManager.fetchData { [weak self] (pryanikiData) in
            guard let self = self else { return }
            DispatchQueue.main.async {
//                self.title = pryanikiData.view.description
                self.title = "Pryaniki JSON "
                let viewArr = pryanikiData.view
                for (name, button) in zip(viewArr, self.buttonArray) {
                    button.setTitle(name, for: .normal)
                    button.layer.cornerRadius = 25
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = UIFont(name: "Menlo", size: 22)
                    //Button Shadow Settings
                    button.layer.shadowColor   = UIColor.black.cgColor
                    button.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
                    button.layer.shadowRadius  = 6
                    button.layer.shadowOpacity = 0.4
                    button.clipsToBounds       = true
                    button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
                    button.layer.masksToBounds = false
                }
            }
        }
    }
    
    
    func setupUI() {
        
        btnUISettings()
        // Vertical Stack View
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        // Constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            
        ])
        
    }
}
