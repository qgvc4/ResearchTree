//
//  EditMyPostViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/12/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class EditMyPostViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var myPost: Feed?
    var userToken: String?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.keyboardDismissMode = .onDrag
        
        activityIndicator.isHidden = true
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 5

        if let myPost = myPost {
            titleTextField.text = myPost.title
            descriptionTextView.text = myPost.description
            if let data = myPost.attachment, let image = UIImage(data: data) {
                postImageView.image = image
            }
        }
        
        imagePicker.delegate = self
    }
    
    @IBAction func updatePhotoTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add a picture", message: "How do you want to upload the picture?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in
            self.takePhotoWithCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Use Existing Photo", style: .default, handler: { action in
            self.getPhotoFromLibrary()
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        self.loading()
        
        let title = titleTextField.text
        let description = descriptionTextView.text
        let postImage = postImageView.image
        
        if title == nil || title!.isEmpty {
            displayAlert(message: "title cannot be empty")
            self.loadingComplete()
            return
        }
        
        if description == nil || description!.isEmpty {
            displayAlert(message: "description cannot be empty")
            self.loadingComplete()
            return
        }
        
        // get current user
        var user: User?
        let userData = UserDefaults.standard.data(forKey: "userData")
        let decoder = JSONDecoder()
        if let userData = userData {
            do {
                user = try decoder.decode(User.self, from: userData)
            } catch {
                print("decode error")
            }
        }
        
        if let user = user, let myPost = myPost {
            var updatedPost = PostPutFeedRequest.init(title: title!, peopleId: user.id, description: description!, attachment: nil)
            
            if postImage != nil {
                updatedPost.attachment = toBase64(image: postImage!)
            }
            
            FeedService.updateFeed(userToken: user.token!, feedId: myPost.id, putFeedRequest: updatedPost, dispatchQueueForHandler: DispatchQueue.main) {
                (feed, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                    self.loadingComplete()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func toBase64(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0) else { return nil }
        return imageData.base64EncodedString()
    }
    
    func loading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        saveButton.isEnabled = false
    }
    
    func loadingComplete() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        saveButton.isEnabled = true
    }
}

extension EditMyPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            postImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
