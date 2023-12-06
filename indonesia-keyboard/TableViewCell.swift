//
//  TableViewCell.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 1/12/23.
//

import UIKit



class TableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var selectionSegmented: UISegmentedControl!
    
    var onSelectionChanged: (Int) -> Void = { _ in  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func set(surveyItem: SurveyItem) {
        selectionSegmented.selectedSegmentIndex = surveyItem.selectionIndex
        descriptionLabel.text = surveyItem.title
    }
    
    @IBAction func selectionChanged(_ sender: UISegmentedControl) {
        onSelectionChanged(sender.selectedSegmentIndex)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
