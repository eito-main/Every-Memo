
//UnitTest

import XCTest
@testable import Every_Memo

class Every_MemoTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //SaveMemo
    func testAllMemos() throws {
        let saveMemo = SaveMemo()
        let allMemos = saveMemo.allMemos()
        
        XCTAssertNotNil(allMemos)
        XCTAssertEqual(String(describing: type(of: allMemos)),"Array<MemoData>")
    }
    
    //OperationMemo
    func testAdd() throws {
        let memoData = MemoData(category: "test", date: "test", title: "test", text: "test")
        let operationMemo = OperationMemo()
        let currentMemosCount = operationMemo.currentMemos.count
        operationMemo.add(memo: memoData)
        
        XCTAssertEqual(operationMemo.currentMemos.count, currentMemosCount + 1)
        
        //後処理（※）
        operationMemo.deleteMemo(for: memoData.id)
    }
    
    func testDeleteMemo() throws {
        let memoData = MemoData(category: "test", date: "test", title: "test", text: "test")
        let id = memoData.id
        let operationMemo = OperationMemo()
        operationMemo.add(memo: memoData)
        let currentMemosCount = operationMemo.currentMemos.count
        operationMemo.deleteMemo(for: id)
        
        XCTAssertEqual(operationMemo.currentMemos.count, currentMemosCount - 1)
    }
    
    func testUpdateMemo() throws {
        let preMemoData = MemoData(category: "test", date: "test", title: "test", text: "test")
        let id = preMemoData.id
        let operationMemo = OperationMemo()
        operationMemo.add(memo: preMemoData)
        guard let index = operationMemo.currentMemos.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        XCTAssertEqual(operationMemo.currentMemos[index],preMemoData)
        
        var postMemoData = preMemoData
        postMemoData.category = "change"
        operationMemo.updateMemo(for: id, to: postMemoData)
        
        XCTAssertNotEqual(operationMemo.currentMemos[index],preMemoData)
        XCTAssertEqual(operationMemo.currentMemos[index],postMemoData)
        
        //後処理（※）
        operationMemo.deleteMemo(for: id)
    }
    
    //OperationCategory
    func testAddOperationCategory() throws {
        let operationCategory = OperationCategory()
        let categoryCount = operationCategory.currentCategorys.count
        operationCategory.add(newCategory: "test")
        
        XCTAssertEqual(operationCategory.currentCategorys[categoryCount],"test")
        
        operationCategory.delete(num: categoryCount-1)
    }
    
    func testDelete() throws {
        let operationCategory = OperationCategory()
        let categoryCount = operationCategory.currentCategorys.count
        operationCategory.add(newCategory: "test")
        
        XCTAssertEqual(operationCategory.currentCategorys[categoryCount],"test")
        
        operationCategory.delete(num: categoryCount)
        
        XCTAssertEqual(categoryCount,operationCategory.currentCategorys.count)
    }
    
    func testCategoryCount() throws {
        let operationMemo = OperationMemo()
        let operationCategory = OperationCategory()
        let category = "test"
        let memoData = MemoData(category: category, date: "test", title: "test", text: "test")
        operationMemo.add(memo: memoData)
        let matchCategory = operationMemo.currentMemos.filter({ element in element.category == category})
        let testMatchCategory = operationCategory.categoryCount(currentMemo: operationMemo.currentMemos, category: category)
        
        XCTAssertEqual(matchCategory.count, testMatchCategory)
        
        //後処理（※）
        operationMemo.deleteMemo(for: memoData.id)
    }
    
    //    //AddMemoViewController
    //    func testGetDate() throws {
    //
    //    }
    //
    //    func testTouchedLabel() throws {
    //
    //    }
    //
    //    func testGetCategoryName() throws {
    //
    //    }
    //
    //    //CalenderViewController
    //    func testOperationFormatter() throws {
    //
    //    }
    //
    //    func testDisplayMemoChange() throws {
    //
    //    }
    //
    //    //SearchViewController
    //    func testSearchBarSearchButtonClicked() throws {
    //
    //    }
    //
    //    //TitleListViewController
    //    func testMemoListUpdate() throws {
    //
    //    }
    //
    //    //MemoViewController
    //    func testEditButtonTapped() throws {
    //
    //    }
    //
    //    func testTouchedLabelMemoViewController() throws {
    //
    //    }
    //
    //    func testGetCategoryNameMemoViewController() throws {
    //
    //    }
}
