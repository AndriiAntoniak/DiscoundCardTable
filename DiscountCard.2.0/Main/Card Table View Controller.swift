//
//  ViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class CardTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating,UIPopoverPresentationControllerDelegate, CardSortDelegate{
    
    
    
    //
    var quickActionBarcode : UIImage?
    var quickActionDescription : String?
    //
    
    
    var cardManager = CardManager()
    
    var discountCard : [Card] = []
    var filterCard : [Card] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var settingsBurButtonItem: UIBarButtonItem!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discountCard = cardManager.returnCard()
        filterCard = discountCard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTheme()
        self.view.backgroundColor(theme:theme)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search by title"
        
        fillDictionary()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToCard"{
            let addEdit = segue.destination as! AddEditTableViewController
            addEdit.editCard = sender as? Card
        }else if segue.identifier == "fromCellToPhoto"{
            let scrollPhotoView = segue.destination as! CardPhotoViewController
            scrollPhotoView.selectCard = sender as? Card
        }else if segue.identifier == "FromTableToPopOver"{
            let popOver = segue.destination as? PopOverViewController
            popOver?.preferredContentSize = CGSize(width: view.frame.width / 5.0, height: view.frame.height / 4.0)
            popOver?.popoverPresentationController?.delegate = self
            popOver?.delegate = self
        }
    }
    
    //func for presentation as popOver
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    
    
    //func for updating table
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
    
    //func for using 3DTouch
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.forceTouchCapability {
        case .available:
            registerForPreviewing(with: self, sourceView: tableView)
        default:break
        }
    }
    
    //func for installing theme
    func currentTheme(){
        let defaults = UserDefaults.standard
        let currentTheme = defaults.object(forKey: "currentTheme") as! String?
        
        if let _ = currentTheme{
            switch currentTheme!{
            case "light": theme = .light
            case "dark": theme = .dark
            default:break
            }
        }
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
        cell.cardDate?.text = DateFormatter.localizedString(from: card.date! as Date , dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
        cell.colorFilter?.backgroundColor = installColorForFilter(card:card)
        cell.backImage?.image = cardManager.loadImageFromPath(path:  card.backImage!)
        if let _ = card.descriptionCard{
            cell.cardDescription = card.descriptionCard
        }else{
            cell.cardDescription = ""
        }
        cell.frontImage?.image = cardManager.loadImageFromPath(path: card.frontImage!)
        cell.frontImage?.layer.cornerRadius = 20
        cell.frontImage?.clipsToBounds = true
        return cell
    }
    
    
    //func for chossing color filter
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
    
    
    //MARK: Table view functions
    
    //func for select cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromCellToPhoto", sender: discountCard[indexPath.row])
    }
    
    //func for swipe cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            
            CardManager.deleteCard(card: self.discountCard[indexPath.row])
            self.discountCard.remove(at: indexPath.row)
            tableView.reloadData()
            
            completionHandler(true)
        }
        let share = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            
            let activityVC = UIActivityViewController(activityItems: [self.cardManager.loadImageFromPath(path: self.discountCard[indexPath.row].frontImage!) ?? #imageLiteral(resourceName: "Flag_of_None"),self.cardManager.loadImageFromPath(path: self.discountCard[indexPath.row].backImage!) ?? #imageLiteral(resourceName: "Flag_of_None"),self.discountCard[indexPath.row].title!], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            
            self.performSegue(withIdentifier: "EditToCard", sender: self.discountCard[indexPath.row])
            
            completionHandler(true)
        }
        edit.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        delete.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        share.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        delete.image = #imageLiteral(resourceName: "delete")
        share.image = #imageLiteral(resourceName: "share")
        edit.image = #imageLiteral(resourceName: "edit")
        
        let config = UISwipeActionsConfiguration(actions: [edit,share,delete])
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
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
    
    //MARK: Searching
    
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
    
    
    //MARK: Sorting
    
    //function for sorting card by title and date
    func sortedCardList(by attribute: SortAttribute) {
        switch attribute{
        case .higherDate:
            discountCard.sort(by: { $0.date! < $1.date!})
            tableView.reloadData()
            break
        case .higherTitle:
            discountCard.sort(by: { $0.title!.lowercased() > $1.title!.lowercased()})
            tableView.reloadData()
            break
        case .lowerDate:
            discountCard.sort(by: { $0.date! > $1.date!})
            tableView.reloadData()
            break
        case .lowerTitle:
            discountCard.sort(by: { $0.title!.lowercased() < $1.title!.lowercased()})
            tableView.reloadData()
            break
        }
    }
    
    
    
    
    
}//END VIEWCONTROLLER

