//
//  ScreeningRequestViewModel.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 29/05/17.
//

import Foundation


/*
 Screening Search Packages Type enumeration....
 Enum types are Gold, Silver, Bronze and None....
 */
enum ScreeningSearchPackagesType {
  case Gold
  case Silver
  case Bronze
  case None
}


/*
 Screening Search Packages Services Type enumeration....
 Enum types are SsnTrace, FederalCriminal, CountyCriminal, NationalCriminal and DriverSearch....
 */
enum ScreeningSearchPackageServicesType {
  case SsnTrace
  case NationalCriminal
  case CountyCriminal
  case FederalCriminal
  case DriverSearch
}



/*
 * ScreeningRequestViewModel class with class method declaration and defination implementaion to handle functionality of New Screening Request for search packages.
 */
class ScreeningRequestViewModel {
  

  
  // MARK:  ------------------------------------- Helper methods for XML Api request XML string  -------------------------------

  // MARK:  prepareXmlStringNewScreeningRequestByModel Method.
  class func prepareXmlStringNewScreeningRequestByModel(screeningRequest: ScreeningRequest) -> String{
    var requestXmlString = ""
    var baseXmlString = ""
    
    /*
     <?xml version="1.0"?>
     <BackgroundCheck userId="gvn_app_xml" password="BFc29K3e7!9WsCtf">
     <BackgroundSearchPackage action="submit" type="GVN App">
     <ReferenceId>112233</ReferenceId>
    */
    baseXmlString = String(format: "<?xml version=\"1.0\"?>\n<BackgroundCheck userId=\"gvn_app_xml\" password=\"BFc29K3e7!9WsCtf\">\n\t<BackgroundSearchPackage action=\"submit\" type=\"GVN App\">\n\t\t<ReferenceId>112233</ReferenceId>")
    
    let applicantSearchXml = self.prepareXmlStringForApplicantSearchScreeningServiceByModel(screeningRequest: screeningRequest)
    baseXmlString = String(format: "%@\n\t\t%@", baseXmlString, applicantSearchXml)
    
    let investigativeServiceXml = self.getInvestigativeServicesXmlStringForScreeningPackage(type: ScreeningSearchPackagesType.Gold)
    baseXmlString = String(format: "%@\n\t\t<Screenings>\n\t\t\t%@", baseXmlString, investigativeServiceXml)

    
    var verificationServiceXml = ""
    if screeningRequest.verificationServiceFlag == true{
      verificationServiceXml = self.prepareXmlStringForDriverSearchScreeningServiceByModel(screeningRequest: screeningRequest)
      baseXmlString = String(format: "%@\n\t\t\t%@", baseXmlString, verificationServiceXml)
    }
    
    let additionalScreeningItemXml = self.prepareXmlStringForScreenignRequestAdditionalItems()
    baseXmlString = String(format: "%@\n\t\t\t%@", baseXmlString, additionalScreeningItemXml)

    requestXmlString = String(format: "%@\n\t\t</Screenings>\n\t</BackgroundSearchPackage>\n</BackgroundCheck>", baseXmlString)
    return requestXmlString
  }
  
  
  // MARK:  prepareXmlStringForApplicantSearchScreeningServiceByModel Method.
  class func prepareXmlStringForApplicantSearchScreeningServiceByModel(screeningRequest: ScreeningRequest) -> String{
    var applicantSearchXml = ""

