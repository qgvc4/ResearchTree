//
//  NewFeedViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/9/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class NewFeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.keyboardDismissMode = .onDrag
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 5
        
        imagePicker.delegate = self
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add a picture", message: "How do you want to upload the picture?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in
            self.takePhotoWithCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Use Existing Photo", style: .default, handler: { action in
            self.getPhotoFromLibrary()
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
}

extension NewFeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let alertController = UIAlertController(title: "No Camera", message: "The device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getPhotoFromLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
