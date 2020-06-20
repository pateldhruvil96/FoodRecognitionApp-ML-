//
//  ViewController.swift
//  SeeFood
//
//  Created by Dhruvil Patel on 6/20/20.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        imagePicker.sourceType = .camera
      //  imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing=true
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage //this is done to check if it is not nill then proceed further
       {
         imageView.image=userPickedImage
        }
      
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil) //so when button is clicked it will trigger the imagepicker actions which consists of above mention actions ie opens camera,allows editing n all.
    }
    
    
}

