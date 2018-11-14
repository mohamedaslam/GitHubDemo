//
//  ViewController.swift
//  BarcodePOC
//
//  Created by Mohammed Aslam on 02/07/18.
//  Copyright © 2018 Oottru. All rights reserved.
//

import UIKit
import AVFoundation
import ZXingObjC

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //ImageView
    @IBOutlet weak var imgView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        //Testting code added
        //Test GIt 1
        //TEST GIT2 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanCode(sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let placeHolderImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.contentMode = .scaleAspectFit
        imgView.image  = placeHolderImage
        dismiss(animated: true, completion: nil)
        
        let luminanceSource: ZXLuminanceSource = ZXCGImageLuminanceSource(cgImage: placeHolderImage.cgImage)
        let binarizer = ZXHybridBinarizer(source: luminanceSource)
        let bitmap = ZXBinaryBitmap(binarizer: binarizer)
        let hints: ZXDecodeHints = ZXDecodeHints.hints() as! ZXDecodeHints
        let QRReader = ZXMultiFormatReader()
        
        do {
            let result = try QRReader.decode(bitmap, hints: hints)
            let alertController = UIAlertController(title: title, message: "A barcode  \(result.text!) in this image", preferredStyle:UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            { action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
            
        } catch let err as NSError {
            print(err)
            let alertController = UIAlertController(title: title, message: "A barcode Not found in this image", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            { action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
 
