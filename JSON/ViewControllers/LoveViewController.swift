//
//  LoveViewController.swift
//  JSON
//
//  Created by Eugenie Tyan on 01.09.2022.
//

import UIKit

class LoveViewController: UIViewController {
    
    @IBOutlet var fnameTF: UITextField!
    @IBOutlet var snameTF: UITextField!
    @IBOutlet var labelPercentage: UILabel!
    @IBOutlet var labelDescription: UILabel!
    
    private let apiUrl = "https://love-calculator.p.rapidapi.com/getPercentage?"
    private var urlLove = ""
    
    @IBAction func buttonCountLovePercentagePressed() {
        makeUrlWithParams()
        fetchRequest(with: false)
    }
}

extension LoveViewController {
    private func emptyTextFieldsAlert() {
        let alert = UIAlertController(
            title: "Fill text fields",
            message: "Enter both names",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func makeUrlWithParams() {
        if fnameTF.text!.isEmpty || snameTF.text!.isEmpty {
            emptyTextFieldsAlert()
        } else {
            urlLove = "\(apiUrl)sname=\(snameTF.text ?? "Yana")&fname=\(fnameTF.text ?? "Eugene")"
        }
    }
    
    private func fetchRequest(with decoder: Bool = true) {
        if decoder {
            NetworkManager.shared.fetchRequest(string: urlLove, completion: {
                results in
                switch results {
                case .success(let loveCalculation):
                    self.labelPercentage.text = loveCalculation.percentage
                    self.labelDescription.text = loveCalculation.result
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        } else {
            NetworkManager.shared.fetchRequestWithoutDecoder(string: urlLove) { result in
                switch result {
                case .success(let loveCalculation):
                    self.labelPercentage.text = loveCalculation.percentage
                    self.labelDescription.text = loveCalculation.result
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