    /*
     <PersonalData>
      <PersonName>
        <GivenName>Joe</GivenName>
        <FamilyName>Clean</FamilyName>
        <MiddleName></MiddleName>
      </PersonName>
      <DemographicDetail>
        <GovernmentId countryCode="US" issuingAuthority="SSN">111-22-3333</GovernmentId>
        <DateOfBirth>1960-01-01</DateOfBirth>
      </DemographicDetail>
      <PostalAddress>
        <PostalCode>90001</PostalCode>
        <Region>CA</Region>
        <Municipality>LOS ANGELES</Municipality>
        <DeliveryAddress>
          <AddressLine>899 LINCOLN RD</AddressLine>
        </DeliveryAddress>
      </PostalAddress>
      <EmailAddress></EmailAddress>
      <Telephone></Telephone>
     </PersonalData>
     */
    
    
    let applicantInfo = screeningRequest.applicantInfo
    let firstName = applicantInfo?.firstName
    let middleName = applicantInfo?.middleName
    let lastName = applicantInfo?.lastName
    // let ssn = applicantInfo?.ssnNumber
    let dob = UtilManager.sharedInstance.changeDateStringFormatterForDateString(dateString: (applicantInfo?.dob)!, byDateFormattedString: DOBFORMATTER, toRequiredFormat: XMLAPIREQUESTDOBFORMATTER)
    let email = applicantInfo?.email
    let address = applicantInfo?.address
    let postalCode = applicantInfo?.postalCode
    let city = applicantInfo?.city
    let state = applicantInfo?.state
    
    
    applicantSearchXml = String(format: "<PersonalData>\n\t\t\t<PersonName>\n\t\t\t\t<GivenName>%@</GivenName>\n\t\t\t\t<FamilyName>%@</FamilyName>\n\t\t\t\t<MiddleName>%@</MiddleName>\n\t\t\t</PersonName>\n\t\t\t<DemographicDetail>\n\t\t\t\t<GovernmentId countryCode=\"US\" issuingAuthority=\"SSN\">111-22-3333</GovernmentId>\n\t\t\t\t<DateOfBirth>%@</DateOfBirth>\n\t\t\t</DemographicDetail>\n\t\t\t<PostalAddress>\n\t\t\t\t<PostalCode>%@</PostalCode>\n\t\t\t\t<Region>%@</Region>\n\t\t\t\t<Municipality>%@</Municipality>\n\t\t\t\t<DeliveryAddress>\n\t\t\t\t\t<AddressLine>%@</AddressLine>\n\t\t\t\t</DeliveryAddress>\n\t\t\t</PostalAddress>\n\t\t\t<EmailAddress>%@</EmailAddress>\n\t\t\t<Telephone></Telephone>\n\t\t</PersonalData>", firstName!, lastName!,middleName!, dob, postalCode!, state!, city!, address!, email!)
    
    return applicantSearchXml
  }
  
  // MARK:  prepareXmlStringForDriverSearchScreeningServiceByModel Method.
  class func prepareXmlStringForDriverSearchScreeningServiceByModel(screeningRequest: ScreeningRequest) -> String{
    var driverSearchXml = ""
    
    let driverInfo = screeningRequest.driverInfo
    let licenseState = "UT" // driverInfo?.licenseState
    let licenseDuration = driverInfo?.licenseDuration
    let licenseNumber = driverInfo?.licenseNumber

    /*
     <Screening type="license" qualifier="imvPersonal">
      <Region>UT</Region>
      <Duration></Duration>
      <SearchLicense>
        <License>
          <LicenseNumber>123456789</LicenseNumber>
        </License>
      </SearchLicense>
     </Screening>
    */
    driverSearchXml = String(format: "<Screening type=\"license\" qualifier=\"imvPersonal\">\n\t\t\t\t<Region>%@</Region>\n\t\t\t\t<Duration>%@</Duration>\n\t\t\t\t<SearchLicense>\n\t\t\t\t\t<License>\n\t\t\t\t\t\t<LicenseNumber>%@</LicenseNumber>\n\t\t\t\t\t</License>\n\t\t\t\t</SearchLicense> \n\t\t\t</Screening>", licenseState, licenseDuration!, licenseNumber!)

    return driverSearchXml
  }
  
  // MARK:  prepareXmlStringForNationalCriminalRecord Method.
  class func prepareXmlStringForNationalCriminalRecord() -> String{
    var nationalCriminalXml = ""
    
    /*
     <Screening type="criminal" qualifier="national" />
    */
    nationalCriminalXml = String(format: "<Screening type=\"criminal\" qualifier=\"national\" />")
    return nationalCriminalXml
  }

  // MARK:  prepareXmlStringForCountyCriminalRecord Method.
  class func prepareXmlStringForCountyCriminalRecord() -> String{
    var countyCriminalXml = ""

    /*
     <Screening type="criminal" qualifier="county" />
     */
    countyCriminalXml = String(format: "<Screening type=\"criminal\" qualifier=\"county\" />")
    return countyCriminalXml
  }

