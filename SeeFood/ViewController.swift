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
            guard let ciImage=CIImage(image: userPickedImage) else{ //this is done to convert picked image into                                                            ciimage for further process
                fatalError("Can not able to convert UIImage to CIImage") //CI:coreImage
            }
            detect(image: ciImage)
            
            
        }
    
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage) //this will process our CIImage for interpretation but before executing this it will execute "handler"
    {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Loading coreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("Unable to fetch request for classification")
            }
           // print(results)
//            if let firstResult=results.first{
//                if firstResult.identifier.contains("computer")
//                {
//                    self.navigationItem.title="Computer"
//                }
//                else
//                {
//                    self.navigationItem.title="Not computer"
//                }
//            }
            if let firstResult=results.first?.identifier{
                DispatchQueue.main.async {
                    
                
                self.navigationItem.title=firstResult
                self.navigationController?.navigationBar.barTintColor=UIColor.gray
                }
               
            }
            else{print("Nothing found sorry")}
            
        }
       
        
    
        
        
        
        let handler = VNImageRequestHandler(ciImage: image)//it is the handler that specify the image we want classify on.So once this process gets completed it will go to "request" and completed the further process
        do{
        try handler.perform([request])
        }catch{
            print("Error:\(LocalizedError.self)")
        }
        
        
    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil) //so when button is clicked it will trigger the imagepicker actions which consists of above mention actions ie opens camera,allows editing n all.
    }
    
    
}

