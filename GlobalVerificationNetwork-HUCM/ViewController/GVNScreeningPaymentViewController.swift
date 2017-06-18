//
//  GVNScreeningPaymentViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 12/06/17.
//

import UIKit

class GVNScreeningPaymentViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  @IBOutlet weak var scrollViewApplicantInfoForm: UIScrollView!
  
  @IBOutlet weak var textFieldAmount: UITextField!
  @IBOutlet weak var textFieldCardName: UITextField!
  @IBOutlet weak var textFieldCardNumber: UITextField!
  @IBOutlet weak var textFieldCardCvv: UITextField!
  @IBOutlet weak var textFieldExpiryMonth: UITextField!
  @IBOutlet weak var textFieldExpiryYear: UITextField!
  
  @IBOutlet weak var viewChooseExpiryMonthYear: UIView!
  @IBOutlet weak var pickerViewOfMonthYear: UIPickerView!

  

  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var dimView = UIView()
  var arrayOfExpiryMonth = [String]()
  var arrayOfExpiryYear = [String]()
  var flagFalseForMonthAndTrueForYear = false

  
  /*
   * UIViewController class life cycle overrided method to handle viewController functionality on the basis of the state of method in application.
   * E.g viewDidLoad method to iniailize all the component before appear screem. viewWillAppear method to show loadder or UI related task.
   */
  // MARK:  UIViewController class overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.preparedScreenDesign()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.loadScreenData()
  }
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.viewChooseExpiryMonthYear.layer.cornerRadius = 5.0
    self.viewChooseExpiryMonthYear.layer.masksToBounds = true
    self.viewChooseExpiryMonthYear.isHidden = true

    
    
    // Add a custom toolBar to Mobile and Home phone number textfield for the Done BatButtonItem.
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = BUTTONTITLECOLOR
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(GVNScreeningPaymentViewController.numberKeyboardDonePressed))
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    
    textFieldCardNumber.inputAccessoryView = toolBar
    textFieldCardCvv.inputAccessoryView = toolBar
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    arrayOfExpiryMonth = arrayOfMonth
    arrayOfExpiryYear = UtilManager.sharedInstance.getArrayOfExpiryYearFromCurrentYear()
    
    // Code to Screening service choosed packages total amount.
    textFieldAmount.text = self.getScreeningPaymentAmount()
    
  }
  
  
  
  
  // MARK:  numberKeyboardDonePressed method.
  func numberKeyboardDonePressed(){
    
    // Code to hide the number keyboard.
    view.endEditing(true)
  }

  
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.dismiss(animated: true, completion: {
    })
  }

  // MARK:  buttonChooseExpiryMonthYearPickerViewAddOrCancellButtonTapped method.
  @IBAction func buttonChooseExpiryMonthYearPickerViewAddOrCancellButtonTapped(sender: UIButton){
    let tagIndex = sender.tag

    switch tagIndex {
    case 1001: // When User click on Choose
      if flagFalseForMonthAndTrueForYear == true{ // True for Duration
        let pickerValueIndex = pickerViewOfMonthYear.selectedRow(inComponent: 0)
        let year = arrayOfExpiryYear[pickerValueIndex] as String
        textFieldExpiryYear.text = year
      }
      else{ // False for State
        let pickerValueIndex = pickerViewOfMonthYear.selectedRow(inComponent: 0)
        let  month = arrayOfExpiryMonth[pickerValueIndex] as String
        textFieldExpiryMonth.text = UtilManager.sharedInstance.getMonthNumberFromMonthName(month: month)
      }
      break
      
    case 1002: // When Cancel to hide DatPickerView.
      
      break
      
    default:
      print("default")
    }
    // Code to Hide Expiry Month and Year Picker View.
    self.showOrHideChooseExpiryMonthYearPickerViewByShowBoolean(isShowFlag: false)
  }
  

  
  
  
  // MARK:  showOrHideChooseExpiryMonthYearPickerViewByShowBoolean method.
  func showOrHideChooseExpiryMonthYearPickerViewByShowBoolean(isShowFlag: Bool) {
    if isShowFlag == true{ // Show Picker View.
      dimView = UIView()
      dimView.frame = self.view.frame
      dimView.backgroundColor = BLACKCOLOR
      dimView.alpha = 0.0
      
      self.view.addSubview(dimView)
      self.view.bringSubview(toFront: self.viewChooseExpiryMonthYear)
      
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0.6
        self.viewChooseExpiryMonthYear.isHidden = false
      }, completion: { finished in
      })
    }
    else{ // Hide Choose County view.
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.viewChooseExpiryMonthYear.isHidden = true
        self.dimView.alpha = 0.0
        
      }, completion: { finished in
        self.dimView.removeFromSuperview()
      })
    }
  }
  
  
  func getScreeningPaymentAmount() -> String {
    var amount = ""
    var amountValue = 0.0
    
    let screeningPackageType: ScreeningSearchPackagesType = ScreeningRequest.sharedInstance.screeningPackageType!
    switch screeningPackageType {
    case ScreeningSearchPackagesType.Bronze:
      amountValue = 19.95
      
    case ScreeningSearchPackagesType.Silver:
      amountValue = 34.95
      
    case ScreeningSearchPackagesType.Gold:
      amountValue = 49.95
      
    case ScreeningSearchPackagesType.None:
      amountValue = 0
    }

    let verificationServiceFlag: Bool = ScreeningRequest.sharedInstance.verificationServiceFlag!
    if verificationServiceFlag == true{
      amountValue = amountValue + 15.0
    }
    
    amount = String(format: "$%.2f", amountValue)
    return amount
  }
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


