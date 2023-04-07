//
//  AdddViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/26.
//

import UIKit
import RealmSwift
import MapKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!

    
    let realm = try! Realm()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //キーボードしまう
        nameTextField.delegate = self
        addressTextField.delegate = self
        memoTextView.delegate = self
        
        //画像選択
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
    
    
    //写真表示
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
        
        // 住所を元に緯度経度を取得する
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(self.addressTextField.text ?? "") { (placemarks, error) in
                guard let placemarks = placemarks, let location = placemarks.first?.location else {
                    // 緯度経度を取得できなかった場合の処理
                    return
                }

                // 緯度経度を取得できた場合の処理

                // MKMapViewにアノテーションを追加する
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                self.mapView.addAnnotation(annotation)
                        
                // MKMapViewの表示範囲を設定する
                let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
            }
    }
    
    //キャンセルボタン
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //Returnキーでキーボード閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
}






