//
//  POIVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import UIKit


class POIVC: UIViewController {
    
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        //request.types = kPOITypes
        request.requireExtension = true
        
        return request
    }()
    
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        return request
    }()
    
    
    var pois = kPOIsInitArr //[Array(repeating: "", count: 2)]
    var aroundSearchPois = kPOIsInitArr
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var keywords = ""
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        requestLocation()
        
        mapSearch?.delegate = self
    }

}

extension POIVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pois = aroundSearchPois
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        keywords = searchText
        pois.removeAll()
        showLoadHUD()
        keywordsSearchRequest.keywords = keywords
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
}

extension POIVC: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        hideLoadHUD()
        
        if response.count == 0 {
            return
        }
        
        for poi in response.pois {
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(address.unwrappedText)"
            ]
            
            pois.append(poi)
            
            if request is AMapPOIAroundSearchRequest {
                aroundSearchPois.append(poi)
            }
        }
        
        tableView.reloadData()
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
        return cell
    }
}

extension POIVC: UITableViewDelegate {
    
}