  // MARK:  prepareXmlStringForFederalCriminalRecord Method.
  class func prepareXmlStringForFederalCriminalRecord() -> String{
    var federalCriminalXml = ""
    
    /*
     <Screening type="criminal" qualifier="federal" />
     */
    federalCriminalXml = String(format: "<Screening type=\"criminal\" qualifier=\"federal\" />")
    return federalCriminalXml
  }

  // MARK:  prepareXmlStringForFederalCriminalRecord Method.
  class func prepareXmlStringForSexOffenderRecord() -> String{
    var sexOffenderXml = ""
    
    /*
     <Screening type="sex_offender" />
     */
    sexOffenderXml = String(format: "<Screening type=\"sex_offender\" />")
    return sexOffenderXml
  }
  
  // MARK:  prepareXmlStringForScreenignRequestAdditionalItems Method.
  class func prepareXmlStringForScreenignRequestAdditionalItems() -> String{
    var additionalItemsString = ""
    
    /*
     <AdditionalItems type="x:embed_credentials">
     <Text>true</Text>
     </AdditionalItems>
     */
    let embed_credentials = String(format: "<AdditionalItems type=\"x:embed_credentials\">\n\t\t\t\t<Text>true</Text>\n\t\t\t</AdditionalItems>")
    
    /*
     <AdditionalItems type="x:postback_url">
     <Text>https://www.instascreen.net/demo/response.php</Text>
     </AdditionalItems>
     */
    let postback_url = String(format: "<AdditionalItems type=\"x:postback_url\">\n\t\t\t\t<Text>https://www.instascreen.net/demo/response.php</Text>\n\t\t\t</AdditionalItems>")
    
    /*
     <AdditionalItems type="x:integration_type">
     <Text>GVNApp</Text>
     </AdditionalItems>
     */
    let integration_type = String(format: "<AdditionalItems type=\"x:integration_type\">\n\t\t\t\t<Text>GVNApp</Text>\n\t\t\t</AdditionalItems>")
    
    /*
     <AdditionalItems type="x:return_xml_results">
     <Text>yes</Text>
     </AdditionalItems>
     */
    let return_xml_results = String(format: "<AdditionalItems type=\"x:return_xml_results\">\n\t\t\t\t<Text>yes</Text>\n\t\t\t</AdditionalItems>")
    
    
    // Merge all additional item xml string into aditionalItemsString and return the same for all.
    additionalItemsString = String(format: "%@\n\t\t\t%@\n\t\t\t%@\n\t\t\t%@", embed_credentials, postback_url, integration_type, return_xml_results)
    return additionalItemsString
  }

  // MARK:  getInvestigativeServicesXmlStringForScreeningPackage Method.
  class func getInvestigativeServicesXmlStringForScreeningPackage(type: ScreeningSearchPackagesType) -> String{
    var investigativeSearchXmlString = ""
    
    let nationalCriminalSearchXml = self.prepareXmlStringForNationalCriminalRecord()
    let countyCriminalSearchXml = self.prepareXmlStringForCountyCriminalRecord()
    let federalCriminalSearchXml = self.prepareXmlStringForFederalCriminalRecord()
    let sexOffenderCriminalSearchXml = "" // self.prepareXmlStringForSexOffenderRecord()

    switch type {
    case ScreeningSearchPackagesType.Bronze:
      investigativeSearchXmlString = String(format: "%@\n\t\t\t%@", nationalCriminalSearchXml, sexOffenderCriminalSearchXml)
      break
      
    case ScreeningSearchPackagesType.Silver:
      investigativeSearchXmlString = String(format: "%@\n\t\t\t%@\n\t\t\t%@", nationalCriminalSearchXml, sexOffenderCriminalSearchXml, countyCriminalSearchXml)
      break
      
    case ScreeningSearchPackagesType.Gold:
      investigativeSearchXmlString = String(format: "%@\n\t\t\t%@\n\t\t\t%@\n\t\t\t%@", nationalCriminalSearchXml, sexOffenderCriminalSearchXml, countyCriminalSearchXml, federalCriminalSearchXml)
      break

    case ScreeningSearchPackagesType.None:
      print("")
      break
    }
    
    return investigativeSearchXmlString
  }
  
