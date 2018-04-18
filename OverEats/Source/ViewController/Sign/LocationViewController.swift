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
    
    var theImageView: UIImageView!
    var expandedSectionHeaderNumber = -1
    var boool:Bool!
    let locationManager = CLLocationManager()
    let kHeaderSectionTag: Int = 12
    
    let sectionHeaderImage = [UIImage(named: "icTabHomeOff"), UIImage(named: "icSettingListInvite"), UIImage(named: "btnSearch")]
    let sectionHeaderTitle = ["필수! 상세 주소를 입력해주세요", "문 앞까지 배달", "밖에서 픽업", "배달 관련 참고사항 입력 (찾아오는 길 혹은 요청사항)"]
    
    @IBAction func okButton(_ sender: UIButton) {
    
    
    }
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        theImageView = UIImageView()
        theImageView.image = UIImage(named: "btnSearch")
        theImageView.tag = kHeaderSectionTag
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
        if sender == 2 || boool == true{
            
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
            
            boool = false
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
        
        boool = true
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        tableView.backgroundView = nil
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as UITableViewCell
            cell.imageView?.image = UIImage(named: "btnSearch")
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as UITableViewCell
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 2{
            if expandedSectionHeaderNumber == 2 {
                return 2
            } else {
                return 0
            }
        }else if section == 3{
            return 0
        }else {
            return 0
        }
        
    }
    
}

extension LocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // header 색 설정하기
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        header.textLabel?.textColor = UIColor.black
        
        if section == 1 {
            header.textLabel?.font = UIFont.systemFont(ofSize: 17)
            header.textLabel?.text = sectionHeaderTitle[section - 1]
        } else if section > 0 {
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
                theImageView.frame = CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18)
                header.addSubview(theImageView)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10 // 검은 줄 높이
        }else {
            return 44
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if section == 0 {
            return 10 // 신사동 밑에 검은줄
        }else if section == 3 || section == 4{
            return 15 // 밖에서 픽업 밑에 검은줄
        } else {
            return 0
        }
    }
    
}
