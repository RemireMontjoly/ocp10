//
//  FavoriteRepositoryTestCase.swift
//  RecipleaseTests
//
//  Created by pith on 11/03/2020.
//  Copyright © 2020 dino. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteRepositoryTestCase: XCTestCase {

    var sut: FavoriteRepository!

    override func setUp() {
        super.setUp()
        // DI
        sut = FavoriteRepository(container: mockPersistentContainer)
        initStubs()

        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)),name: NSNotification.Name.NSManagedObjectContextDidSave,object: nil)

    }

    override func tearDown() {
        flushData()
    }

    func test_Fetch_All_RecipeFav() {
        //Given a storage with two RecipeFav objects (from setup)

        //When fetch
        let results = sut.getRecipeFav()

        //Assert return two RecipeFav in store
        XCTAssertEqual(results.count, 2)
    }

    func test_addRecipeToFav() {
        //Given the total count of items in RecipeFav array
        let items = numberOfItemsInPersistentStore()

        //When adding a recipe to fav.
        let recipe = Recipe(label: "", image: "", url: "", ingredientLines: [""], yield: 1, totalTime: 1)
        sut.addRecipeToFav(recipeFav: recipe)

        //Then assert RecipeFav count += 1
        let itemsAfterAdding = numberOfItemsInPersistentStore()
        XCTAssertEqual(itemsAfterAdding, items + 1)
    }

    func test_delete() {
        //Given two items (after setup()/initStub()) in persistent store.
        let items = sut.getRecipeFav()
        let item = items[0]
        let numberOfItems = items.count

        //When remove an item (of two)
        sut.delete(object: item)

        //Then assert number of items == 1
        XCTAssertEqual(numberOfItems - 1, 1)
    }

    func test_save() {
        //Given a recipe item
        let recipe = Recipe(label: "", image: "", url: "", ingredientLines: [""], yield: 1, totalTime: 1)

        let expect = expectation(description: "Context Saved")

        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        sut.addRecipeToFav(recipeFav: recipe)

        //When save
        sut.save()

        //Then assert there is 3 items in store
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertTrue(self.numberOfItemsInPersistentStore() == 3)
            XCTAssertNil(error, "Save did not occur")// comptage nombre items.
        }
    }

    //MARK: mock in-memory persistent store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Reciplease", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        return managedObjectModel
    }()

    lazy var mockPersistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        // description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // check if the data store is in-memory type
            precondition(description.type == NSInMemoryStoreType)
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    //MARK: Create some fakes
    func initStubs() {

        let recipeTest = RecipeFav(context: mockPersistentContainer.viewContext)

        recipeTest.image = "image1"
        recipeTest.ingredients = ["ingredients1"]
        recipeTest.label = "label1"
        recipeTest.url = "url1"
        recipeTest.totalTime = 1
        recipeTest.yield = 1

        let recipeTest2 = RecipeFav(context: mockPersistentContainer.viewContext)

        recipeTest2.image = "image1"
        recipeTest2.ingredients = ["ingredients1"]
        recipeTest2.label = "label1"
        recipeTest2.url = "url1"
        recipeTest2.totalTime = 1
        recipeTest2.yield = 1

        do {
            try mockPersistentContainer.viewContext.save()
        } catch {
            print("Creates fakes error: \(error)")
        }
    }

    //MARK: Convenient functions:
    // for notification
    var saveNotificationCompleteHandler: ((Notification)->())?

    func contextSaved(notification: Notification) {
        saveNotificationCompleteHandler?(notification)
    }

    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }

    // for flushing the data from in-memory store
    func flushData() {

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeFav")
        let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistentContainer.viewContext.delete(obj)
        }
        try! mockPersistentContainer.viewContext.save()
    }

    //Convenient method for getting the number of data in store now
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RecipeFav")
        let results = try! mockPersistentContainer.viewContext.fetch(request)
        return results.count
    }

}
