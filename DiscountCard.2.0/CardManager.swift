//
//  CardManager.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class CardManager{
    
    
    
    private let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
    
    private static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    
    private static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public static func getContext()->NSManagedObjectContext{
        return CardManager.context
    }
    
    static func SaveCard() {
        try? CardManager.context.save()
    }
    
    func returnCard()->[Card]{
        var discountCard : [Card] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        do {
            discountCard = try CardManager.context.fetch(fetchRequest) as! [Card]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        try?  CardManager.context.save()
        return discountCard
    }
    
    
    static func deleteCard(card:Card){
        CardManager.context.delete(card)
        try? CardManager.context.save()
    }
    
    
        
        func fetchData(filter: String?) -> [Card]{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName :"Card")
            if filter != nil && filter != "" {
                fetchRequest.predicate = NSPredicate(format: "filter == %@", filter!)
                var cardArray:[Card] = []
                do{
                    cardArray = (try CardManager.context.fetch(Card.fetchRequest()) as? [Card])!
                } catch {
                    print("Error fetch")
                }
                return cardArray
            } else {
                print("LIKE NIL FILTER")
                do {
                    var cardArray: [Card] = []
                    cardArray = try CardManager.context.fetch(Card.fetchRequest()) as! [Card]
                    return cardArray
                } catch {
                    let cardArray: [Card] = []
                    return cardArray
                }
                
            }
            
            
        }
    
    //TODO: Must be my photo saver
    
    func addToUrl (_ photo: UIImage )  -> String {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let uuidStringforURL = UUID().uuidString + ".jpg"
        let imgPath = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent(uuidStringforURL))// Change extension if you want to save as PNG
        let imageString = String(describing: imgPath)
        print(imageString)
        do{
            try UIImageJPEGRepresentation(photo, 1.0)?.write(to: imgPath, options: .atomic)
        }catch let error{
            print(error.localizedDescription)
        }
        return uuidStringforURL
        
    }
    func loadImageFromPath(path: String) -> UIImage? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imageURL = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent(path))
        do {
            let imageData = try Data(contentsOf: imageURL)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
    
    
    
}//END CardManager

