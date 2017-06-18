//
//  GVNNewScreeningOrderBaseTableViewCell.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 26/05/17.
//

import UIKit

class GVNNewScreeningOrderBaseTableViewCell: UITableViewCell {
  
  
  // MARK:  UITableViewCell subclass GVNHomeTableViewCell widget instance veriable declaration.
  @IBOutlet weak var viewTopView: UIView!
  @IBOutlet weak var imageViewPackageOptionSelection: UIImageView!
  @IBOutlet weak var buttonPackageOptionSelection: UIButton!
  
  
  
  /*
   * Method awakeFromNib to set default property on UI widget elements.
   */
  // MARK:  awakeFromNib method.
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.viewTopView.layer.cornerRadius = CGFloat(FIVERADIUS)
    self.viewTopView.layer.masksToBounds = true
    self.viewTopView.layer.borderColor = RECENTORDERBACKGROUNDCOLOR.cgColor
    self.viewTopView.layer.borderWidth = 1.0
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
