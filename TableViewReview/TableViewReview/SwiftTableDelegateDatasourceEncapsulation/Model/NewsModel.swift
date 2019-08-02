//
//  NewsModel.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit
/*
 Swift: 实现JSON转Model - HandyJSON
 https://www.jianshu.com/p/e9d933ce7c74
 */
import HandyJSON

struct Ext_action: HandyJSON {
    var fimgurl30: String?
    var fimgurl33: String?
    var fimgurl32: String?
}

struct Ext_data: HandyJSON {
    var src: String?
    var desc: String?
    var ext_action: Ext_action?
}

struct Newslist: HandyJSON {
    var ext_data: Ext_data?
    var source: String?
    var time: String?
    var title: String?
    var url: String?
    var videoTotalTime: String?
    var thumbnails_qqnews: [String]?
    var abstract: String?
    var imagecount: Int = 0
    var origUrl: String?
    var graphicLiveID: String?
    var uinnick: String?
    var flag: String?
    var tag: [String]?
    var voteId: String?
    var articletype: String?
    var voteNum: String?
    var qishu: String?
    var id: String?
    var timestamp: Int = 0
    var commentid: String?
    var comments: Int = 0
    var weiboid: String?
    var comment: String?
    var uinname: String?
    var surl: String?
    var thumbnails: [String]?
}

class NewsModel :HandyJSON {
    var ret: Int = 0
    var newslist: [Newslist]?
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["newslist": Newslist.self]
    }
    
    required init() {}
}
