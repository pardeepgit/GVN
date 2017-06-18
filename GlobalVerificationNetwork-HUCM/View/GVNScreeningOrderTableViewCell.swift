//
//  GVNScreeningOrderTableViewCell.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 05/06/17.
//

import UIKit


class GVNScreeningOrderTableViewCell: UITableViewCell {
  
  
  // MARK:  UITableViewCell subclass GVNHomeTableViewCell widget instance veriable declaration.
  @IBOutlet weak var imageViewOrderStatus: UIImageView!
  @IBOutlet weak var buttonOrderDate: UIButton!
  @IBOutlet weak var buttonOrderStatus: UIButton!
  @IBOutlet weak var labelApplicantName: UILabel!
  @IBOutlet weak var labelOrderId: UILabel!
  @IBOutlet weak var labelScreeningPackageType: UILabel!
  
  
  
  /*
   * Method awakeFromNib to set default property on UI widget elements.
   */
  // MARK:  awakeFromNib method.
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.buttonOrderDate.layer.cornerRadius = CGFloat(FIVERADIUS)
    self.buttonOrderStatus.layer.cornerRadius = CGFloat(FIVERADIUS)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }

}
