//
//  StartPager.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 17/11/2020.
//

import UIKit

class StartPager: UIViewController {
    
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var slider: UIPageControl!
    var counter = Int()
    var imageArray = [UIImage(named: "onboarding_onde"),UIImage(named: "onbording_two"),UIImage(named: "onboarding_three")]
    @IBOutlet weak var collection_view: UICollectionView!
    override func viewDidLoad() {
        slider.numberOfPages = imageArray.count
        slider.currentPage = 0
        super.viewDidLoad()
        collection_view.delegate = self
        collection_view.dataSource = self
    }
    
    @IBAction func btnNext_pressed(_ sender: Any) {
        counter += 1
        if counter == 3{
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let vc = stb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            vc.dictData = ["this is key":"this value"]
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            if counter == 1{
                viewButton.backgroundColor = UIColor(hex: "#2474A6")
            }else{
                viewButton.backgroundColor = UIColor(hex: "#F2A30F")
            }
            collection_view.scrollToItem(at: IndexPath(item: counter, section: 0), at: .left, animated: true)
            slider.currentPage = counter
        }
        
        

    }
    
    
    
}
extension StartPager:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerCell", for: indexPath) as! PagerCell
        cell.iv_image.image = imageArray[indexPath.row]
        cell.cellHeight.constant = self.collection_view.frame.size.height
        cell.cellWidth.constant =  self.collection_view.frame.size.width
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collection_view.contentOffset
        visibleRect.size = collection_view.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collection_view.indexPathForItem(at: visiblePoint) else { return }
        counter = indexPath.row
        slider.currentPage = indexPath.row
        if indexPath.row == 1{
            viewButton.backgroundColor = UIColor(hex: "#2474A6")
        }else{
            viewButton.backgroundColor = UIColor(hex: "#F2A30F")
        }
    }
}
