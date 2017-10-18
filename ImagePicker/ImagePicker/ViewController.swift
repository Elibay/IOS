//
//  ViewController.swift
//  ImagePicker
//
//  Created by Elibay Nuptebek on 18.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction (title: "Открыть изображение", style: .default, handler: { (action: UIAlertAction) in
       
        }))
        actionSheet.addAction(UIAlertAction (title: "Изменить изображение, камера", style: .default, handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present (imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction (title: "Изменить изображение, библиотека", style: .default, handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present (imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction (title: "Отмена", style: .cancel, handler: nil))
        self.present (actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

