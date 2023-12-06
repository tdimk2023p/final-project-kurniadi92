//
//  InformationViewController.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 26/11/23.
//

import UIKit

class InformationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sexSegmented: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var fluentSegmented: UISegmentedControl!
    
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.addTarget(self, action: #selector(InformationViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        check()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sexSegmented.selectedSegmentIndex = -1
        fluentSegmented.selectedSegmentIndex = -1
        ageTextField.text = ""
        check()
    }
    
    private func check() {
        startButton.isEnabled = (
            sexSegmented.selectedSegmentIndex != -1 &&
            fluentSegmented.selectedSegmentIndex != -1 &&
            (ageTextField.text ?? "").isEmpty == false
        )
    }
    
    @IBAction func sexSelectionChanged(_ sender: Any) {
        check()
    }
    
    @IBAction func qwertySelectionChanged(_ sender: Any) {
        check()
    }
    
    @IBAction func startAction(_ sender: Any) {
        TempStorage.shared.uuid = UUID().uuidString
        TempStorage.shared.age = Int(ageTextField.text!) ?? 0
        TempStorage.shared.sex = sexSegmented.selectedSegmentIndex
        TempStorage.shared.fluently = fluentSegmented.selectedSegmentIndex
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.session = .test
        vc.keyboardType = .colemak
        
        self.present(vc, animated: true)
        
        ageTextField.text = ""
        sexSegmented.selectedSegmentIndex = 0
        fluentSegmented.selectedSegmentIndex = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
