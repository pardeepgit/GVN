//
//  GVNNewScreeningOrderSummaryTableViewCell.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 24/05/17.
//

import UIKit

class GVNNewScreeningOrderSummaryTableViewCell: UITableViewCell {
  
  
  // MARK:  UITableViewCell subclass GVNNewScreeningCountyCriminalTableViewCell widget instance veriable declaration.
  @IBOutlet weak var labelSearchSummaryAction: UILabel!
  @IBOutlet weak var labelFee: UILabel!

  
  /*
   * Method awakeFromNib to set default property on UI widget elements.
   */
  // MARK:  awakeFromNib method.
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
