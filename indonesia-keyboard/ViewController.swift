//
//  ViewController.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 25/11/23.
//

import UIKit
import FirebaseCore
import Firebase

class ViewController: UIViewController {
    enum SessionType {
       case training
       case test
    }
    
    enum KeyboardType {
       case proposed
       case qwerty
       case colemak
    }
    
    private let testText = "sy_mw_k_kntr_km_mngtrkn_brks"
    private let trainText = "Nnt_sy_mmpr_k_tmpt_ftkp"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typedLabel: UILabel!
    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stavkView: UIStackView!
    
    private var typeDictionary = ""
    private var start: Double = 0
    private var ended: Double = 0
    private var correction = 0
    
    var session: SessionType = .test
    var keyboardType: KeyboardType = .proposed
    @IBOutlet weak var mainLabel: UILabel!
    
    private var finalTyped: String {
        return typedLabel.text ?? ""
    }
    
    private var objectTyped: String {
        return mainLabel.text ?? ""
    }
    
    private var colemak = [
        ["Q","W","F","P","G","J","L","U","Y"],
          ["A","R","S","T","D","H","N","E","I","O"],
            ["Z","X","C","V","B","K","M","<-"]
    ]
    
    private var dvorak = [
        ["P","Y","F","G","C","R","L"],
          ["A","E","O","U","I","D","H","T","N","S"],
            ["Q","J","K","X","B","M","W","V","Z","<-"]
    ]
    
    private var qwerty = [
        ["Q","W","E","R","T","Y","U","I","O","P"],
          ["A","S","D","F","G","H","J","K","L"],
            ["Z","X","C","V","B","N","M","<-"]
    ]
    
