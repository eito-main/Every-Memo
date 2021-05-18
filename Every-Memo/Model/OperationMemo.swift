
//メモの追加、更新、削除等のクラス

import Foundation

final class OperationMemo {
    
    
    private let saveMemo: SaveMemo
    private(set) var currentMemos: [MemoData] {
        
        didSet {
            saveMemo.save(memos: currentMemos)
        }
    }
    
    init() {
        
        saveMemo = SaveMemo()
        currentMemos = saveMemo.allMemos()
    }
    
    internal func add(memo: MemoData) {
        
        currentMemos.append(memo)
    }
    
    internal func deleteMemo(for id: String) {
        
        guard let index = currentMemos.firstIndex(where: { $0.id == id }) else {
            
            return
        }
        currentMemos.remove(at: index)
    }
    
    internal func updateMemo(for id: String, to newMemo: MemoData) {
        
        guard let index = currentMemos.firstIndex(where: { $0.id == id }) else {
            
            return
        }
        
        currentMemos[index] = newMemo
    }
}
