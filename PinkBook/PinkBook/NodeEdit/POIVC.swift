//
//  POIVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import UIKit
import MJRefresh


class POIVC: UIViewController {
    
    // poi反向传数
    var delegate: POIVCDelegate?
    // poi正向传数
    var poiName = ""
    
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        //request.types = kPOITypes
        request.requireExtension = true
        request.offset = kPOIoffset
        return request
    }()
    
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        request.offset = kPOIoffset
        return request
    }()
    
    lazy var footer = MJRefreshAutoNormalFooter()
    
    var pois = kPOIsInitArr //[Array(repeating: "", count: 2)]
    var aroundSearchPois = kPOIsInitArr
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var keywords = ""
    var currentAroundPage = 1
    var currentKeywordPage = 1
    var pagesCount = 1
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        requestLocation()
    }

}



extension POIVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        //正向已选地址
        if poi[0] == poiName {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}

extension POIVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        delegate?.updatePOIBName(pois[indexPath.row][0])
        dismiss(animated: true)
    }
}


extension POIVC {
    func endRefreshing(_ currentPage: Int) {
        //滑到底部了
        if currentPage < pagesCount {
            footer.endRefreshing()
        } else {
            footer.endRefreshingWithNoMoreData()
        }
    }
}
