//
//  SelectorVC.swift
//  Pryaniki
//
//  Created by Nikola on 27/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import UIKit

class SelectorVC: UIViewController {
    
    let networkPryanikiManager = NetworkPryanikiManager()
    
    lazy var label1: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var label2: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var label3: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var labelArr = [label1,label2,label3]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

}




extension SelectorVC {
    
    func setupUI() {
        networkPryanikiManager.fetchData { [weak self] (pryanikiData) in
            guard let self = self else { return }
            guard let variantsArr = pryanikiData.data[2].data.variants else {return}
            DispatchQueue.main.sync {
                for (name, label) in zip(variantsArr, self.labelArr) {
                    label.font = UIFont(name: "Menlo", size: 22)
                    label.textColor = .systemBlue
                    label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                    label.text = name.text
                    label.textAlignment = .center
                    label.layer.shadowColor   = UIColor.black.cgColor
                    label.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
                    label.layer.shadowRadius  = 6
                    label.layer.shadowOpacity = 0.2
                    label.layer.masksToBounds = false
                }
            }
        }
        // Vertical Stack View
        let stackView = UIStackView(arrangedSubviews: labelArr)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    
}
