//
//  HomeBannerCollectionViewCell.swift
//  IOCL
//
//  Created by infoneo on 22/12/22.
//

import UIKit

class HomeBannerCollectionViewCell: UICollectionViewCell {

    //MARK: - OUTLETS -
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var bannerImg: UIImageView!
   
    //MARK: - CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    //MARK: - PRIVATE FUNCTION -
    private func setCell() {
        self.backgroundColor = .clear
      
        outerView.backgroundColor = .clear
        bannerImg.backgroundColor = .clear
    }
}
