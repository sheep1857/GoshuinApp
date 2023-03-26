//
//  AdddViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/26.
//

import UIKit
import RealmSwift

class AdddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    let realm = try! Realm()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //キーボードしまう
        nameTextField.delegate = self
        addressTextField.delegate = self
        memoTextView.delegate = self
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto(_:)))
        photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
    }

    //写真
    @objc func selectPhoto(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //写真
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = pickedImage
            photoImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //セーブ
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text, let address = addressTextField.text else { return }
        let memo = memoTextView.text
        
        let shrine = RealmData()
        shrine.name = name
        shrine.address = address
        shrine.memo = memo
        if let imageData = selectedImage?.jpegData(compressionQuality: 0.1) {
            shrine.photo = imageData
        }
        
        try! realm.write {
            realm.add(shrine)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
}



