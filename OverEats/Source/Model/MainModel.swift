//
//  MainModel.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 2..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct Notice {
    var id: Int!
    var title: String?
    var subTitle: String?
    var imageURL: String!
}

struct Restaurant {
    var id: Int!
    var name: String!
    var tag: [String]
    var score: Float!
    var time: Int!
    var account: String?
    var imageURL: String!
}
