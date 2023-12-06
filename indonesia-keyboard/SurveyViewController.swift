//
//  SurveyViewController.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 1/12/23.
//

import UIKit
import FirebaseCore
import Firebase

class SurveyItem {
    var id = -1
    var title = ""
    var selectionIndex = -1
    
    init(id: Int = -1, title: String = "", selectionIndex: Int = -1) {
        self.id = id
        self.title = title
        self.selectionIndex = selectionIndex
    }
}

class SurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var surveysItem = [SurveyItem]()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        createSurvey()
        tableView.reloadData()
        checkIfAllChecked()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveysItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.set(surveyItem: surveysItem[indexPath.row])
        cell.onSelectionChanged = { [weak self] index in
            self?.surveysItem[indexPath.row].selectionIndex = index
            self?.checkIfAllChecked()
        }
        
        return cell
    }
    
    private func checkIfAllChecked() {
        let isAllChecked = surveysItem.filter { $0.selectionIndex == -1 }.isEmpty
        doneButton.isEnabled = isAllChecked
    }
    
    @IBAction func doneAction(_ sender: Any) {
        var mappedString = ""
        surveysItem.forEach { item in
            mappedString = "\(mappedString),\(item.id):\(item.selectionIndex)"
        }
        
        TempStorage.shared.surveyResult = mappedString
        loadingIndicator.isHidden = false
        doneButton.setTitle("Mengirim response / sending response", for: .normal)
        doneButton.setTitle("Mengirim response / sending response", for: .disabled)
        
        doneButton.isEnabled = false
        
        let ref = Database.database().reference()
        ref.child(TempStorage.shared.uuid).updateChildValues(TempStorage.shared.getDictionary()) { error, ref in
            if error == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DoneViewController") as! DoneViewController
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    private func createSurvey() {
        surveysItem.append(SurveyItem(id: 1, title: "Mengetik dengan keyboard 1 terasa lebih cepat / Typing with type 1 keyboard feels faster"))
        surveysItem.append(SurveyItem(id: 2, title: "Mengetik dengan keyboard 2 terasa lebih cepat / Typing with type 2 keyboard feels faster"))
        surveysItem.append(SurveyItem(id: 3, title: "Mengetik dengan keyboard 3 terasa lebih cepat / Typing with type 4 keyboard feels faster"))
        surveysItem.append(SurveyItem(id: 4, title: "Mengetik dengan keyboard 1 terasa lebih nyaman / Typing with type 1 keyboard feels more comfortable"))
        surveysItem.append(SurveyItem(id: 5, title: "Mengetik dengan keyboard 2 terasa lebih nyaman / Typing with type 2 keyboard feels more comfortable"))
        surveysItem.append(SurveyItem(id: 6, title: "Mengetik dengan keyboard 3 terasa lebih nyaman / Typing with type 3 keyboard feels more comfortable"))
        surveysItem.append(SurveyItem(id: 7, title: "Huruf konsonan mudah ditemukan di keyboard 1 / Consonant charater seasier to find in keyboard 1"))
        surveysItem.append(SurveyItem(id: 8, title: "Huruf konsonan mudah ditemukan di keyboard 2 / Consonant charater seasier to find in keyboard 2"))
        surveysItem.append(SurveyItem(id: 9, title: "Huruf konsonan mudah ditemukan di keyboard 3 / Consonant charater seasier to find in keyboard 3"))
        surveysItem.append(SurveyItem(id: 10, title: "Susunan letak Keyboard 1 membingungkan / Keyboard 1 layout confused me"))
        surveysItem.append(SurveyItem(id: 11, title: "Susunan letak Keyboard 2 membingungkan / Keyboard 2 layout confused me"))
        surveysItem.append(SurveyItem(id: 12, title: "Susunan letak Keyboard 3 membingungkan / Keyboard 3 layout confused me"))
        surveysItem.append(SurveyItem(id: 13, title: "Keyboard 1 nyaman digunakan dengan 2 tangan /Keyboard 1 comfortable to used by 2 hand"))
        surveysItem.append(SurveyItem(id: 14, title: "Keyboard 2 nyaman digunakan dengan 2 tangan /Keyboard 2 comfortable to used by 2 hand"))
        surveysItem.append(SurveyItem(id: 15, title: "Keyboard 3 nyaman digunakan dengan 2 tangan /Keyboard 3 comfortable to used by 2 hand"))
        surveysItem.append(SurveyItem(id: 16, title: "Keyboard 1 nyaman digunakan dengan 1 tangan /Keyboard 1 comfortable to used by 1 hand"))
        surveysItem.append(SurveyItem(id: 17, title: "Keyboard 2 nyaman digunakan dengan 1 tangan /Keyboard 2 comfortable to used by 1 hand"))
        surveysItem.append(SurveyItem(id: 18, title: "Keyboard 3 nyaman digunakan dengan 1 tangan /Keyboard 3 comfortable to used by 1 hand"))
    }
}
