//
//  cell.swift
//  Test
//
//  Created by Alex on 1/19/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit



class Cell: UITableViewCell {
    var avatarHostView: UIView!
    var avatarImageView: UIImageView!
    var bio: UILabel!
    var fullName: RibbonView!
    var id: UILabel!
    var title: UILabel!
    var badgeView: UIImageView!
    var color: UIColor?

    var avatarUrl: String! {
        didSet {
            CoffeeService.downloadAvatar(avatarUrl) { (image) in
                OperationQueue.main.addOperation {
                    self.avatarImageView.image = image
                }
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initUI() {
        selectionStyle = .none
        avatarHostView = createHostView()
        avatarImageView = createProfileImageView()

        bio = createLabel()
        fullName = createRibbon()
        fullName.font = UIFont.preferredFont(forTextStyle: .headline)
        id = createLabel()
        title = createLabel()

        addbadge()
    }



    func setupLayout() {
        // ----------------------------
        // |      |    id            |
        // |      |    full name     |
        // |Avatar|    title         |
        // |         Bio             |
        // ----------------------------

        let infoStackView = createSatckView( [id, fullName, title], axis: .vertical)
        infoStackView.alignment = .leading

        let row1 = createSatckView([ avatarHostView, infoStackView])
        row1.distribution = .fillProportionally
        row1.alignment = .center
        row1.spacing = 30

        let stackView = createSatckView([row1, bio], axis: .vertical)

        row1.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        stackView.distribution = .fillEqually
        stackView.alignment = .center

        contentView.addSubview(stackView)
        stackView.spacing = -20
        stackView.indentFrameToSuperviewBounds()

    }


    func displayItem(_ person: Person, mode: CellMode = .full) {

        avatarUrl = person.avatar
        bio.text = person.bio?.substring(to: 220)
        fullName.text = "  \(person.firstName!) \(person.lastName!)  "
        title.text = person.title!
        id.text = person.id!
        contentView.backgroundColor = color
        badgeView.isHidden = (person.firstName?.contains("r"))!
        cellModeAnimation(mode)
    }

    func cellModeAnimation(_ mode: CellMode) {
        if mode == .short && bio.isHidden == false {
            UIView.animate(withDuration: 0.3) {
                self.bio.isHidden = true
            }
        } else if mode == .full && bio.isHidden == true {
            UIView.animate(withDuration: 0.5) {
                self.bio.isHidden = false
            }
        }
    }
}

extension Cell { //helper Function

    fileprivate func createHostView() -> UIView {
        let v = UIView()

        v.heightAnchor.constraint(equalToConstant: 100).isActive = true
        v.widthAnchor.constraint(equalToConstant: 100).isActive = true
        v.backgroundColor = .clear
        v.layer.shadowOffset = CGSize(width: 2, height: 4)

        v.layer.shadowOpacity = 0.6
        v.layer.masksToBounds = false
        return v
    }

    fileprivate func createProfileImageView() -> UIImageView {
        let iv = UIImageView()

        iv.borderWidth = 2
        iv.borderColor = .white
        iv.cornerRadius = 50
        iv.clipsToBounds = true

        avatarHostView.addSubview(iv)
        iv.bindFrameToSuperviewBounds()
        return iv
    }

    fileprivate func createSatckView(_ views: [UIView], axis: UILayoutConstraintAxis = .horizontal) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = 10
        return stackView
    }

    fileprivate func createRibbon() -> RibbonView {
        let v = RibbonView()

        v.numberOfLines = 0
        v.textColor = .white
        //good iOS citizen does NOT use fix size Font
        v.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return v
    }

    fileprivate func addbadge() {
        badgeView = UIImageView(frame: CGRect(x: 80, y: 70, width: 28, height: 42))
        let bimage = UIImage(named: "badge")
        badgeView.image = bimage
        
        avatarHostView.addSubview(badgeView)
        badgeView.isHidden = true
    }



    fileprivate func createLabel() -> UILabel {
        let v = UILabel()

        v.numberOfLines = 0
        v.textColor = .darkGray
        v.lineBreakMode = .byTruncatingTail
        //good iOS citizen does NOT use fix size Font
        v.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return v
    }
}

