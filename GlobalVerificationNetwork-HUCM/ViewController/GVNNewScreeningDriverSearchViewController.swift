//
//  GVNNewScreeningDriverSearchViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 24/05/17.
//

import UIKit


class GVNNewScreeningDriverSearchViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  
  @IBOutlet weak var textFieldLicenseState: UITextField!
  @IBOutlet weak var textFieldLicenseDuration: UITextField!
  @IBOutlet weak var textFieldLicenseNumber: UITextField!
  
  @IBOutlet weak var viewChooseDriverLicensePickerView: UIView!
  @IBOutlet weak var choosePickerViewOfDriverLicense: UIPickerView!
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var dimView = UIView()
  var arrayOfLicenseStates = [String]()
  var arrayOfLicenseDuration = [String]()
  var flagFalseForStateAndTrueForDuration = false
  
  
  /*
   * UIViewController class life cycle overrided method to handle viewController functionality on the basis of the state of method in application.
   * E.g viewDidLoad method to iniailize all the component before appear screem. viewWillAppear method to show loadder or UI related task.
   */
  // MARK:  UIViewController class overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // self.addDriverSearchFormStaticData()
    
    self.preparedScreenDesign()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.loadScreenData()
  }
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    
    self.viewChooseDriverLicensePickerView.layer.cornerRadius = 5.0
    self.viewChooseDriverLicensePickerView.layer.masksToBounds = true
    self.viewChooseDriverLicensePickerView.isHidden = true
    
    // Add a custom toolBar to Mobile and Home phone number textfield for the Done BatButtonItem.
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = BUTTONTITLECOLOR
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(GVNNewScreeningDriverSearchViewController.numberKeyboardDonePressed))
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    textFieldLicenseDuration.inputAccessoryView = toolBar
    textFieldLicenseNumber.inputAccessoryView = toolBar
    
    textFieldLicenseState.text = "AL"
    textFieldLicenseDuration.text = "7"
    textFieldLicenseNumber.text = "145879632"
    
    // Code to Show Choose Date Picker View.
    self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: false)
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
    // Code for States and Duration initialization.
    arrayOfLicenseStates = arrayOfStates
    for duration in 1...30{
      arrayOfLicenseDuration.append(String(format: "%d", duration))
    }
  }
  
  // MARK:  numberKeyboardDonePressed method.
  func numberKeyboardDonePressed(){
    
    // Code to hide the number keyboard.
    view.endEditing(true)
  }
  
  // MARK:  addFormStaticData method.
  func addDriverSearchFormStaticData() {
    // Code to add static data.
    textFieldLicenseState.text = "FL"
    textFieldLicenseDuration.text = "7"
    textFieldLicenseNumber.text = "123-52H-11T"
  }
  
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonSettingsTapped method.
  @IBAction func buttonSettingsTapped(sender: UIButton){
    // Code to navigate to Setting ViewController from current fron viewController.
    NavigationViewModel.navigateToSettingViewControllerFrom(viewController: self)
  }
  
  // MARK:  buttonSaveDraftTapped method.
  @IBAction func buttonSaveDraftTapped(sender: UIButton){
    
    if self.isDriverSearchFormValid(){
      // Code to prepare DriverInfo model class from DriverInfo form fields.
      self.prepareDriverInfoModel()
      
      
      let saveDraftOrderFlag = CoreDataManager.sharedInstance.saveDraftOrderFor(screeningOrder: ScreeningRequest.sharedInstance)
      if saveDraftOrderFlag == true{
      }
      else{
      }
      
      DispatchQueue.main.async {
        ScreeningRequest.sharedInstance.isScreeningRequestInProcess = false
        
        // Code to call buttonCancelTapped method to dismiss to pop to New Screening Order Controller.
        self.buttonCancelTapped(sender: UIButton())
      }
      
    }
  }
  
  // MARK:  buttonNextStepTapped method.
  @IBAction func buttonNextStepTapped(sender: UIButton){
    
    if self.isDriverSearchFormValid(){
      // Code to prepare DriverInfo model class from DriverInfo form fields.
      self.prepareDriverInfoModel()
      
      NavigationViewModel.navigateToOrderSummaryControllerFrom(viewController: self)
    }
  }
  
  // MARK:  buttonCancelTapped method.
  @IBAction func buttonCancelTapped(sender: UIButton){
    ScreeningRequest.sharedInstance.isScreeningRequestInProcess = false
    
    // Code pop to new screening request TabBar Controller when cancel from current new screening request.
    NavigationViewModel.popToNewScreeningRequestOrderControllerFrom(viewController: self)
  }
  
  // MARK:  buttonChooseDobDatePickerViewAddOrCancellButtonTapped method.
  @IBAction func buttonChooseDobDatePickerViewAddOrCancellButtonTapped(sender: UIButton){
    let tagIndex = sender.tag
    
    switch tagIndex {
    case 1001: // When User click on Choose
      if flagFalseForStateAndTrueForDuration == true{ // True for Duration
        let pickerValueIndex = choosePickerViewOfDriverLicense.selectedRow(inComponent: 0)
        let duration = arrayOfLicenseDuration[pickerValueIndex] as String
        textFieldLicenseDuration.text = String(format: "%@ Month", duration)
      }
      else{ // False for State
        let pickerValueIndex = choosePickerViewOfDriverLicense.selectedRow(inComponent: 0)
        let state = arrayOfLicenseStates[pickerValueIndex] as String
        textFieldLicenseState.text = state
      }
      break
      
    case 1002: // When Cancel to hide DatPickerView.
      break
      
    default:
      print("default")
    }
    
    // Code to Show Choose Date Picker View.
    self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: false)
  }
  
  // MARK:  showOrHideChooseDatePickerViewByShowBoolean method.
  func showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: Bool) {
    if isShowFlag == true{ // Show Choose County view.
      dimView = UIView()
      dimView.frame = self.view.frame
      dimView.backgroundColor = BLACKCOLOR
      dimView.alpha = 0.0
      self.view.addSubview(dimView)
      
      self.view.bringSubview(toFront: self.viewChooseDriverLicensePickerView)
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0.6
      }, completion: { finished in
        self.viewChooseDriverLicensePickerView.isHidden = false
      })
    }
    else{ // Hide Choose County view.
      self.viewChooseDriverLicensePickerView.isHidden = true
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0.0
      }, completion: { finished in
        self.dimView.removeFromSuperview()
      })
    }
  }
  
  
  
  
  
  
  
  
  
  
  // MARK:  ---------- Helper methods.
  
  // MARK:  isApplicantInfoFormValid method.
  func isDriverSearchFormValid() -> Bool {
    var message = ""
    
    if textFieldLicenseState.text?.characters.count == 0{
      message = NSLocalizedString("LICENSESTATE_VALIDATION", comment: "")
    }
    else if textFieldLicenseDuration.text?.characters.count == 0{
      message = NSLocalizedString("LICENSEDURATION_VALIDATION", comment: "")
    }
    else if textFieldLicenseNumber.text?.characters.count == 0{
      message = NSLocalizedString("LICENSENUMBER_VALIDATION", comment: "")
    }
    
    if message.characters.count == 0{
      return true
    }
    else{
      self.showAlertWith(message: message)
      return false
    }
  }
  
  
  // MARK:  prepareDriverInfoModel method.
  func prepareDriverInfoModel() {
    let driverInfoModel = DriverInfo()
    
    driverInfoModel.licenseState = textFieldLicenseState.text
    driverInfoModel.licenseNumber = textFieldLicenseNumber.text
    
    ScreeningRequest.sharedInstance.driverInfo = driverInfoModel
  }
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


