//
//  ViewController.swift
//  coreML_Example
//
//  Created by Jinu Kim on 21/03/2019.
//  Copyright © 2019 com.KakaoTocs.kr. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let vowels: [Character] = ["a", "e", "i", "o", "u"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let image = UIImage(named: "train_night") {
            imageView.image = image
            guard let ciimage = CIImage(image: image) else {
                fatalError("couldn't convert UIImage to CIImage")
            }
            
            detectScane(image: ciimage)
        }
    }


    @IBAction func selectImageAction(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true, completion: nil)
    }
}

extension ViewController {
    func detectScane(image: CIImage) {
        answerLabel.text = "detecting scane..."
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load Places ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            let article = (self?.vowels.contains(topResult.identifier.first!))! ? "an" : "a"
            DispatchQueue.main.async { [weak self] in
                self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("이미지를 못불러 옵니다.")
        }
        
        imageView.image = image
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("변환 실패")
        }
        
        detectScane(image: ciImage)
    }
}
