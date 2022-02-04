//
//  QRCodeViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 04/02/2022.
//

import UIKit


class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    var urlQRCode = URL(string: "")
    var img = ""
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //navbar
        self.title = "QR Code"
        
        
        let imageQR = generateQRCode(from: "\(urlQRCode)")
        imgQRCode.image = imageQR
        
        
        //botao "scan" redondo
        btnScan.layer.cornerRadius = 5
        btnScan.layer.borderWidth = 1
        btnScan.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    
    //qr code
    func generateQRCode(from string: String) -> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            filter.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    
    //click button "scan"
    @IBAction func onTappedScan(_ sender: Any) {
                
        if let sqc = storyboard?.instantiateViewController(identifier: "ScanQRCodeStoryboard") as? ScanQRCodeViewController {
            
            self.navigationController?.pushViewController(sqc, animated: true)
        }
    }
}
