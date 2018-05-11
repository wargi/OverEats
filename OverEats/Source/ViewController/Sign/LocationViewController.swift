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
    
    private var tempFlag: Bool = true
    
    // 현재 위치를 정의하는 셀
    private var currentLocationCell = LocationTableUtility(cellType: .select, title: "현재 위치")
    
    // 검색한 주소 값 혹은 이전에 지정 된 주소 값을 정의하는 셀
    private var searchLocationCell: LocationTableUtility?
    
    // 검색한 주소의 정보를 담은 데이터
    private var searchLocationData: LocationData? {
        didSet{
            searchLocationCell?.cellType = .select
            searchLocationCell?.title = searchLocationData?.addressComponents[0].shortName
            searchLocationCell?.cellData = searchLocationData
            searchLocationCell?.iconName = "btnClock"
        }
    }
    
    private var detailLocatonData: LocationData?
    
    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    
    
    var selectTableUtility: [LocationTableUtility] = []
    var searchTableUtility: [LocationTableUtility] = []
    var detailTableUtility: [LocationTableUtility] = []
    var reloadTableUtility: [LocationTableUtility]?
    
    enum TableStatus{
        case select
        case search
        case detail
    }
    
    private var tableStatus: TableStatus?{
        didSet{
            if tableStatus == .select {
                reloadTableUtility = selectTableUtility
                selectButton.isHidden = true
                backButton.isHidden = true
                dismissButton.isHidden = false
                completeButton.isHidden = true
            } else if tableStatus == .search {
                reloadTableUtility = searchTableUtility
                selectButton.isHidden = true
                backButton.isHidden = false
                dismissButton.isHidden = true
                completeButton.isHidden = true
            } else if tableStatus == .detail {
                reloadTableUtility = detailTableUtility
                selectButton.isHidden = true
                backButton.isHidden = false
                dismissButton.isHidden = true
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        setSelectTable()
        locationTextField.text = ""
    }
    
    @IBAction func dismissButton(_ sender: Any) {
    }
    
    
    @IBAction func completeButton(_ sender: UIButton) {
        
        if locationTableView.indexPathForSelectedRow?.row == 0 {
            
            let selectCell = locationTableView.cellForRow(at: locationTableView.indexPathForSelectedRow!) as! LocationDeliveryTableViewCell
            
            if selectCell.buildingNameTextField.text != "" {
                detailLocatonData?.formattedAddress.append(", \(selectCell.buildingNameTextField.text ?? "")")
            }
            if selectCell.companyNameTextField.text != "" {
                detailLocatonData?.formattedAddress.append(", \(selectCell.companyNameTextField.text ?? "")")
            }
            
        }
        
        self.searchLocationData = detailLocatonData
        
        self.tempFlag = true
        
        setSelectTable()
        locationTextField.text = ""
        
    }
    
    @IBAction func selectButton(_ sender: Any) {
        let selectCell = locationTableView.cellForRow(at: locationTableView.indexPathForSelectedRow!) as! LocationSelectCell
        LocationManager.setLocation = selectCell.locationData
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationTableView.rowHeight = UITableViewAutomaticDimension;
        
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        
        self.hideKeyboardWhenTappedAround()
        
        // 에니메아션 미적용
        UIView.setAnimationsEnabled(false)
        
        locationManager.delegate = self
        
        setSelectTable()
        
    }
    
    private func setSelectTable(){
        // 현재 위치 셀에 대한 데이터 갱신
        startUpdateCurrentLocation()
        
        if let selectLocationData = LocationManager.location, self.searchLocationData == nil {
            self.searchLocationData = selectLocationData
        }
        
    }
    
    /// 현재 위치의 좌표값 갱신을 활성화하는 함수
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
    
    
    /// 현재 위치의 좌표값 갱신을 중지하는 함수
    private func stopUpdateLocationData(){
        
        locationManager.stopUpdatingLocation()
        
    }
    
    /// 현재 위치의 좌표값에 해당하는 주소 데이터를 요청하는 함수
    private func getCurrentLocationData() {
        if let coordinate = self.currentCoordinate {
            
            PostService.userLocation(latitude: coordinate.latitude, longitude: coordinate.longitude) { (result) in
                switch result {
                case .success(let locationDatas):
                    
                    self.selectTableUtility = []
                    
                    var tempData = locationDatas.result[0]
                    
                    tempData.geometry.lat =
                        tempData.geometry.location?.lat
                    
                    tempData.geometry.lng =
                        tempData.geometry.location?.lng
                    
                    self.currentLocationCell.cellType = .select
                    self.currentLocationCell.cellData = tempData
                    self.currentLocationCell.cellContent = tempData.formattedAddress
                    self.currentLocationCell.iconName = "btnLocation"
                    
                    self.selectTableUtility.append(self.currentLocationCell)
                    
                    if let searchLocationData = self.searchLocationData {
                        self.searchLocationCell = LocationTableUtility(cellType: .select, title: searchLocationData.addressComponents[0].longName)
                        
                        self.searchLocationCell!.cellContent = searchLocationData.formattedAddress
                        self.searchLocationCell!.iconName = "btnClock"
                        
                        self.selectTableUtility.append(self.searchLocationCell!)
                    }
                    
                    self.tableStatus = .select
                    
                    self.locationTableView.reloadData()
                    
                case .error(let error):
                    print(error)
                }
            }
        }
    }
    
    
}

// Location Delegate
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        self.currentCoordinate = location.coordinate
        
        locationManager.stopUpdatingLocation()
        
        if tempFlag == true {
            getCurrentLocationData()
            tempFlag = false
        }
        
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
        
        if reloadTableUtility![indexPath.row].cellType == CellType.select {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectCell") as! LocationSelectCell
            cell.configure(locationData: reloadTableUtility![indexPath.row])
            
            return cell
        }else if reloadTableUtility![indexPath.row].cellType == CellType.search {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationResultTableViewCell") as! LocationResultTableViewCell
            cell.configure(locationData: reloadTableUtility![indexPath.row])
            
            return cell
        }else if reloadTableUtility![indexPath.row].cellType == CellType.delivery {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationDeliveryTableViewCell") as! LocationDeliveryTableViewCell
            cell.configure(locationData: reloadTableUtility![indexPath.row])
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationPickUpTableViewCell") as! LocationPickUpTableViewCell
            cell.configure(locationData: reloadTableUtility![indexPath.row])
            
            return cell
        }
    }
}

extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if tableStatus == TableStatus.select {
            selectButton.isHidden = false
            
        }else if tableStatus == TableStatus.search{
            detailTableUtility = []
            
            let selectCell = tableView.cellForRow(at: indexPath) as! LocationResultTableViewCell
            
            if let locationData = selectCell.locationData {
                
                self.detailLocatonData = locationData
                
                var deliveryLocationCell = LocationTableUtility(cellType: .delivery, title: "문 앞까지 배달")
                deliveryLocationCell.cellData = locationData
                deliveryLocationCell.iconName = "btnDoor"
                
                self.detailTableUtility.append(deliveryLocationCell)
                
                var pickUpLocationCell = LocationTableUtility(cellType: .pickUp, title: "밖에서 픽업")
                pickUpLocationCell.cellData = locationData
                pickUpLocationCell.iconName = "btnOutsidePickup"
                
                self.detailTableUtility.append(pickUpLocationCell)
                
                self.tableStatus = .detail
                
                self.locationTableView.reloadData()
            }
        }else if tableStatus == TableStatus.detail {
            completeButton.isHidden = false
        }
    }
}

extension LocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        guard let text = locationTextField.text else { return false }
        
        searchTableUtility = []

        PostService.locationIn(text: text) { (result) in
            switch result {
                case .success (let locationDatas):
                    for locationData in locationDatas.result {
                        var searchLocationCell = LocationTableUtility(cellType: .search, title: locationData.name!)
                        searchLocationCell.cellData = locationData
                        searchLocationCell.iconName = "btnAddress"
                        
                        self.searchTableUtility.append(searchLocationCell)

                        self.tableStatus = .search
                        
                        self.locationTableView.reloadData()
                }
                case .error (let error):
                    print(error)
            }
        }
        return true
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension Array {
    var lastItem: Element {
        return self[self.endIndex - 1]
    }
}
