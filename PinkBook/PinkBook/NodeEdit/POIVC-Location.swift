//
//  POIVC-Location.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/10.
//


extension POIVC {
    func requestLocation() {
        showLoadHUD()
        
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    //print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    //print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                } else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let poivcSelf = self else { return }
            
            if let location = location {
                poivcSelf.latitude = location.coordinate.latitude
                poivcSelf.longitude = location.coordinate.longitude
                
                // 上拉刷poi
                poivcSelf.setAroundSearchFooter()
                // 检索周边POI
                poivcSelf.makeAroundSearch()
            }
            
            if let reGeocode = reGeocode {
                
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                
                //直辖市
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province.unwrappedText
                //cell总地址
                let currentPOI = [
                    reGeocode.poiName ?? kNoPOIPH,
                    "\(province)\(reGeocode.city.unwrappedText)\(reGeocode.district.unwrappedText)\(reGeocode.street.unwrappedText)\(reGeocode.number.unwrappedText)"
                ]
                poivcSelf.pois.append(currentPOI)
                poivcSelf.aroundSearchPois.append(currentPOI)
                
                DispatchQueue.main.async {
                    poivcSelf.tableView.reloadData()
                }
            }
        })
    }
}

// poi search请求
extension POIVC {
    private func makeAroundSearch(_ page: Int = 1) {
        aroundSearchRequest.page = page
        mapSearch?.aMapPOIAroundSearch(aroundSearchRequest)
    }
    
    func setAroundSearchFooter() {
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(aroundSearchAutoRefresh))
    }
}


// 上滑监听
extension POIVC {
    @objc private func aroundSearchAutoRefresh() {
        currentAroundPage += 1
        makeAroundSearch(currentAroundPage)
        endRefreshing(currentAroundPage)
    }
}