    private var proposed = [
        ["A","I","Z","Y","S","R","L","C","X","E"],
          ["U","V","H","T","N","M","B","J","O"],
            ["F","D","G","K","P","W","Q","<-"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if session == .test {
            titleLabel.text = "Ujian / Test"
        } else {
            titleLabel.text = "Latihan / Training"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if session == .test {
            mainLabel.text = testText.uppercased()
//        } else {
//            mainLabel.text = trainText.uppercased()
//        }
        if keyboardType == .qwerty {
            createKeyboard(layout: qwerty)
        } else if keyboardType == .colemak {
            createKeyboard(layout: colemak)
        } else {
            createKeyboard(layout: proposed)
        }
        start = Date().timeIntervalSince1970
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func createKeyboard(layout: [[String]]) {
        let size = (stavkView.frame.width / 10)
        keyboardHeightConstraint.constant = size * 4
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        layout.forEach { row in
            let view = UIView(frame: CGRect(x: 0, y: 0, width: stavkView.frame.width, height: size))
            let innerStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: CGFloat(row.count) * size, height: size))
            innerStackView.axis = .horizontal
            innerStackView.distribution = .fillEqually
            innerStackView.spacing = 2
            row.forEach { text in
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
                button.setTitle(text, for: .normal)
                button.layer.borderColor = UIColor.gray.cgColor
                button.layer.borderWidth = 0.3
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
                innerStackView.addArrangedSubview(button)
                if text == "-" {
                    button.isEnabled = false
                    button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                    button.alpha = 0.2
                }
                
                if text == "<-" {
                    button.backgroundColor = .systemPink
                }
            }
            innerStackView.center = view.center
            view.addSubview(innerStackView)
            stavkView.addArrangedSubview(view)
        }
        
        let space = UIButton(frame: CGRect(x: 0, y: 0, width: stavkView.frame.width, height: size))
        space.setTitle("_", for: .normal)
        space.layer.borderColor = UIColor.gray.cgColor
        space.layer.borderWidth = 0.3
        space.setTitleColor(.black, for: .normal)
        space.addTarget(self, action: #selector(space(sender:)), for: .touchUpInside)
        
        stavkView.addArrangedSubview(space)
    }
    
    @objc func space(sender: UIButton) {
        if let currentText = typedLabel.text {
            typedLabel.text = "\(currentText)_"
            typeDictionary = "\(typeDictionary),_ : \(Date().timeIntervalSince1970)"
        }
        check()
    }
    
    @objc func tap(sender: UIButton) {
        if let text = sender.titleLabel?.text {
            if text == "<-" {
                sender.backgroundColor = .red
                var text = typedLabel.text ?? ""
                if !text.isEmpty {
                    text.removeLast()
                    typedLabel.text = text
                }
                correction += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    sender.backgroundColor = .systemPink
                }
                typeDictionary = "\(typeDictionary),<- : \(Date().timeIntervalSince1970)"
            } else {
                sender.backgroundColor = .lightGray
                if let currentText = typedLabel.text {
                    typedLabel.text = "\(currentText)\(text)"
                    typeDictionary = "\(typeDictionary),\(text) : \(Date().timeIntervalSince1970)"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    sender.backgroundColor = .clear
                }
            }
        }
        check()
    }
    
    private func check() {
        var nextSession = session
        var nextKeyboardType = keyboardType
        
        if mainLabel.text == typedLabel.text {
            ended = Date().timeIntervalSince1970
//            if session == .test {
                if keyboardType == .qwerty {
                    TempStorage.shared.qwertyTracked = "\(typeDictionary)#\(start) - \(ended)#\(correction)"
                } else if keyboardType == .proposed {
                    TempStorage.shared.proposedTracked = "\(typeDictionary)#\(start) - \(ended)#\(correction)"
                } else if keyboardType == .colemak {
                    TempStorage.shared.colemakTracked = "\(typeDictionary)#\(start) - \(ended)#\(correction)"
                }
//            }
            
            if keyboardType == .proposed {
                let ref = Database.database().reference()
                ref.child(TempStorage.shared.uuid).updateChildValues(TempStorage.shared.getDictionary()) { error, ref in
                    if error == nil {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "DoneViewController") as! DoneViewController
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    }
                }
            } else {
//                if session == .test {
//                    nextSession = .training
//                    if keyboardType == .qwerty {
//                        nextKeyboardType = .proposed
//                    } else {
//                        nextKeyboardType = .qwerty
//                    }
//                    
//                } else {
//                    nextSession = .test
//                }
                if keyboardType == .qwerty {
                    nextKeyboardType = .colemak
                } else if keyboardType == .colemak {
                    nextKeyboardType = .proposed
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                vc.modalPresentationStyle = .overFullScreen
                vc.session = nextSession
                vc.keyboardType = nextKeyboardType
                
                self.present(vc, animated: true)
            }
        }
    }

    private func checkKBBI() {
        if let path = Bundle.main.path(forResource: "dataKBBI", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8).lowercased()
                let splittedText = text.components(separatedBy: ",")
                print(">>> total words = \(splittedText.count)")
                let nonCommaString = text.replacingOccurrences(of: ",", with: "")
                let removedA = nonCommaString.replacingOccurrences(of: "a", with: "")
                let removedI = removedA.replacingOccurrences(of: "i", with: "")
                let removedU = removedI.replacingOccurrences(of: "u", with: "")
                let removedE = removedU.replacingOccurrences(of: "e", with: "")
                let removedO = removedE.replacingOccurrences(of: "o", with: "")
                let characters = Array(removedO)
                print(">>> total character without vocal \(characters.count) ")
                let consonant = ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"]
                var characterDictionary = [String: Int]()
                consonant.forEach { text in
                    let countItem = characters.filter { character in
                        return String(character) == text
                    }.count
                    characterDictionary[text] = countItem
                }
                
                let sortedCharacterUsage = characterDictionary.sorted { $0.value > $1.value }
                sortedCharacterUsage.forEach { char in
                    print(">>> \(char)")
                }
                print(sortedCharacterUsage)
                
            } catch let error {
                print(">>> error \(error.localizedDescription)")
                // Handle error here
            }
        }
    }

}

