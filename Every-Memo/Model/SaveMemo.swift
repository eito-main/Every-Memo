
//メモのuserdefaultsに対する処理

import Foundation

final class SaveMemo {
    
    
    private let userDefaults = UserDefaults.standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    //userDefaultsに保存してあるデータをデコードして取得する関数
    internal func allMemos() -> [MemoData] {
        
        guard let data = userDefaults.data(forKey: MemoData.storeKey),
              let Memos = try? jsonDecoder.decode([MemoData].self, from: data) else {
            
            return []
        }
        
        return Memos
    }
    
    //新たなデータをエンコードしてuserDefaultsに保存する関数
    internal func save(memos: [MemoData]) {
        
        guard let data = try? jsonEncoder.encode(memos) else {
            
            return
        }
        userDefaults.set(data, forKey: MemoData.storeKey)
    }
}

