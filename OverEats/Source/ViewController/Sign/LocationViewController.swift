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
    
    private let locationManager = CLLocationManager()
    
    // 현재 위치에 대한 좌표
    private var currentCoordinate: CLLocationCoordinate2D?
    private var currentLocationData: LocationData?
    
    // 현재 위치를 정의하는 셀
    private var currentLocationCell = LocationTableUtility(cellType: .select, title: "현재 위치")
    
    var locationDeliveryCell: LocationDeliveryTableViewCell!
    var deliveryCompanyText: String?
    var deliverybuildingText: String?
    
    
    var formattedAddress: String?// 현 주소 String으로 받은 곳
    
    var isSeletedRow: Bool = true
    
    var textFieldformattedAddress: [String] = []
    var textFieldName: [String] = []
    var locationDataList: [LocationData] = []
    var locationData: LocationData?
    var userLocationData: AddressData?
    
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    
    var selectTableUtility: [LocationTableUtility] = []
    var searchTableUtility: [LocationTableUtility] = []
    var detailtTableUtility: [LocationTableUtility] = []
    var reloadTableUtility: [LocationTableUtility]?
    
    private var status = 1 {
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
        setSelectTable()
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
        
        // 에니메아션 미적용
        UIView.setAnimationsEnabled(false)
        
        locationManager.delegate = self
        
        setSelectTable()
    }
    
    private func setSelectTable(){
        startUpdateCurrentLocation()
        getCurrentLocationData()
    }
    
    private func startUpdateCurrentLocation(){
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
    
    private func getCurrentLocationData() {
        if let coordinate = self.currentCoordinate {
            PostService.userLocation(latitude: coordinate.latitude, longitude: coordinate.longitude) { (result) in
                switch result {
                case .success(let locationDatas):
                    self.currentLocationData?.addressComponents = locationDatas.result[0].addressComponents
                    self.currentLocationData?.formattedAddress = locationDatas.result[0].formattedAddress
                    self.currentLocationData?.geometry.lat = locationDatas.result[0].geometry.location.lat
                    self.currentLocationData?.geometry.lng = locationDatas.result[0].geometry.location.lng
                case .error(let error):
                    print(error)
                }
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
        self.currentCoordinate = location.coordinate
        
        stopUpdateLocationData()
        
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
