//
//  SetTableAutolayout.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 11..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

//import UIKit
//
//// MARK: - 테이블 뷰 내 헤더뷰와 풋터뷰 레이아웃 정의 함수
//extension UITableView {
//    
//    // 테이플 헤더뷰와 오토레이아웃 정의
//    func setTableHeaderView(headerView: UIView) {
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 헤더뷰 정의
//        self.tableHeaderView = headerView
//        
//        // 오토레이아웃 정의
//        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        headerView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
//        
//        headerView.layoutIfNeeded()
//    }
//    
//}
