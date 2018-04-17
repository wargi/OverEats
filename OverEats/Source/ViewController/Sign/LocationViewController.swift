//
//  LocationViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var expandedSectionHeaderNumber = -1
    var boool:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
                tableView.backgroundView = nil
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // UITableViewHeaderFooterView로 보기 재구성
        
        // header 색 설정하기
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        header.textLabel?.textColor = UIColor.black
        
        
        if section == 0 {
            header.contentView.backgroundColor = UIColor.black // 검은 줄
        }else if section == 1{
            header.textLabel?.font = UIFont.systemFont(ofSize: 17)
            header.textLabel?.text = "필수! 상세 주소를 입력해주세요"
        }else if section == 2 {
        
            let theImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
            theImageView.image = UIImage(named: "icTabHomeOff")
            header.addSubview(theImageView)
            header.textLabel?.font = UIFont.systemFont(ofSize: 17)
            header.textLabel?.text = "         문 앞까지 배달"

        }else if section == 3 {
            
            let theImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
            theImageView.image = UIImage(named: "icSettingListInvite")
            header.addSubview(theImageView)
            header.textLabel?.font = UIFont.systemFont(ofSize: 17)
            header.textLabel?.text = "         밖에서 픽업"
            
        }else if section == 4 {
            let theImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
            theImageView.image = UIImage(named: "btnSearch")
            header.addSubview(theImageView)
            header.textLabel?.font = UIFont.systemFont(ofSize: 15)
            header.textLabel?.text = "         배달 관련 참고사항 입력 (찾아오는 길 혹은 요청사항)"
        }
        
        if section == 2 || section == 3 {
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        footer.contentView.backgroundColor = UIColor.black
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
        }else if section == 3{
            return 15 // 밖에서 픽업 밑에 검은줄
        }else if section == 4{
            return 15 // 배달관련 참고 밑에 검은줄
        }else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.brown
       
        if indexPath.section == 0 {
            cell.textLabel?.text = "신사동" // 임시로 넣은 것
        } else if indexPath.section == 2{
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as UITableViewCell
            return cell
        }
        
        return cell
    }
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        
        let headerView = sender.view as! UITableViewHeaderFooterView // 선택한 뷰가 어느 headerview인지 찾기
        let section = headerView.tag // view tag 값 주기
        if expandedSectionHeaderNumber == -1 {
            //처음에 아무것도 안눌러져있을 때
            
            expandedSectionHeaderNumber = section // 누른 header의 tag가 들어가기
            tableViewLong(section)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                // 같은걸 눌렀을 때
                tableViewShort(section)
            } else {
                // 다른걸 눌렀을 때
                tableViewShort(section)

            }
        }
    }
    
    func tableViewShort(_ sender: Int) {
        
        expandedSectionHeaderNumber = -1
        if sender == 2 || boool == true{
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
