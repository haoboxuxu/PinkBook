//
//  POIVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import UIKit


class POIVC: UIViewController {
    
    private let locationManager = AMapLocationManager()
    private var pois = [["不显示位置", ""]]//[Array(repeating: "", count: 2)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //   定位超时时间，最低2s，此处设置为2s
        locationManager.locationTimeout = 5
        //   逆地理请求超时时间，最低2s，此处设置为2s
        locationManager.reGeocodeTimeout = 5
        
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let poivcSelf = self else { return }
            
            if let location = location {
                print("location:", location)
            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
                
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                
                //直辖市
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                //cell总地址
                let currentPOI = [
                    reGeocode.poiName!,
                    "\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"
                ]
                poivcSelf.pois.append(currentPOI)
            }
        })
        
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
