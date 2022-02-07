//
//  Constants.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/1.
//

import UIKit

// MARK: StoryBoard
let kFollowVCID = "FollowVCID"
let kNearByVCID = "NearByVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kWaterFallVCID = "WaterFallVCID"
let kNoteEditVCID = "NoteEditVCID"
let kChannelTabelVCID = "ChannelTabelVCID"
let kLoginNavID = "LoginNavID"

// MARK: Cell
let kWaterFallCellID = "WaterFallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterFallCellID = "DraftNoteWaterFallCellID"

// MARK: Assets
let mainColor = UIColor(named: "main")!
let mainLightColor = UIColor(named: "main-light")!
let bluedColor = UIColor(named: "blued")!
let imagePH = UIImage(named: "imagePH")!

// MARK: Userdefaults
let kNameFromAppleID = "NameFromAppleID"
let kEmailFromAppleID = "EmailFromAppleID"

// MARK: CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext()

// MARK: UI
let screenRect = UIScreen.main.bounds
let kDraftNoteWFCellBottomViewH: CGFloat = 200

// MARK: 业务
let kChannels = ["推荐", "旅行", "娱乐", "才艺", "美妆", "白富美", "美食", "萌宠"]
let kMaxPhotoCount = 9


// MARK: YPImagePicker
let kWaterFallPadding: CGFloat = 4
let kMaxCameraZoomFactor: CGFloat = 5.0
let kSpacingBetweenItems: CGFloat = 2.0

// MARK: NoteEidtPage
let kMaxNoteTitleCount = 20
let kMaxNoteTextCount = 1000

let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]

// MARK: 高德
let kNoPOIPH = "未知地点"
let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOIsInitArr = [["不显示位置", ""]]
let kPOIoffset = 20

// MARK: key
let kJappKey = _private_kJappKey //极光一件登陆
let kAmapKey = _private_kAmapKey //高德地图
let kAlipayAppID = _private_kAlipayAppID
let kAlipayPID = _private_kAlipayPID
let kAlipayPrivateKey = _private_kAlipayPrivateKey //私钥
let kAppScheme = "PinkBook"
let kLCAppID = _kLCAppID //leancloud
let kLCAppKey = _kLCAppKey //leancloud
let kLCServerURL = _kLCServerURL //leancloud

// regular
let kPhoneRegEx = "^1\\d{10}$"
