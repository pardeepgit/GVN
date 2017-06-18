//
//  NavigationViewModel.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 23/05/17.
//

import Foundation
import UIKit


/*
 * NavigationViewModel class with class method declaration and defination implementaion to handle functionality of Cancel UIButton.
 */
class NavigationViewModel {

  
  // MARK:  navigateToOrderControllerFrom Current UIViewController method.
  class func navigateToOrderControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController
    let arrayOfVisibleController = navigationController.viewControllers as NSArray
    
    for index in 0..<arrayOfVisibleController.count {
      if let tabBarController = arrayOfVisibleController[index] as? UITabBarController{
        tabBarController.selectedIndex = 2
        return
      }
    }
  }
  
  
  // MARK:  popToNewScreeningRequestOrderControllerFrom Current UIViewController method.
  class func popToNewScreeningRequestOrderControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController
    let arrayOfVisibleController = navigationController.viewControllers as NSArray
    
    for index in 0..<arrayOfVisibleController.count {
      if let tabBarController = arrayOfVisibleController[index] as? UITabBarController{
        navigationController.popToViewController(tabBarController, animated: true)
        tabBarController.selectedIndex = 1
        return
      }
    }
  }
  
  // MARK:  popToHomeViewControllerFrom Current UIViewController method.
  class func popToHomeViewControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController
    let arrayOfVisibleController = navigationController.viewControllers as NSArray
    
    for index in 0..<arrayOfVisibleController.count {
      if let tabBarController = arrayOfVisibleController[index] as? UITabBarController{
        
        navigationController.popToViewController(tabBarController, animated: true)
        tabBarController.selectedIndex = 0
        return
      }
    }
  }

  

  // MARK:  navigateToApplicantInfoForSsnTraceSearchPackageControllerFrom method.
  class func navigateToApplicantInfoForSsnTraceSearchPackageControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController

    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnNewScreeningRequestApplicantInfoViewController = storyBoard.instantiateViewController(withIdentifier: GVNNEWSCREENINGREQUESTAPPLICANTINFOVIEWCONTROLLER) as! GVNNewScreeningRequestApplicantInfoViewController
    navigationController.pushViewController(gvnNewScreeningRequestApplicantInfoViewController, animated: true)
  }

  
  // MARK:  navigateToDriverSearchScreeningSearchPackageControllerFrom method.
  class func navigateToDriverSearchScreeningSearchPackageControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController

    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnNewScreeningDriverSearchViewController = storyBoard.instantiateViewController(withIdentifier: GVNNEWSCREENINGDRIVERSEARCHVIEWCONTROLLER) as! GVNNewScreeningDriverSearchViewController
    navigationController.pushViewController(gvnNewScreeningDriverSearchViewController, animated: true)
  }

  
  // MARK:  navigateToOrderSummaryControllerFrom method.
  class func navigateToOrderSummaryControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController

    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnNewScreeningOrderSummaryViewController = storyBoard.instantiateViewController(withIdentifier: GVNNEWSCREENINGORDERSUMMARYVIEWCONTROLLER) as! GVNNewScreeningOrderSummaryViewController
    navigationController.pushViewController(gvnNewScreeningOrderSummaryViewController, animated: true)
  }

  
  // MARK:  navigateToSettingViewControllerFrom method.
  class func navigateToSettingViewControllerFrom(viewController: UIViewController){
    let navigationController = viewController.navigationController! as UINavigationController
    
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnSettingViewController = storyBoard.instantiateViewController(withIdentifier: GVNSETTINGVIEWCONTROLLER) as! GVNSettingViewController
    gvnSettingViewController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(gvnSettingViewController, animated: true)
  }

  
}
