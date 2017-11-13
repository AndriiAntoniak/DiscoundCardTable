//
//  ScannerViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/9/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    var delegate : ScannerResultDelegate?
    
    
    var video = AVCaptureVideoPreviewLayer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        square.layer.borderColor = #colorLiteral(red: 0.9261991382, green: 0.01886853269, blue: 0.1136949545, alpha: 1)
        square.layer.borderWidth = 15
        
        let session = AVCaptureSession()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }catch{
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
        video = AVCaptureVideoPreviewLayer.init(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubview(toFront: square)
        session.startRunning()
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.ean13{
                    delegate?.returnStringBarcode(barcode: object.stringValue!)
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //
    
    @IBOutlet weak var square: UIView!
    //
    

    
    
}
