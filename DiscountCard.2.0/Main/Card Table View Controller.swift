//
//  ViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class CardTableViewController: UIViewController, CardSortDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var settingsBurButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var redColorFilter: UIButton!
    
    @IBOutlet weak var orangeColorFilter: UIButton!
    
    @IBOutlet weak var yellowColorFilter: UIButton!
    
    @IBOutlet weak var greenColorFilter: UIButton!
    
    @IBOutlet weak var blueColorFilter: UIButton!
    
    @IBOutlet weak var violetColorFilter: UIButton!
    
    public var filterColorDictionary : [UIButton:String] = [:]
    
    var quickActionBarcode : UIImage?
    
    var quickActionDescription : String?
    
    var cardManager = CardManager()
    
    var discountCard : [Card] = []
    
    var filterCard : [Card] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discountCard = cardManager.returnCard()
        filterCard = discountCard
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToCard" {
            let addEdit = segue.destination as? AddEditTableViewController
            addEdit?.editCard = sender as? Card
        } else if segue.identifier == "fromCellToPhoto" {
            let scrollPhotoView = segue.destination as? CardPhotoViewController
            scrollPhotoView?.selectCard = sender as? Card
        } else if segue.identifier == "FromTableToPopOver" {
            let popOver = segue.destination as? PopOverViewController
            popOver?.preferredContentSize = CGSize(width: view.frame.width / 5.0, height: view.frame.height / 4.0)
            popOver?.popoverPresentationController?.delegate = self
            popOver?.delegate = self
        }
    }
    
    @IBAction func updateTableView(_ sender: Any) {
        for filter in filterColorDictionary {
            filter.key.backgroundColor = UIColor.white
        }
        discountCard = cardManager.returnCard()
        searchController.searchBar.text = ""
        searchController.isActive = false
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0.0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    //func for using 3DTouch
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.forceTouchCapability {
        case .available:
            registerForPreviewing(with: self, sourceView: tableView)
        default: break
        }
    }
    
    //func for installing theme
    func currentTheme() {
        let defaults = UserDefaults.standard
        let currentTheme = defaults.object(forKey: "currentTheme") as! String?
        
        if let _ = currentTheme {
            switch currentTheme! {
            case "light": theme = .light
            case "dark": theme = .dark
            default: break
            }
        }
    }
    
    //func for chossing color filter
    func installColorForFilter(card:Card)->UIColor {
        switch card.filterColor {
        case "Red"?: return UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        case "Orange"?: return UIColor.orange
        case "Yellow"?: return UIColor(red: 255, green: 255, blue: 0, alpha: 1.0)
        case "Green"?: return UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
        case "Blue"?: return UIColor(red: 0, green: 0, blue: 255, alpha: 1.0)
        case "Violet"?: return UIColor.purple
        default: break
        }
        return UIColor.clear
    }
    
    //MARK: color filter
    
    @IBAction func colorFilterPressed(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.white ? sender.borderColor : UIColor.white
        filterCardByColor()
        animateTable()
    }
    
    func filterCardByColor() {
        var choosenCard :[Card] = []
        var colorReview = false
        for filter in filterColorDictionary {
            if filter.key.backgroundColor != UIColor.white {
                colorReview = true
                choosenCard += filterCard.filter( { (this)-> Bool in
                    return (this.filterColor!.contains(filter.value))
                })
                discountCard = choosenCard
            }
            if colorReview == false {
                discountCard = filterCard
            }
        }
    }
    
    func fillDictionary() {
        filterColorDictionary[redColorFilter] = "Red"
        filterColorDictionary[orangeColorFilter] = "Orange"
        filterColorDictionary[yellowColorFilter] = "Yellow"
        filterColorDictionary[greenColorFilter] = "Green"
        filterColorDictionary[blueColorFilter] = "Blue"
        filterColorDictionary[violetColorFilter] = "Violet"
    }
    
    //MARK: Sorting
    
    func sortedCardList(by attribute: SortAttribute) {
        switch attribute {
        case .higherDate:
            discountCard.sort(by: { $0.date! < $1.date!})
            animateTable()
            break
        case .higherTitle:
            discountCard.sort(by: { $0.title!.lowercased() > $1.title!.lowercased()})
            animateTable()
            break
        case .lowerDate:
            discountCard.sort(by: { $0.date! > $1.date!})
            animateTable()
            break
        case .lowerTitle:
            discountCard.sort(by: { $0.title!.lowercased() < $1.title!.lowercased()})
           animateTable()
            break
        }
    }
}
