//
//  LocationViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    // 여기에 cell선택 정보 들어갑니다!
    var tosLocationData: DetailData!
    
    var detailLocation:[DetailData] = []
    var location:LocationData!
    
    var address:[String] = []
    var stopLocation:[String] = []
    
    var theImageView: UIImageView!
    var expandedSectionHeaderNumber = -1
    var accordion:Bool!
    let locationManager = CLLocationManager()
    var pageTag = 1
    
    var otherText: String!
    
    let sectionHeaderImage = [UIImage(named: "icTabHomeOff"), UIImage(named: "icSettingListInvite"), UIImage(named: "btnSearch")]
    let sectionHeaderTitle = ["필수! 상세 주소를 입력해주세요", "문 앞까지 배달", "밖에서 픽업", "배달 관련 참고사항 입력 (찾아오는 길 혹은 요청사항)"]
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var okButtonOutlet: UIButton!
    @IBAction func okButton(_ sender: UIButton) {
        
        
        
    }
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        theImageView = UIImageView() // 회전하는 돋보기
        theImageView.image = UIImage(named: "btnMore")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //view reload 알아보기
        switch pageTag {
        case 1:
            //            print("===========들어왔다1111111111111")
            okButtonOutlet.isHidden = false //true로 고치기
        case 2:
            //            print("===========들어왔다2222222222222")
            okButtonOutlet.isHidden = true
        default:
            //            print("===========들어왔다333333333333")
            okButtonOutlet.isHidden = false
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"notiTagTwo"), object: nil, queue: nil) { (noti) in
            self.pageTag = noti.object as! Int
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"notiKey"), object: nil, queue: nil) { (noti) in  //notiKey 라는 키값을 지정해줌
            
            let locationData = noti.object as! LocationData
            
            for data in locationData.result {
                self.detailLocation.append(data)
                
                self.address.append(data.address)
                self.stopLocation.append(data.name)
                
            }
            
            print("===========================================",self.address)
            
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"notiBool"), object: nil, queue: nil) { (noti) in
            let boolData = noti.object as! Bool
            
            if boolData == true {
                self.tableView.reloadData()
                
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"otherText"), object: nil, queue: nil) { (noti) in

            //작업 이어서 하기
//            self.otherText = noti.object as! String

        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        
        let headerView = sender.view as! UITableViewHeaderFooterView // 선택한 뷰가 어느 headerview인지 찾기
        let section = headerView.tag // view tag 값 주기
        
        if expandedSectionHeaderNumber == -1 {
            //처음에 아무것도 안눌러져있을 때
            
            expandedSectionHeaderNumber = section // 누른 header의 tag가 들어가기
            tableViewLong(section)
        } else {
            tableViewShort(section)
            
        }
        
    }
    
    func tableViewShort(_ sender: Int) {
        
        expandedSectionHeaderNumber = -1
        if sender == 2 || accordion == true{
            
            UIView.animate(withDuration: 0.4, animations: {
                self.theImageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            
            var indexesPath = [IndexPath]()
            for i in 0 ..< 2 {
                let index = IndexPath(row: i, section: 2)
                indexesPath.append(index)
            }
            
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
            
            accordion = false
        }
    }
    
    func tableViewLong(_ sender: Int) {
        if sender == 2{
            
            UIView.animate(withDuration: 0.4, animations: {
                self.theImageView.transform = CGAffineTransform(rotationAngle: (180 * CGFloat(Double.pi)) / 180.0)
            })
            
            var indexesPath = [IndexPath]()
            for i in 0 ..< 2 {
                let index = IndexPath(row: i, section: 2)
                indexesPath.append(index)
            }
            
            expandedSectionHeaderNumber = 2
            
            
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
            
            accordion = true
            
        } else {
            expandedSectionHeaderNumber = -1
        }
        
        
    }
    
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        testLabel.text = String(format: "위도: %2.4f, 경도: %2.4f", arguments: [coordinate.latitude, coordinate.longitude])
        
    }
}

extension LocationViewController: UITableViewDataSource {
    
    // section 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if pageTag == 1 || pageTag == 2 {
            
