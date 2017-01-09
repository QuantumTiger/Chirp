//
//  BirdInfoCollectionView.swift
//  Chirp
//
//  Created by WGonzalez on 12/15/16.
//  Copyright © 2016 Quantum Apple. All rights reserved.
//

import UIKit

class BirdInfoCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var birdCollectionView: UICollectionView!
    
    var extraBirdInfo = AllBirdInfo()

    let urlStringMajor = "https://api.cognitive.microsoft.com/bing/v5.0/images/search?q="
    
    var birdName = String()
    var gen = String()
    var species = String()
    var id = String()
    
    var continet = String()
    var lat = String()
    var long = String()
    var location = String()
    
    var birdImageUrl = [String]()
    var birdTransferUrl = String()
    var testArray = [String]()
    var birdUrl = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        birdCollectionView.collectionViewLayout = flowLayout
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        
        flowLayout.itemSize = CGSize(width: screenWidth, height: screenHeight / 7)
    
        birdCollectionView.reloadData() 
    }

    func otherSearch(BirdSearch: String)
    {
        var birdConvertedForSearch = BirdSearch
        let components = BirdSearch.components(separatedBy: NSCharacterSet.whitespaces).filter { !$0.isEmpty }
        
        birdConvertedForSearch = components.joined(separator: "").localizedLowercase
        
        let urlImage: String = urlStringMajor + birdConvertedForSearch + "bird&subscription-key=2b32fcd895a2409282134eb911eda777"
        
        if let urlStringImage = NSURL(string : urlImage)
        {
            if let myData = try? NSData(contentsOf: urlStringImage as URL, options: [])
            {
                let json = JSON(data: myData as Data)
                print("Ok to parse")
                otherParse(json: json)
            }
        }
    }
    
    func otherParse(json : JSON)
    {
        for result in json["value"].arrayValue
        {
            let url = result["thumbnailUrl"].stringValue
            birdImageUrl.append(url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return extraBirdInfo.birdNameArrayDetail.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = birdCollectionView.dequeueReusableCell(withReuseIdentifier: "birdCell", for: indexPath) as! BirdCollectionCells
        let birdItem = extraBirdInfo.birdNameArrayDetail[indexPath.item]
        
        otherSearch(BirdSearch: birdItem)
        print(otherSearch(BirdSearch: birdItem))
        
        if let url = NSURL(string: birdImageUrl[indexPath.item])
        {
            if let data = NSData(contentsOf: url as URL)
            {
                cell.birdImage.image = UIImage(data: data as Data)
                
            }        
        }
        
        
        cell.birdNameLabel.text = birdItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // handle tap events
        birdName = extraBirdInfo.birdNameArrayDetail[Int(indexPath.item)]
        gen = extraBirdInfo.genArrayDetail[Int(indexPath.item)]
        species = extraBirdInfo.speciesArrayDetail[Int(indexPath.item)]
        id = extraBirdInfo.idArrayDetail[Int(indexPath.item)]
        continet = extraBirdInfo.continentArrayDetail[Int(indexPath.item)]
        lat = extraBirdInfo.latArrayDetail[Int(indexPath.item)]
        long = extraBirdInfo.longArrayDetail[Int(indexPath.item)]
        birdUrl = extraBirdInfo.birdUrlArrayDetail[Int(indexPath.item)]
        location = extraBirdInfo.birdLocationArrayDetail[Int(indexPath.item)]
        birdTransferUrl = birdImageUrl[Int(indexPath.item)]
        

        print("You selected cell #\(indexPath.item)!")
        
        transferData()
    }
    
    func transferData()
    {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "DetailBirdInfoCollectionView") as! DetailBirdInfoViewController
        nextController.name = birdName
        nextController.id = id
        nextController.gen = gen
        nextController.species = species
        nextController.continent = continet
        nextController.latitude = lat
        nextController.longitude = long
        nextController.urlForSound = birdUrl
        nextController.location = location
        nextController.urlForImage = birdTransferUrl
        navigationController?.pushViewController(nextController, animated: true)
    }
}
