//
//  ScheduleCell.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 14/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    
    @IBOutlet weak var scheduleNameLabel: UILabel!
    @IBOutlet weak var beginTimeScheduleLabel: UILabel!
    @IBOutlet weak var endTimeScheduleLabel: UILabel!
    @IBOutlet weak var numAuditoriumScheduleLabel: UILabel!
    @IBOutlet weak var buildingNameScheduleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
