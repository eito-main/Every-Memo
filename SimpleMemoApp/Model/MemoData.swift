
//メモの型

import Foundation

struct MemoData: Equatable, Codable {
    
    //UserDefaultsに保存するためのキー
    static let storeKey = "Memo"
    
    //個々のMemoDataを区別するためのもの
    let id: String
    //カテゴリー
    var category: String
    //日付（初めの日付を保持したいためlet）
    let date: String
    //タイトル
    var title: String
    //テキスト
    var text: String
    
    
    init(id: String = UUID().uuidString, category: String, date: String, title: String, text: String) {
    
        self.id = id
        self.category = category
        self.date = date
        self.title = title
        self.text = text
        
    }
    
    
}