  // MARK:  ----------------------------------------------------------------- End --------------------------------------------------------------

  
  // MARK:  ------------------------------------- XML parsing methods  -------------------------------
  
  // MARK:  getApplicantInfoFromApiRequest Method.
  class func getApplicantInfoFromApiRequest(xmlString: String) -> ApplicantInfo{
    let applicant = ApplicantInfo()
    
    var requestDataDict = NSDictionary()
    do{
      requestDataDict = try XMLReader.dictionary(forXMLString: xmlString) as NSDictionary
      
      if let backgroundCheck = requestDataDict["BackgroundCheck"] as? NSDictionary{
        if let backgroundSearchPackage = backgroundCheck["BackgroundSearchPackage"] as? NSDictionary{
          if let personalData = backgroundSearchPackage["PersonalData"] as? NSDictionary{
            
            if let personName = personalData["PersonName"] as? NSDictionary{
              
              if let givenName = personName["GivenName"] as? NSDictionary{
                if let text = givenName.value(forKey: "text") as? String{
                  applicant.firstName = text
                }
              }
              if let middleName = personName["MiddleName"] as? NSDictionary{
                if let text = middleName.value(forKey: "text") as? String{
                  applicant.middleName = text
                }
              }
              if let familyName = personName["FamilyName"] as? NSDictionary{
                if let text = familyName.value(forKey: "text") as? String{
                  applicant.lastName = text
                }
              }
            }
            
            if let demographicDetail = personalData["DemographicDetail"] as? NSDictionary{

              if let dateOfBirth = demographicDetail["DateOfBirth"] as? NSDictionary{
                if let text = dateOfBirth.value(forKey: "text") as? String{
                  applicant.dob = text
                }
              }
              if let governmentId = demographicDetail["GovernmentId"] as? NSDictionary{
                if let text = governmentId.value(forKey: "text") as? String{
                  applicant.ssnNumber = text
                }
              }
            }
            
            if let emailAddress = personalData["EmailAddress"] as? NSDictionary{
              if let text = emailAddress.value(forKey: "text") as? String{
                applicant.email = text
              }
            }
            
          }
        }
      }
      
    }
    catch{
    }
    
    
    return applicant
  }
  
  
  // MARK:  getPackageNameForScreeningPackage Method.
  class func getPackageNameForScreeningPackage(type: ScreeningSearchPackagesType) -> String{
    var packageName = ""
    
    switch type {
    case ScreeningSearchPackagesType.Bronze:
      packageName = "Bronze"
      break
      
    case ScreeningSearchPackagesType.Silver:
      packageName = "Silver"
      break

    case ScreeningSearchPackagesType.Gold:
      packageName = "Gold"
      break

    case ScreeningSearchPackagesType.None:
      packageName = "None"
      break
    }
    
    return packageName
  }
  
  // MARK:  getApplicantFullNameFrom method.
  class func getApplicantFullNameFrom(firstName: String, with middleName: String, and lastName: String) -> String {
    var name = ""
    
    if firstName.characters.count > 0{
      name = firstName
    }
    if middleName.characters.count > 0{
      name = String(format: "%@ %@", name, middleName)
    }
    if lastName.characters.count > 0{
      name = String(format: "%@ %@", name, lastName)
    }
    
    return name
  }
  
  
  
  
  // MARK:  getApplicantFullNameFrom method.
  class func getIsDriverSearchStatusFrom(screeningRequest: ScreeningRequest) -> Int{
    let isDriverSearch = screeningRequest.verificationServiceFlag
    
    if isDriverSearch == true{
      return 1
    }
    else{
      return 0
    }
  }

  
  // MARK:  getScreeningPackageStatusFrom method.
  class func getScreeningPackageStatusFrom(screeningRequest: ScreeningRequest) -> Int{
    let packageType: ScreeningSearchPackagesType = screeningRequest.screeningPackageType!

    switch packageType {
    case ScreeningSearchPackagesType.Bronze:
      return 1
      
    case ScreeningSearchPackagesType.Silver:
      return 2
      
    case ScreeningSearchPackagesType.Gold:
      return 3

    case ScreeningSearchPackagesType.None:
      return 0
    }
  }

}
