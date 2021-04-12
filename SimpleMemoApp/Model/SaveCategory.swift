

import Foundation

final class SaveCategory {
    
    private let userDefaults = UserDefaults.standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    //userDefaultsに保存してあるデータをデコードして取得する関数
    func allCategory() -> [CategoryData] {
        
        guard let data = userDefaults.data(forKey: CategoryData.storeKey),
              let categorys = try? jsonDecoder.decode([CategoryData].self, from: data) else {
            
            return []
        }
         
        return categorys
    }
    
    //新たなデータをエンコードしてuserDefaultsに保存する関数
    func save(categorys: [CategoryData]) {
        
        guard let data = try? jsonEncoder.encode(categorys) else {
            
            return
        }
        userDefaults.set(data, forKey: CategoryData.storeKey)
    }
}
