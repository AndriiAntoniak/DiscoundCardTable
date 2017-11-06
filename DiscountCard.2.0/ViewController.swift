//
//  ViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    
    var cardManager = CardManager()
    
    var discountCard : [Card] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        discountCard = cardManager.returnCard()
        print("discountCard=\(discountCard.count)")
        
    }
    
    
    
    @IBAction func updateTableView(_ sender: Any) {
        discountCard = cardManager.returnCard()
        tableView.reloadData()
        
        //TODO: all properties of searching and sorting must refresh!!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //
        filterCollection.append(redColorFilter)
        filterCollection.append(orangeColorFilter)
        filterCollection.append(yellowColorFilter)
        filterCollection.append(greenColorFilter)
        filterCollection.append(blueColorFilter)
        filterCollection.append(violetColorFilter)
        
    }
    
    @IBAction func add(_ sender: UIButton) {
        print("go add")
        //let ccc = Card(context: CardManager.getContext())
        let ccc = Card()
        
        ccc.title = "ATB"
        ccc.backImage = nil
        ccc.barcode = nil
        ccc.date = Date()
        ccc.descriptionCard = "lol"
        ccc.filterColor = "qwe"
        ccc.frontImage = nil
        
        CardManager.SaveCard()
        
        tableView.reloadData()
        print("all is good")
    }
    
    
    
    
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discountCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = discountCard[indexPath.row]
        print(indexPath.row)
        let cell  = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CardTableCell
        
        cell.cardTitle?.text = card.title
        cell.cardDate?.text = DateFormatter.localizedString(from: card.date! as Date , dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
        cell.colorFilter?.text = card.filterColor
        cell.colorFilter?.backgroundColor = installColorForFilter(card:card)
        cell.backImage?.image = nil
        cell.frontImage?.image = nil
        
        
        return cell
    }
    
    func installColorForFilter(card:Card)->UIColor{
        switch card.filterColor{
        case "Red"?: return UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        case "Orange"?:return UIColor.orange
        case "Yellow"?:return UIColor(red: 255, green: 255, blue: 0, alpha: 1.0)
        case "Green"?:return UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
        case "Blue"?:return UIColor(red: 0, green: 0, blue: 255, alpha: 1.0)
        case "Violet"?: return UIColor.purple
        default:break
        }
        return UIColor.clear
    }
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "EditToCard", sender: self.discountCard[indexPath.row])
            
        }
        editAction.backgroundColor = .blue
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            //TODO:
            
        }
        shareAction.backgroundColor = .green
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.cardManager.deleteCard(card: self.discountCard[indexPath.row])
            self.discountCard.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        return [editAction, shareAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToCard"{
            let addEdit = segue.destination as! AddEditTableViewController
            addEdit.editCard = sender as? Card
        }
    }
    
    
    
    
    //MARK: color filter
    
    @IBOutlet weak var redColorFilter: UIButton!
    
    @IBOutlet weak var orangeColorFilter: UIButton!
    
    @IBOutlet weak var yellowColorFilter: UIButton!
    
    @IBOutlet weak var greenColorFilter: UIButton!
    
    @IBOutlet weak var blueColorFilter: UIButton!
    
    @IBOutlet weak var violetColorFilter: UIButton!
    
    var filterCollection :[UIButton] = []
    
    
    @IBAction func colorFilterPressed(_ sender: UIButton) {
        
        sender.backgroundColor = sender.backgroundColor == UIColor.white ? sender.borderColor : UIColor.white
        
        
        //TODO: HERE must be FILTER !!!!!
    }
    
    
}//END VIEWCONTROLLER

