//
//  CoreDataManager.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 02/06/17.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

  
  /*
   * Method to design Singleton design pattern for CoreDataManager class.
   * Create singleton instance by global and constant variable declaration.
   */
  class var sharedInstance: CoreDataManager {
    struct Singleton {
      static let instance = CoreDataManager()
    }
    return Singleton.instance
  }
  
  
  // MARK:  default initializer.
  private override init() {
    super.init()
    // Code to force non-instantiate from outside class
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "GlobalVerificationNetwork_HUCM")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  
  
  
  // MARK:  saveNewScreeningRecordFor Method.
  func saveNewScreeningRecordFor(response: String, andWithRequest requestXml: String, andDate date: String, andTime time: String,
                                 andFee fee: String, andPackageType type: String) -> Bool {
    var saveFlag = false
    let entityDescription = NSEntityDescription.entity(forEntityName: "ScreeningOrder", in: self.persistentContainer.viewContext)
    let newScreeningOrder = ScreeningOrder(entity: entityDescription!, insertInto: self.persistentContainer.viewContext)
    newScreeningOrder.packagetype = type
    newScreeningOrder.fee = fee
    newScreeningOrder.orderdate = date
    newScreeningOrder.ordertime = time
    newScreeningOrder.xmlrequest = requestXml
    newScreeningOrder.xmlresponse = response

    do {
      try newScreeningOrder.managedObjectContext?.save()
      self.saveContext()
      saveFlag = true
    }
    catch {
      saveFlag = false
    }
    
    return saveFlag
  }
 
  
  // MARK:  fetchRecentScreeningOrderFromLocalDB Method.
  func fetchRecentScreeningOrderFromLocalDB() -> [ScreeningOrder]{
    var arrayOfScreeningOrder = [ScreeningOrder]()
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "ScreeningOrder", in: self.persistentContainer.viewContext)

    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<ScreeningOrder> = ScreeningOrder.fetchRequest()

    // Configure Fetch Request
    fetchRequest.entity = entityDescription
    fetchRequest.fetchLimit = 5
    
    do {
      let result = try self.persistentContainer.viewContext.fetch(fetchRequest)
      arrayOfScreeningOrder = result
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
    
    return arrayOfScreeningOrder
  }
  
  // MARK:  fetchAllScreeningOrderFromLocalDB Method.
  func fetchAllScreeningOrderFromLocalDB() -> [ScreeningOrder]{
    var arrayOfScreeningOrder = [ScreeningOrder]()
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "ScreeningOrder", in: self.persistentContainer.viewContext)
    
    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<ScreeningOrder> = ScreeningOrder.fetchRequest()
    
    // Configure Fetch Request
    fetchRequest.entity = entityDescription
    
    do {
      let result = try self.persistentContainer.viewContext.fetch(fetchRequest)
      arrayOfScreeningOrder = result
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
    
    return arrayOfScreeningOrder
  }
  
  
  
  
  // MARK:  saveDraftOrderFor ScreeningRequest Method.
  func saveDraftOrderFor(screeningOrder: ScreeningRequest) -> Bool {
    var saveDraftFlag = false
    
    let driverEntityDescription = NSEntityDescription.entity(forEntityName: "DriverDetail", in: self.persistentContainer.viewContext)
    let driverDetail = DriverDetail(entity: driverEntityDescription!, insertInto: self.persistentContainer.viewContext)
    driverDetail.licensestate = screeningOrder.driverInfo?.licenseState
    driverDetail.licenseduration = screeningOrder.driverInfo?.licenseDuration
    driverDetail.licensenumber = screeningOrder.driverInfo?.licenseNumber

    let applicantEntityDescription = NSEntityDescription.entity(forEntityName: "ApplicantDetail", in: self.persistentContainer.viewContext)
    let applicantDetail = ApplicantDetail(entity: applicantEntityDescription!, insertInto: self.persistentContainer.viewContext)
    applicantDetail.firstname = screeningOrder.applicantInfo?.firstName
    applicantDetail.middlename = screeningOrder.applicantInfo?.middleName
    applicantDetail.lastname = screeningOrder.applicantInfo?.lastName
    applicantDetail.ssn = screeningOrder.applicantInfo?.ssnNumber
    applicantDetail.dob = screeningOrder.applicantInfo?.dob
    applicantDetail.email = screeningOrder.applicantInfo?.email
    applicantDetail.address = screeningOrder.applicantInfo?.address
    applicantDetail.postalcode = screeningOrder.applicantInfo?.postalCode
    applicantDetail.muncipality = screeningOrder.applicantInfo?.city
    applicantDetail.region = screeningOrder.applicantInfo?.state
    
    let draftOrderEntityDescription = NSEntityDescription.entity(forEntityName: "DraftOrder", in: self.persistentContainer.viewContext)
    let draftOrder = DraftOrder(entity: draftOrderEntityDescription!, insertInto: self.persistentContainer.viewContext)
    
    draftOrder.saveddraftdate = UtilManager.sharedInstance.getDateStringFromDateObject(date: Date(), byDateFormattedString: DOBFORMATTER)
    draftOrder.packagetype = Int64(ScreeningRequestViewModel.getScreeningPackageStatusFrom(screeningRequest: ScreeningRequest.sharedInstance))
    draftOrder.isdriversearch = Int64(ScreeningRequestViewModel.getIsDriverSearchStatusFrom(screeningRequest: ScreeningRequest.sharedInstance))
    draftOrder.status = 1
    draftOrder.driversearch = driverDetail
    draftOrder.applicantsearch = applicantDetail
    
    do {
      try draftOrder.managedObjectContext?.save()
      self.saveContext()
      saveDraftFlag = true
    }
    catch {
      saveDraftFlag = false
    }

    return saveDraftFlag
  }
  
  
  
  // MARK:  fetchAllDraftOrderFromLocalDB Method.
  func fetchAllDraftOrderFromLocalDB() -> [DraftOrder]{
    var arrayOfDraftOrder = [DraftOrder]()
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "DraftOrder", in: self.persistentContainer.viewContext)
    
    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<DraftOrder> = DraftOrder.fetchRequest()
    
    // Configure Fetch Request
    fetchRequest.entity = entityDescription
    
    do {
      let result = try self.persistentContainer.viewContext.fetch(fetchRequest)
      arrayOfDraftOrder = result
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
    
    return arrayOfDraftOrder
  }
  
}
