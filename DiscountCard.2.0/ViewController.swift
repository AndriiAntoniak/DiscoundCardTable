//
//  ViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{
    
    
    
    var cardManager = CardManager()
    
    var discountCard : [Card] = []
     var filterCard : [Card] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: SEARCH
    @IBOutlet var searchBar: UISearchBar!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discountCard = cardManager.returnCard()
        filterCard = discountCard
    }
    
    
    @IBAction func updateTableView(_ sender: Any) {
        for filter in filterColorDictionary{
            filter.key.backgroundColor = UIColor.white
        }
        discountCard = cardManager.returnCard()
        searchController.searchBar.text = ""
        searchController.isActive = false
        tableView.reloadData()
        //
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //
        
        //
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search by title"

        //
        fillDictionary()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromCellToPhoto", sender: discountCard[indexPath.row])
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
        cell.colorFilter?.backgroundColor = installColorForFilter(card:card)
        cell.backImage?.image = cardManager.loadImageFromPath(path:  card.backImage!)
        cell.frontImage?.image = cardManager.loadImageFromPath(path: card.frontImage!)
        
        
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
        }else if segue.identifier == "fromCellToPhoto"{
            let scrollPhotoView = segue.destination as! CardPhotoViewController
            scrollPhotoView.selectCard = sender as? Card
        }
    }
    
    
    
    
    //MARK: color filter
    
    @IBOutlet weak var redColorFilter: UIButton!
    
    @IBOutlet weak var orangeColorFilter: UIButton!
    
    @IBOutlet weak var yellowColorFilter: UIButton!
    
    @IBOutlet weak var greenColorFilter: UIButton!
    
    @IBOutlet weak var blueColorFilter: UIButton!
    
    @IBOutlet weak var violetColorFilter: UIButton!

    
    @IBAction func colorFilterPressed(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.white ? sender.borderColor : UIColor.white
        filterCardByColor()
        tableView.reloadData()
    }
    
    
    //function for color filter
    func filterCardByColor(){
        var choosenCard :[Card] = []
        var colorReview = false
        for filter in filterColorDictionary{
            if filter.key.backgroundColor != UIColor.white{
                colorReview = true
                choosenCard += filterCard.filter( { (this)-> Bool in
                    return (this.filterColor!.contains(filter.value))
                })
                discountCard = choosenCard
        }
        if colorReview == false{
            discountCard = filterCard
            }
        }
   //     colorCard = discountCard
    }
    
    public var filterColorDictionary :[UIButton:String] = [:]
    func fillDictionary(){
        filterColorDictionary[redColorFilter] = "Red"
        filterColorDictionary[orangeColorFilter] = "Orange"
        filterColorDictionary[yellowColorFilter] = "Yellow"
        filterColorDictionary[greenColorFilter] = "Green"
        filterColorDictionary[blueColorFilter] = "Blue"
        filterColorDictionary[violetColorFilter] = "Violet"
    }
    
 //   var isSearched = false
 //   var colorCard : [Card] = []
//    var cardForFilteringByColor : [Card] = []
    func updateSearchResults(for searchController: UISearchController) {
       
        if searchController.searchBar.text! == "" {
            discountCard = cardManager.returnCard()
            filterCardByColor()
            tableView.reloadData()
        }else{
            searchCardByTitle(text: searchController.searchBar.text!)
        }
    }
    
    
    func searchCardByTitle(text: String){
        discountCard = filterCard.filter( { (this)-> Bool in
            return (this.title?.lowercased().contains(text.lowercased()))!
        })
        tableView.reloadData()
    }
    
    
    
    
    
    
}//END VIEWCONTROLLER