/*
 * Extension of GVNScreeningPaymentViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNScreeningPaymentViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNScreeningPaymentViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 201: // For Card Name
      textFieldCardName.resignFirstResponder()
      break
      
    default:
      print("default")
    }
    
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 101: // For Amount
      return false

    case 201: // For Card Name
      return true
      
    case 501: // For Card Expiry Month
      // Code to hide the keyboard.
      view.endEditing(true)
      
      flagFalseForMonthAndTrueForYear = false
      if textFieldExpiryMonth.text?.characters.count != 0{
        let  month = textFieldExpiryMonth.text
        let rowIndex = Int(month!)! - 1
        
        pickerViewOfMonthYear.reloadAllComponents()
        pickerViewOfMonthYear.selectRow(rowIndex, inComponent: 0, animated: true)
      }
      else{
        pickerViewOfMonthYear.reloadAllComponents()
        pickerViewOfMonthYear.selectRow(0, inComponent: 0, animated: true)
      }

      
      
      self.showOrHideChooseExpiryMonthYearPickerViewByShowBoolean(isShowFlag: true)
      return false

    case 601: // For Card Expiry Year
      view.endEditing(true)
      
      flagFalseForMonthAndTrueForYear = true
      if textFieldExpiryYear.text?.characters.count != 0{
        let  year = textFieldExpiryYear.text
        let rowIndex = arrayOfExpiryYear.index(of: year!)
        
        pickerViewOfMonthYear.reloadAllComponents()
        pickerViewOfMonthYear.selectRow(rowIndex!, inComponent: 0, animated: true)
      }
      else{
        pickerViewOfMonthYear.reloadAllComponents()
        pickerViewOfMonthYear.selectRow(0, inComponent: 0, animated: true)
      }

      
      
      self.showOrHideChooseExpiryMonthYearPickerViewByShowBoolean(isShowFlag: true)
      return false
      
    default:
      print("default")
    }

    return true
  }
  
}

/*
 * Extension of GVNScreeningPaymentViewController to add UIPickerView prototcol UIPickerViewDataSource and UIPickerViewDelegate.
 * Override the protocol method to add pickerView in GVNNewScreeningDriverSearchViewController.
 */
// MARK:  Extension of GVNScreeningPaymentViewController by UIPickerView DataSource & Delegates method.
extension GVNScreeningPaymentViewController: UIPickerViewDataSource, UIPickerViewDelegate{
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if flagFalseForMonthAndTrueForYear == true{
      return arrayOfExpiryYear.count;
    }
    else{
      return arrayOfExpiryMonth.count;
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if flagFalseForMonthAndTrueForYear == true{
      let expiryYear = arrayOfExpiryYear[row]
      return expiryYear
    }
    else{
      let expiryMonth = arrayOfExpiryMonth[row]
      return expiryMonth
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
  }
  
}


