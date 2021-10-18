//
//  AcronymViewModel.swift
//  AcronymApp
//
//  Created by Sohel Bukhari on 10/17/21.
//

import Foundation

class AcronymViewModel: NSObject {
    var reloadTableView: (() -> Void)?
    private var acronymService = FetchService()
    var acronymViewModels = [AcronymCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getAcronymsFor(sf: String) {
        acronymService.fetchData(sf: sf, completion: { success, model, error in
            if success, let forms = model {
                var lfList = [AcronymCellViewModel]()
                for lfs in forms.lfs{
                    lfList.append(AcronymCellViewModel(longForm: lfs.lf))
                }
                self.acronymViewModels = lfList
            } else {
                print(error as Any)
            }
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> AcronymCellViewModel {
        return acronymViewModels[indexPath.row]
    }
}