/*
 * Extension of GVNNewScreeningDriverSearchViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNNewScreeningDriverSearchViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNNewScreeningDriverSearchViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 0: // For License Type
      textFieldLicenseState.becomeFirstResponder()
      break
      
    case 1: // For License State
      textFieldLicenseNumber.becomeFirstResponder()
      break
      
    case 2: // For License Number
      textFieldLicenseNumber.resignFirstResponder()
      break
      
    default:
      print("default")
    }
    
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == textFieldLicenseState{
      // Code to hide the keyboard.
      view.endEditing(true)
      
      flagFalseForStateAndTrueForDuration = false
      if textFieldLicenseState.text?.characters.count != 0{
        let licenseState = textFieldLicenseState.text
        var rowIndex = 0
        
        for index in 0..<arrayOfLicenseStates.count{
          let state = arrayOfLicenseStates[index]
          if state == licenseState{
            rowIndex = index
            break
          }
        }
        
        choosePickerViewOfDriverLicense.reloadAllComponents()
        choosePickerViewOfDriverLicense.selectRow(rowIndex, inComponent: 0, animated: true)
      }
      else{
        choosePickerViewOfDriverLicense.reloadAllComponents()
        choosePickerViewOfDriverLicense.selectRow(0, inComponent: 0, animated: true)
      }
      
      // Code to Show Choose Date Picker View.
      self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: true)
      return false
    }
    else if textField == textFieldLicenseDuration{
      /*
       // Code to hide the keyboard.
       view.endEditing(true)
       
       flagFalseForStateAndTrueForDuration = true
       if textFieldLicenseDuration.text?.characters.count != 0{
       let licenseDuration = textFieldLicenseDuration.text
       var rowIndex = 0
       
       for index in 0..<arrayOfLicenseDuration.count{
       let duration = arrayOfLicenseDuration[index]
       if duration == licenseDuration{
       rowIndex = index
       break
       }
       }
       
       choosePickerViewOfDriverLicense.reloadAllComponents()
       choosePickerViewOfDriverLicense.selectRow(rowIndex, inComponent: 0, animated: true)
       }
       else{
       choosePickerViewOfDriverLicense.reloadAllComponents()
       choosePickerViewOfDriverLicense.selectRow(0, inComponent: 0, animated: true)
       }
       
       // Code to Show Choose Date Picker View.
       self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: true)
       */
      return true
    }
    else{
      return true
    }
  }
  
}


/*
 * Extension of GVNNewScreeningDriverSearchViewController to add UIPickerView prototcol UIPickerViewDataSource and UIPickerViewDelegate.
 * Override the protocol method to add pickerView in GVNNewScreeningDriverSearchViewController.
 */
// MARK:  Extension of GVNNewScreeningDriverSearchViewController by UIPickerView DataSource & Delegates method.
extension GVNNewScreeningDriverSearchViewController: UIPickerViewDataSource, UIPickerViewDelegate{
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if flagFalseForStateAndTrueForDuration == true{
      return arrayOfLicenseDuration.count;
    }
    else{
      return arrayOfLicenseStates.count;
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if flagFalseForStateAndTrueForDuration == true{
      let duration = arrayOfLicenseDuration[row]
      let rowValue = String(format: "%@ Month", duration)
      return rowValue
    }
    else{
      let rowValue = arrayOfLicenseStates[row]
      return rowValue
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
  }
  
}

