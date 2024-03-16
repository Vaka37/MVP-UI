// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

/// создание обновления удаление
public final class CoreDataManager {
    public static let shared = CoreDataManager()
    private init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    func createRecipe(_ label: String, image: String, calories: Int64, totalTime: Double, uri: String) {
        let recipeEntityDescription = NSEntityDescription.entity(forEntityName: "RecipeData", in: context)
    }
}
