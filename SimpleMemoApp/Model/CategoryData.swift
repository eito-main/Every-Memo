
//カテゴリの型

import Foundation

struct CategoryData: Equatable, Codable {
    

    //UserDefaultsに保存するためのキー
    static let storeKey = "Category"
    //カテゴリ名
    let categoryName: String
    //数
    var quantity: Int

    init(categoryName: String, quantity: Int) {
    
        self.categoryName = categoryName
        self.quantity = quantity
    }
    
    
}
