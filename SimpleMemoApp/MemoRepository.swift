
//UserDefaultsに対するCRUD操作を担うclassです。

import Foundation

final class MemoRepository {
    
    private let userDefaults = UserDefaults.standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    //userDefaultsに保存してあるデータをデコードして取得する関数
    func allMemos() -> [MemoData] {
        
        guard let data = userDefaults.data(forKey: MemoData.storeKey),
              let Memos = try? jsonDecoder.decode([MemoData].self, from: data) else {
            
            return []
        }
        
        return Memos
    }
    
    //新たなデータをエンコードしてuserDefaultsに保存する関数
    func save(memos: [MemoData]) {
        
        guard let data = try? jsonEncoder.encode(memos) else {
            
            return
        }
        userDefaults.set(data, forKey: MemoData.storeKey)
    }
    
}

