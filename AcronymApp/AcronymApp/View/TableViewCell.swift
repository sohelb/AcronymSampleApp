//
//  TableViewCell.swift
//  AcronymApp
//
//  Created by Sohel Bukhari on 10/17/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lfLabel: UILabel!
    
    var cellViewModel: AcronymCellViewModel? {
        didSet {
            lfLabel.text = cellViewModel?.longForm
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lfLabel.text = nil
    }
}
