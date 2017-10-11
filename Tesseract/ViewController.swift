//
//  ViewController.swift
//  Tesseract
//
//  Created by Andre Guerra on 06/10/17.
//  Copyright © 2017 Andre Guerra. All rights reserved.
//

import UIKit
import TesseractOCR
import AVFoundation

class ViewController: UIViewController, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVSpeechSynthesizerDelegate  {

    var tesseract = G8Tesseract(language: "eng")!
    let picker = UIImagePickerController()
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet var triggerCameraGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tesseract.delegate = self
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraDevice = .rear
        triggerCameraGesture.numberOfTapsRequired = 2
        triggerCameraGesture.numberOfTouchesRequired = 1
    }

    @IBAction func triggerCameraDetected(_ sender: UITapGestureRecognizer) {
        self.present(picker, animated: true, completion: nil)
    }
    
    
    
    func shouldCancelImageRecognition(for tesseract: G8Tesseract!) -> Bool {
        return false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.tesseract.image = image
            self.tesseract.recognize()
            print(self.tesseract.recognizedText)
            let utter = AVSpeechUtterance(string: self.tesseract.recognizedText)
            self.synthesizer.speak(utter)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Finished uttering sentences.")
    }
}