            return 2
            
        }else {
            
            return 5
        }
        
    }
    
    // cell 정의하기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if pageTag == 1{
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.imageView?.image = UIImage(named: "btnSearch")
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
                cell.imageView?.image = UIImage(named: "btnSearch")
                
                return cell
            }
            
        }else if pageTag == 2 {
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.imageView?.image = UIImage(named: "btnSearch")
                
                return cell
            }else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
                cell.imageView?.image = UIImage(named: "btnSearch")
                
                let addressData = self.address[indexPath.row]
                let stopLocation = self.stopLocation[indexPath.row]
                cell.configure(stopLocation: stopLocation, location: addressData)
                
                return cell
            }
            
        }else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.imageView?.image = UIImage(named: "btnSearch")
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTextFieldTableViewCell", for: indexPath) as! OtherTextFieldTableViewCell
                
                if indexPath.row == 0 {
                    cell.tagInt(tag: 1)
                } else {
                    cell.tagInt(tag: 2)
                }
                
                return cell
            }
        }
        
        
    }
    
    // cell 갯수 정하기
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch pageTag {
        case 1:
            
            if section == 0 {
                return 1
            }else if section == 1{
                return 1
            }
            
        // 정보 내랴오는 수로 바꾸기
        case 2:
            
            if section == 0 {
                print("11111")
                return 1
                
            }else {
                print("22222")
                print("\(self.address.count)")
                return self.address.count
            }
            
        default:
            
            if section == 0 {
                return 1
            }else if section == 2{
                if expandedSectionHeaderNumber == 2 {
                    return 2
                }else {
                    return 0
                }
            }else if section == 3{
                return 0
            }
            
        }
        return 0
    }
}

extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pageTag == 1 || pageTag == 2 {
            
            if indexPath.section == 0 {
                return 44
            }else {
                return 50
            }
        }else {
            return 44
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        header.textLabel?.textColor = UIColor.black
        
        
        if pageTag == 1 || pageTag == 2 {
            
            if section == 0 {
                header.contentView.backgroundColor = AppColor.Base
            }
            
        }else {
            
            if section == 0 {
                header.contentView.backgroundColor = AppColor.Base
            }else if section == 1 {
                header.textLabel?.font = UIFont.systemFont(ofSize: 17)
                header.textLabel?.text = sectionHeaderTitle[section - 1]
            }else if section == 4 {
                
                let theImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 25, height: 25))
                theImageView.image = sectionHeaderImage[section - 2]
                header.addSubview(theImageView)
                let sectionHeaderLabel = UILabel(frame: CGRect(x: 60, y: 10, width: 300, height: 25))
                sectionHeaderLabel.font = UIFont.systemFont(ofSize: 14)
                sectionHeaderLabel.textColor = AppColor.lightGray
                sectionHeaderLabel.text = sectionHeaderTitle[section - 1]
                header.addSubview(sectionHeaderLabel)
                
            }else if section > 0 {
                let theImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 25, height: 25))
                theImageView.image = sectionHeaderImage[section - 2]
                header.addSubview(theImageView)
                let sectionHeaderLabel = UILabel(frame: CGRect(x: 60, y: 10, width: 300, height: 25))
                sectionHeaderLabel.font = UIFont.systemFont(ofSize: 15)
                sectionHeaderLabel.text = sectionHeaderTitle[section - 1]
                header.addSubview(sectionHeaderLabel)
            }
            
            if section == 2 || section == 3 {
                header.tag = section
                let headerTapGesture = UITapGestureRecognizer()
                headerTapGesture.addTarget(self, action: #selector(sectionHeaderWasTouched(_:)))
                header.addGestureRecognizer(headerTapGesture)
                if section == 2 {
                    let headerFrame = self.view.frame.size
                    theImageView.frame = CGRect(x: headerFrame.width - 35, y: 5, width: 35, height: 35)
                    header.addSubview(theImageView)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = AppColor.Base
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if pageTag == 1 || pageTag == 2{
            if section == 0 {
                return 10
            }else {
                return 0
            }
        }else {
            
            if section == 0 {
                return 10
            }else {
                return 44
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        switch pageTag {
        case 1:
            if section == 0 {
                return 10
            }
        case 2:
            if section == 0 {
                return 0
            }
        default:
            if section == 0 {
                return 10
            }else if section == 3 || section == 4{
                return 15
            } else {
                return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let indexInt = indexPath.row
            tosLocationData = detailLocation[indexInt]
            print(tosLocationData)
            pageTag = 3
            
            self.tableView.reloadData()
        }
    }
    
}
