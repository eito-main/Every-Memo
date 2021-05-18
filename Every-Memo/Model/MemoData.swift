
//メモの型

import Foundation

struct MemoData: Equatable, Codable {
    
    
    internal static let storeKey = "Memo"
    
    internal let id: String
    internal var category: String
    internal var date: String
    internal var title: String
    internal var text: String
    
    init(id: String = UUID().uuidString, category: String, date: String, title: String, text: String) {
    
        self.id = id
        self.category = category
        self.date = date
        self.title = title
        self.text = text
    }
}
