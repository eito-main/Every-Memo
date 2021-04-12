
//カテゴリの追加、更新、削除等のクラス

import Foundation

final class OperationCategory {
    
    private let saveCategory: SaveCategory
    //デコードされたカテゴリ一覧
    private(set) var currentCategorys: [CategoryData] {
        //値が更新されるたび保存するための処理
        didSet {
            saveCategory.save(categorys: currentCategorys)
        }
    }
    
    //初期化
    init() {
        saveCategory = SaveCategory()
        currentCategorys = saveCategory.allCategory()
    }
    
    //デコードされたカテゴリ一覧に新たなカテゴリを追加するメソッド
    func add(category: CategoryData) {
        
        currentCategorys.append(category)
    }
    
    //指定したカテゴリを削除するメソッド
    func deleteCategory(for categoryName: String) {
        
        guard let index = currentCategorys.firstIndex(where: { $0.categoryName == categoryName }) else {
            
            return
        }
        currentCategorys.remove(at: index)
    }
    
    //変更したカテゴリを上書きするメソッド
    func updateMemo(for categoryName: String, to newCategory: CategoryData) {
        
        guard let index = currentCategorys.firstIndex(where: { $0.categoryName == categoryName }) else {
            
            return
        }
        currentCategorys[index] = newCategory
    }
   
    
}
