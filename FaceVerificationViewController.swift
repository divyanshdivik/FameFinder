//
//  FaceVerificationViewController.swift
//  AWSRekognitionStarterApp
//
//  Created by Divyansh Shah on 26/04/24.
//  Copyright © 2024 AWS. All rights reserved.
//

import UIKit
import AWSRekognition

class FaceVerificationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let rekognitionClient = AWSRekognition.default()
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var resultLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        resultLabel.text = ""
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if the segue identifier matches a specific segue
        if segue.identifier == "Verification" {
            // Get the destination view controller
            if let destinationVC = segue.destination as? FaceVerificationViewController {
                       // Pass data to the destination view controller
                       // For example:
                destinationVC.restorationIdentifier = self.restorationIdentifier
            }
            
        }
        
   
    }
    
    @IBAction func PhotoLibraryOpen(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = .photoLibrary
           present(imagePicker, animated: true, completion: nil)
       }
       
       public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)
           
           guard let image = info[.originalImage] as? UIImage else {
               return
           }
           
           imageView.image = image
//           verifyFace(with: image)
       }
    
    /*
    
    func verifyFace(with image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        if let request = AWSRekognitionCompareFacesRequest() {
            request.sourceImage = AWSRekognitionImage()
            request.sourceImage?.bytes = imageData
            
            // Replace with the target image details (S3 bucket, object key)
            if let targetImage = AWSRekognitionImage(),
               let s3Object = AWSRekognitionS3Object() {
                targetImage.s3Object = s3Object
                s3Object.bucket = "your-s3-bucket-name"
                s3Object.name = "target-image-object-key"
                request.targetImage = targetImage
            }
            
            rekognitionClient.compareFaces(request).continueWith { (task) -> Any? in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.resultLabel.text = "Error: \(error.localizedDescription)"
                    }
                    return nil
                }
                
                if let result = task.result, let faceMatches = result.faceMatches, !faceMatches.isEmpty {
                    DispatchQueue.main.async {
                        self.resultLabel.text = "Face verified successfully!"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.resultLabel.text = "Face verification failed."
                    }
                }
                
                return nil
            }
        }
    }
     
     */
    

}
