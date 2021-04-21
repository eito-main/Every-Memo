
//メモの型

import Foundation

struct MemoData: Equatable, Codable {
    
    
    static let storeKey = "Memo"
    
    let id: String
    var category: String
    var date: String
    var title: String
    var text: String
    
    init(id: String = UUID().uuidString, category: String, date: String, title: String, text: String) {
    
        self.id = id
        self.category = category
        self.date = date
        self.title = title
        self.text = text
    }
}
