//
//  ViewController.swift
//  Chirp
//
//  Created by WGonzalez on 12/15/16.
//  Copyright © 2016 Quantum Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    var birdInfoToTransfer = AllBirdInfo()
    
    
    let urlStringMajor = "https://api.cognitive.microsoft.com/bing/v5.0/images/search?q="
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func performSearch(_ sender: Any)
    {
        searchBird(BirdSearch: searchText.text!)
        transferData()
    }
    
    func searchBird(BirdSearch : String)
    {
        let urlString = "http://www.xeno-canto.org/api/2/recordings?query=" + BirdSearch
        
        if let url = NSURL(string : urlString)
        {
            if let myData = try? NSData(contentsOf: url as URL, options: [])
            {
                let json = JSON(data: myData as Data)
                print("Ok to parse")
                parse(json: json)
            }
        }
    }
        
    func parse(json : JSON)
    {
        for result in json["recordings"].arrayValue
        {
            let birdId = result["id"].stringValue
            let birdGen = result["gen"].stringValue
            let birdSpecies = result["sp"].stringValue
            let birdName = result["en"].stringValue
            
            let birdContinent = result["cnt"].stringValue
            let birdLocation = result["loc"].stringValue
            let birdLatitude = result["lat"].stringValue
            let birdLongitude = result["lng"].stringValue
            
            let birdUrl = result["file"].stringValue
            
            birdInfoToTransfer.idArrayDetail.append(birdId)
            birdInfoToTransfer.genArrayDetail.append(birdGen)
            birdInfoToTransfer.speciesArrayDetail.append(birdSpecies)
            birdInfoToTransfer.birdNameArrayDetail.append(birdName)
            
            birdInfoToTransfer.continentArrayDetail.append(birdContinent)
            birdInfoToTransfer.birdLocationArrayDetail.append(birdLocation)
            birdInfoToTransfer.latArrayDetail.append(birdLatitude)
            birdInfoToTransfer.longArrayDetail.append(birdLongitude)
            
            birdInfoToTransfer.birdUrlArrayDetail.append(birdUrl)
        }
    }
    
    
    func transferData()
    {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "BirdInfoCollectionView") as! BirdInfoCollectionView
        nextController.extraBirdInfo.birdNameArrayDetail = birdInfoToTransfer.birdNameArrayDetail
        nextController.extraBirdInfo.idArrayDetail = birdInfoToTransfer.idArrayDetail
        nextController.extraBirdInfo.genArrayDetail = birdInfoToTransfer.genArrayDetail
        nextController.extraBirdInfo.speciesArrayDetail = birdInfoToTransfer.speciesArrayDetail
        nextController.extraBirdInfo.continentArrayDetail = birdInfoToTransfer.continentArrayDetail
        nextController.extraBirdInfo.latArrayDetail = birdInfoToTransfer.latArrayDetail
        nextController.extraBirdInfo.longArrayDetail = birdInfoToTransfer.longArrayDetail
        nextController.extraBirdInfo.birdUrlArrayDetail = birdInfoToTransfer.birdUrlArrayDetail
        nextController.extraBirdInfo.birdLocationArrayDetail = birdInfoToTransfer.birdLocationArrayDetail
        
        nextController.extraBirdInfo.birdImageUrlArrayDetail = birdInfoToTransfer.birdImageUrlArrayDetail
        navigationController?.pushViewController(nextController, animated: true)
    }
    
}
