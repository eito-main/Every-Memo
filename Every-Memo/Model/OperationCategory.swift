
//カテゴリ一覧のuserdefaultsに対する操作

import Foundation

final class OperationCategory {
    
    
    static let categoryStoreKey = "categoryKey"
    
    private let ud = UserDefaults.standard
    private(set) var currentCategorys: [String] = [] {
        didSet {
            ud.set(currentCategorys as [Any], forKey: OperationCategory.categoryStoreKey)
        }
    }
    
    init() {
        if ud.array(forKey: OperationCategory.categoryStoreKey) == nil {
            add(newCategory: "カテゴリー未指定")
        }
        
        currentCategorys = ud.array(forKey: OperationCategory.categoryStoreKey) as! [String]
    }
    
    func delete(num: Int) {
        
        currentCategorys.remove(at: num)
    }
    
    func add(newCategory: String) {
        
        currentCategorys.append(newCategory)
    }
    
    func categoryCount(currentMemo: [MemoData], category: String) -> Int {
        
        var categoryCount: Int = 0
        
        if currentMemo.count != 0 {
            for count in 0...currentMemo.count - 1 {
                
                if category == currentMemo[count].category {
                    categoryCount += 1
                }
            }
        }
        return categoryCount
    }
}
