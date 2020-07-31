//
//  PictureVC.swift
//  Pryaniki
//
//  Created by Nikola on 27/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import UIKit

class PictureVC: UIViewController {
    
    var networkPryanikiManager = NetworkPryanikiManager()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
}




extension PictureVC {
    
    func setupView() {
        
        networkPryanikiManager.fetchData { pryanikiData in
            guard let pictureURL = pryanikiData.data[1].data.url else { return }
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                DispatchQueue.main.async {
                    guard let url = URL(string: pictureURL), let data = try? Data(contentsOf: url) else {return}
                    self.imageView.image = UIImage(data: data)
                }
            }
            
        }
       
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
         
        
        ])
    }
}
