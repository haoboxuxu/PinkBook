//
//  POIVC-KeywordsSearch.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/12.
//


extension POIVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pois = aroundSearchPois
            //取消search，重制监听对象
            setAroundSearchFooter()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        keywords = searchText
        pois.removeAll()
        
        //重新搜索，重置页码
        currentKeywordPage = 1
        
        setKeywordSearchFooter()
        
        showLoadHUD()
        makeKeywordSearch(keywords)
    }
}

extension POIVC: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        hideLoadHUD()
        
        if response.count > kPOIoffset {
            pagesCount = Int(ceil(Double(response.count) / Double(kPOIoffset)))
        } else {
            footer.endRefreshingWithNoMoreData()
        }
        
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

// poi search请求
extension POIVC {
    private func makeKeywordSearch(_ keywords: String, _ page: Int = 1) {
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    
    private func setKeywordSearchFooter() {
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordSearchPullToRefresh))
    }
}


// 上滑监听
extension POIVC {
    @objc private func keywordSearchPullToRefresh() {
        currentKeywordPage += 1
        makeKeywordSearch(keywords, currentKeywordPage)
        endRefreshing(currentKeywordPage)
    }
}
