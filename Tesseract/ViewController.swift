//
//  ViewController.swift
//  Tesseract
//
//  Created by Andre Guerra on 06/10/17.
//  Copyright © 2017 Andre Guerra. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tesseract = G8Tesseract(language: "eng") else {return}
        tesseract.delegate = self
        tesseract.image = UIImage(named: "sample1.jpg")
        tesseract.recognize()
        print(tesseract.recognizedText)
    }

    func shouldCancelImageRecognition(for tesseract: G8Tesseract!) -> Bool {
        return false
    }
}

