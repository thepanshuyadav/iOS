//
//  DetailViewController.swift
//  Project1
//
//  Created by Deepanshu Yadav on 04/01/20.
//  Copyright © 2020 Deepanshu Yadav. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var totalNumberOfCells : Int?
    var indexOfSelectedImage : Int?

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(shareTapped))
        title = "\(indexOfSelectedImage! + 1)/\(totalNumberOfCells ?? 0)"
        if let image = selectedImage {
            imageView.image = UIImage(named: image)
        }
    }
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let imageName = selectedImage else {
            return
        }
        let imageNameData = Data(imageName.utf8)

        let vc = UIActivityViewController(activityItems: [image,imageNameData], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
