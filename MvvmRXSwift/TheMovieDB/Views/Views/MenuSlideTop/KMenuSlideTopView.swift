//
//  KMenuSlideTopView.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/15/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

protocol KMenuSlideTopViewDelegate: class  {
    func itemMenuSelected(index: Int)
}

class KMenuSlideTopView: UIView {
    
    let cvMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = KColor.navigationColor
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    let vHorizotal: UIView = {
        let view = UIView()
        view.backgroundColor = KColor.yellowColor
        
        return view
    }()
    
    let heightViewHorizontal: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    let cellId = "MenuSlideTopViewCell"
    
    var listItem = [AnyObject]() {
        didSet{
            cvMenu.reloadData()
        }
    }
    
    
    
    weak var delegate: KMenuSlideTopViewDelegate?
    
    func setUpView(){
        addSubview(cvMenu)
        cvMenu.fillSuperview()
        cvMenu.addSubview(vHorizotal)
        
        //---
        configureCollection()
    }
}
//MARK: handle Collection view
extension KMenuSlideTopView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection(){
        cvMenu.register(MenuSlideTopViewCell.self , forCellWithReuseIdentifier: cellId)
        cvMenu.delegate = self
        cvMenu.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuSlideTopViewCell
        cell.item = listItem[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let itemStr = listItem[indexPath.item] as? KCategory {
            let wid = estimateWidth(customFont: UIFont.boldSystemFont(ofSize: 15), str: itemStr.title) + 20
            if indexPath.item == 0 && vHorizotal.frame.width == 0 {
                vHorizotal.frame = CGRect(x: 0, y: cvMenu.frame.height - heightViewHorizontal , width: wid, height: heightViewHorizontal)
                vHorizotal.setBorder(cornerRadius: heightViewHorizontal / 2)
            }
            
            return CGSize(width: wid, height: collectionView.frame.height)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func estimateWidth(customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: 1000, height: customFont.lineHeight)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSFontAttributeName: customFont], context: nil)
        
        return estimateFrame.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToIndex(index: indexPath.item)
        delegate?.itemMenuSelected(index: indexPath.item)
    }
    
    func scrollToIndex(index: Int) {
        //get cell selected
        let indexPath = IndexPath(item: index, section: 0)
        guard let cellScroll = cvMenu.cellForItem(at: indexPath) as? MenuSlideTopViewCell else { return }
        
        
        UIView.animate(withDuration: 0.5) {
            //-- scroll view horizontal
            self.vHorizotal.frame = CGRect(x: self.vHorizotal.frame.minX, y: self.vHorizotal.frame.minY, width: cellScroll.frame.width, height: self.vHorizotal.frame.height)
            self.vHorizotal.center.x = cellScroll.center.x
            
            //-- scroll collction view
            self.cvMenu.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            //-- set color nomal for all item in screen
            //-- indexPathsForVisibleItems get indexPath all item in screen
            let listIndexPathVisible = self.cvMenu.indexPathsForVisibleItems
            for indexPath in listIndexPathVisible {
                if let cell = self.cvMenu.cellForItem(at: indexPath) as? MenuSlideTopViewCell {
                    cell.lbTitle.textColor = KColor.smallTextColor
                }
            }
            
            //-- set color selected for current cell
            cellScroll.lbTitle.textColor = KColor.whiteColor
            
            
            //--
            guard let listCategory = self.listItem as? [KCategory] else { return }
            for i in 0...listCategory.count - 1 {
                listCategory[i].isSelected = false
            }
            listCategory[index].isSelected = true
        }
    }
    
    
    
}

//MARK: MenuSlideTopViewCell

class MenuSlideTopViewCell: UICollectionViewCell {
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font =  KFont.fontRegular15
        lb.textAlignment = .center
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    //set value for cell menu , when have a category
    
    var item: AnyObject?{
        didSet{
            if let cate = item as? KCategory {
                lbTitle.text = cate.title
                lbTitle.textColor = cate.isSelected == true ? KColor.whiteColor: KColor.smallTextColor
            }
        }
    }
    
    
    func setUpView(){
        addSubview(lbTitle)
        lbTitle.fillSuperview()
    }
}

class KCategory {
    var title: String = ""
    var isSelected: Bool = false
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

