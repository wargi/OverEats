//
//  SearchViewController.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 22..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // 검색 탑 바
    @IBOutlet weak var searchTopBar: UIView!
    
    // 카테고리 컬랙션 뷰
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 검색 결과 테이블 뷰
    @IBOutlet weak var searchTableView: UITableView!
    
    // 검색 탑바 객체
    @IBOutlet weak var searchTextField: UITextField! // 검색 텍스트 필드
    @IBOutlet weak var cancelStackView: UIStackView! // 취소 버튼 스텍 뷰
    @IBOutlet weak var backButton: UIButton! // 뒤로가기 버튼
    @IBOutlet weak var removeButton: UIButton! // 검색 텍스트 필드 초기화 버튼
    @IBOutlet weak var searchImageView: UIImageView! // 돋보기 아이콘
   
    // 탑바 높이
    @IBOutlet weak var searchTopBarHeight: NSLayoutConstraint!
    
    // 탑바 높이 관련 인스턴스
    private let maximumTopBarPoint: CGFloat = 120
    private let minimumTopBarPoint: CGFloat = 40
    
    // 레스토랑 데이터
    var restaurants: [Lestaurant]?
    
    // 카테고리 테그 관련 데이터
    var tagData: Tags? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // 레이아웃 관련 인스턴스
    private struct Metric {
        static let numberOfItem: CGFloat = 2
        static let numberOfLine: CGFloat = 2
        
        static let topPadding: CGFloat = 0
        static let leftPadding: CGFloat = 15.0
        static let bottomPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 15.0
        
        static let lineSpacing: CGFloat = 10.0
        static let itemSpacing: CGFloat = 10.0
        
        static let nextOffset: CGFloat = 0.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTagData()
        
        // 테이블 헤더뷰의 기본값 정의
        self.searchTableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNormalMagnitude))
        
        // 테이블 섹션 헤더뷰의 기본값 정의
        self.searchTableView.rowHeight = UITableViewAutomaticDimension
        self.searchTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.searchTableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        
    }
    
    // 카테고리 데이터를 가지고 온다.
    private func getTagData() {
        GetService.tagList(completion: { (result) in
            switch result {
            case .success(let tagData):
                self.tagData = tagData
            case .error(let error):
                print(error)
            }
        })
    }
    
    
    /// 검색 단어를 바탕으로 레스토랑 데이터 요청하는 함수
    ///
    /// - Parameter searchText: 검색 단어 또는 카테고리 단어
    private func searchRestaurantData(searchText: String){
        GetService.getRestaurantList(latitude: 37.524124, longitude: 127.022881, pageSize: 20, searchText: searchText, completion: { (result) in
            switch result {
            case .success(let restaurantData):
                self.restaurants = restaurantData.restaurants
            case .error(let error):
                print(error)
            }
            // 테이블 리로드
            self.searchTableView.reloadData()
            
            // 검색 후 탑바 뷰의 크기를 최소화 할때 아이템 정리
            self.cancelStackView.isHidden = true
            self.removeButton.isHidden = true
            self.searchTableView.isHidden = false
            self.backButton.isHidden = false
            self.searchImageView.isHidden = true
            
            // 키보드 해제
            self.searchTextField.resignFirstResponder()
            
            // 검색 후 탑바 뷰의 크기를 최소화
            UIView.animate(withDuration: 0.3){
                self.searchTopBarHeight.constant = 40
                self.searchTextField.font = UIFont.systemFont(ofSize: 15)
                self.searchTextField.placeholder = "검색"
                self.view.layoutIfNeeded()
            }
            // 테그 컬랙션 뷰의 위치 초기화
            self.searchTableView.contentOffset.y = 0
        })
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData = tagData?.categories[indexPath.item] else { return UICollectionViewCell ()}
        let searchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        // 카테고리 컬랙션 뷰 셀의 카테고리 데이터 적용
        searchCollectionViewCell.category = cellData
        
        return searchCollectionViewCell
    }
    
    // 섹션 헤더뷰 지정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCollectionHeaderView", for: indexPath) as! SearchCollectionHeaderView
        headerView.titleLabel.text = "레스토랑 카테고리"
        return headerView
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.leftPadding + Metric.rightPadding + Metric.nextOffset
        let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
        let height = width * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int ) -> CGFloat {
        return Metric.lineSpacing
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Metric.topPadding, Metric.leftPadding,
                                Metric.bottomPadding, Metric.rightPadding)
    }
    
    // 유동적으로 변하는 탑바의 크기 조절
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            
            // 검색 텍스트 필드 키보드 해제
            searchTextField.resignFirstResponder()
            cancelStackView.isHidden = true
            removeButton.isHidden = true
            
            // 최소 높이와 최대 높이를 지정하여 그 이상으로 변경 될 시에 바꿔주는 함수
            let searchTopBarPoint = maximumTopBarPoint - scrollView.contentOffset.y
            if searchTopBarPoint >= maximumTopBarPoint{
                searchTopBarHeight.constant = maximumTopBarPoint
            }else if searchTopBarPoint <= minimumTopBarPoint{
                searchTopBarHeight.constant = minimumTopBarPoint
            }else{
                searchTopBarHeight.constant = searchTopBarPoint
            }
            // 글자 크기 조절
            searchTextField.font = UIFont.systemFont(ofSize: searchImageView.frame.height - 5)
            
            // 요리 검색
            if searchTopBarHeight.constant <= minimumTopBarPoint{
                self.searchTextField.placeholder = "레스토랑 또는 요리 검색"
                self.searchTextField.font = UIFont.systemFont(ofSize: 15)
            } else {
                self.searchTextField.placeholder = "검색"
                self.searchTextField.font = UIFont.systemFont(ofSize: 25)
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    // 검색 텍스트 필드 초기화
    @IBAction func removeButton(_ sender: Any) {
        searchTextField.text = ""
        removeButton.isHidden = true
        
        UIView.animate(withDuration: 0.3){
            self.searchTopBarHeight.constant = 120
            self.searchTextField.font = UIFont.systemFont(ofSize: 25)
            self.searchTextField.placeholder = "검색"
            self.view.layoutIfNeeded()
        }
        searchTextField.becomeFirstResponder()
    }
    
    // 검색 텍스트 필드 닫기
    @IBAction func cancelButton(_ sender: Any) {
        searchTextField.resignFirstResponder()
        cancelStackView.isHidden = true
        removeButton.isHidden = true
        searchTableView.isHidden = true
    }
    
    // 검색 텍스트 필드에 커서가 가 있을 때 실행 함수
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != ""{ removeButton.isHidden = false }
        
        UIView.animate(withDuration: 0){
            self.cancelStackView.isHidden = false
            self.backButton.isHidden = true
            self.searchImageView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3){
            self.searchTopBarHeight.constant = 120
            self.searchTextField.font = UIFont.systemFont(ofSize: 25)
            self.searchTextField.placeholder = "검색"
            self.view.layoutIfNeeded()
        }
        
        collectionView.contentOffset.y = 0
        
        restaurants = nil
        searchTableView.reloadData()
        searchTextField.becomeFirstResponder()
    }
    
    // 뒤로가기 버튼 - 검색 결과 에서 카테고리 리스트로
    @IBAction func backButton(_ sender: Any) {
        searchTableView.isHidden = true
        backButton.isHidden = true
        searchImageView.isHidden = false
        
        UIView.animate(withDuration: 0.3){
            self.searchTopBarHeight.constant = 120
            self.searchTextField.font = UIFont.systemFont(ofSize: 25)
            self.searchTextField.placeholder = "검색"
            self.searchTextField.text = ""
            self.view.layoutIfNeeded()
        }
    }
    
    // 글자 수 확인 후 리무브 버튼 표시
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        let replaceText = (text as NSString).replacingCharacters(in: range, with: string)
        
        removeButton.isHidden = replaceText.isEmpty
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text{
            searchRestaurantData(searchText: searchText)
        }
        return true
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let restaurantData = restaurants?[indexPath.item] else { return UITableViewCell() }
        let searchTableViewCell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        searchTableViewCell.targetView = self
        searchTableViewCell.restaurant = restaurantData
        return searchTableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let restaurants = self.restaurants {
            let mainHeaderInSection = MainHeaderInSection.loadMainHeaderInSectionNib()
            mainHeaderInSection.headerLabel.text = "결과 \(restaurants.count) 개"
            return mainHeaderInSection
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = self.restaurants {
            return tableView.sectionHeaderHeight
        }
        return CGFloat.leastNormalMagnitude
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        if let cellData = cell.category {
            searchTextField.text = cellData.name
            searchRestaurantData(searchText: cellData.name)
        }
        searchTextField.resignFirstResponder()
        cancelStackView.isHidden = true
        removeButton.isHidden = true
    }
}
