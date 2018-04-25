//
//  LocationViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 25..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
   
    @IBOutlet weak var locationTextField: UITextField!
    
    var locationDeliveryCell: LocationDeliveryTableViewCell!
    var deliveryCompanyText: String?
    var deliverybuildingText: String?
    
    let locationManager = CLLocationManager()
    var latitude: Double!
    var longitude: Double!
    
    var formattedAddress: String?// 현 주소 String으로 받은 곳
    
    var isSeletedRow: Bool = true
    
    var textFieldformattedAddress: [String] = []
    var textFieldName: [String] = []
    var locationDataList: [DetailData] = []
    var locationData: DetailData?
    var userLocationData: AddressData?
    
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    
    var firstTableUtility: [LocationTableUtility] = []
    var secondTableUtility: [LocationTableUtility] = []
    var thirdTableUtility: [LocationTableUtility] = []
    var reloadTableUtility: [LocationTableUtility]?
    var status = 1 {
        didSet{
            if status == 1 {
                backButton.isHidden = true
                dismissButton.isHidden = false
            } else if status == 2 {
                backButton.isHidden = false
                dismissButton.isHidden = true
            }
        }
    }
    @IBAction func backButton(_ sender: Any) {
        startUpdateLocationData()
    }
    
    @IBAction func dismissButton(_ sender: Any) {
    }
    
    
    @IBAction func completeButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        self.present(nextViewController, animated: true, completion: nil)
//        guard let userLocationInfo = userLocationData else { return }
//        if let locationInfo = locationData {
//            deliverybuildingText = locationDeliveryCell.buildingNameTextField.text
//            deliveryCompanyText = locationDeliveryCell.companyNameTextField.text
//
//            if let buildingText = deliverybuildingText, let companyText = deliveryCompanyText {
//                firstTableUtility.append(LocationTableUtility(cellType: 1, title: locationInfo.name, firstValue: locationInfo.formattedAddress, secondValue: buildingText + ", " + companyText, iconName: "btnClock", buttonname: ""))
//            } else {
//                firstTableUtility.append(LocationTableUtility(cellType: 1, title: locationInfo.name, firstValue: locationInfo.formattedAddress, secondValue: nil, iconName: "btnClock", buttonname: ""))
//            }
//
//            self.reloadTableUtility = firstTableUtility
//            locationTableView.reloadData()
//        } else if locationData == nil {
//            let storyboard = UIStoryboard(name: "main", bundle: nil)
//            let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//            self.present(nextViewController, animated: true, completion: nil)
//        } else {
//            let storyboard = UIStoryboard(name: "main", bundle: nil)
//            let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//            self.present(nextViewController, animated: true, completion: nil)
//        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationTableView.rowHeight = UITableViewAutomaticDimension;
        
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        
        UIView.setAnimationsEnabled(false)
        
        locationManager.delegate = self
        
        startUpdateLocationData()
    }
    
    private func startUpdateLocationData(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("앱을 사용하기 위해서는 위치 정보 사용 권한이 필요합니다.")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        }
    }
    
    private func stopUpdateLocationData(){
        locationManager.stopUpdatingLocation()
    }
    
    private func getNowLocationData() {
        PostService.userLocation(latitude: latitude, longitude: longitude) { (result) in
            switch result {
                
            case .success(let success):
                self.userLocationData = success.result[0]
                self.formattedAddress = success.result[0].formattedAddress
                if self.firstTableUtility.count < 1 {
                    self.firstTableUtility.append(LocationTableUtility(cellType: 1, title: "현재 위치", firstValue: self.formattedAddress, secondValue: nil, iconName: "btnLocation", buttonname: ""))
                    
                    self.reloadTableUtility = self.firstTableUtility
                    self.locationTableView.reloadData()
                }
                
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}

// Location Delegate
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        
        stopUpdateLocationData()
        getNowLocationData()
        
    }
}


extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let locationUtil = reloadTableUtility {
            return locationUtil.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let locationUtil = reloadTableUtility {
            
            if locationUtil[indexPath.row].cellType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectCell") as! LocationSelectCell
                cell.configure(locationData: firstTableUtility[indexPath.row])
                return cell
                
            } else if locationUtil[indexPath.row].cellType == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationResultTableViewCell") as! LocationResultTableViewCell
                cell.configure(locationData: secondTableUtility[indexPath.row])
                
                return cell
            } else if locationUtil[indexPath.row].cellType == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationPickUpTableViewCell") as! LocationPickUpTableViewCell
                cell.configure(locationData: thirdTableUtility[indexPath.row])
                
                return cell
            } else if locationUtil[indexPath.row].cellType == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationDeliveryTableViewCell") as! LocationDeliveryTableViewCell
                cell.configure(locationData: thirdTableUtility[indexPath.row])
                locationDeliveryCell = cell
                
                return locationDeliveryCell
            }
        }
        
        //이건 임시로 넣은거라고 하셨다
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationPickUpTableViewCell") as! LocationPickUpTableViewCell
        return cell
    }
}

extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
        if let locationUtil = reloadTableUtility {
            if locationUtil[indexPath.row].cellType == 2 {
                self.locationData = self.locationDataList[indexPath.row]
                
                self.thirdTableUtility.append(LocationTableUtility(cellType: 4, title: "문 앞까지 배달", firstValue: "", secondValue: "", iconName: "btnDoor", buttonname: ""))
                
                self.thirdTableUtility.append(LocationTableUtility(cellType: 3, title: "밖에서 픽업", firstValue: "", secondValue: "", iconName: "btnOutsidePickup", buttonname: ""))
                
                
                self.reloadTableUtility = self.thirdTableUtility
                tableView.reloadData()
            }
        }
    }
}

extension LocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = locationTextField.text else { return false }
        secondTableUtility = []
        reloadTableUtility = []
        
        PostService.locationIn(text: text) { (result) in
            switch result {
                case .success (let location):
                    self.locationDataList = location.result
                    for detailData in self.locationDataList {
                        let locationTableUtility = LocationTableUtility(cellType: 2, title: detailData.name, firstValue: detailData.formattedAddress, secondValue: "", iconName: "btnAddress", buttonname: "")
                        self.secondTableUtility.append(locationTableUtility)
                        
                        self.status = 2
                        
                        self.reloadTableUtility = self.secondTableUtility
                        self.locationTableView.reloadData()
                }
                case .error (let error):
                    print(error)
            }
        }
        return true
    }
    
}
