//
//  UbikeViewModel.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import Foundation
import Combine

enum UbikeError: Error {
    case invalidURL
    case decodeFail
    case responseError
}

class UbikeViewModel {
    @Published var ubikeDataSource = [String : [String]]()
    private(set) var isLoading = PassthroughSubject<Bool, Never>()
    
    func fetchUbike() {
        self.isLoading.send(true)
        let endpoint = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
        
        guard let url = URL(string: endpoint) else {
            print("nope")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode([UbikeModel].self, from: data)
                        self.ubikeDataSource = self.convertToDict(data: data)
                } catch {
                    print("false")
                }
            } else {
                print("nope")
            }
            self.isLoading.send(false)
        }.resume()
    }
    
    private func convertToDict(data: [UbikeModel]) -> [String : [String]] {
        //依區域分類 -> [區域:[站點名稱]]
        var dict = [String : [String]]()
        data.forEach {
            //NOTE: na內有"Youbike2.0_XXX"和"Youbike2.0_XXX_1"兩種樣式，分割後取index為1的站點名稱
            let site = $0.na.components(separatedBy: "_")
            if dict[$0.area]?.isEmpty ?? true {
                dict[$0.area] = [site[1]]
            } else {
                dict[$0.area]?.append(site[1])
            }
        }
        return dict
    }
}
