//
//  InformationViewController.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 26/11/23.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var sexSegmented: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var fluentSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        vc.keyboardType = .qwerty
        
        self.present(vc, animated: true)
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
