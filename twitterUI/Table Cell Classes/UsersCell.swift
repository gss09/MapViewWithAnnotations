//
//  UsersCell.swift
//  twitterUI
//
//  Created by GSS on 2021-04-25.
//

import UIKit

class UsersCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Update the cell with the values from local database
    func update(with user: Users) -> Void {
        nameLabel.text = user.name
        let buttonTitle = user.isFollowing ? "Following" : "Follow"
        followButton.setTitle(buttonTitle, for: .normal)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
