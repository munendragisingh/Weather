//
//  SearchCell.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var cityLbl: UILabel?
    @IBOutlet weak var countryLbl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(city: City) {
        cityLbl?.text = city.name
        countryLbl?.text = city.country
    }

}
