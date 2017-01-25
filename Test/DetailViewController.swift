//
//  DetailViewController.swift
//  Test
//
//  Created by Alex on 1/20/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class DetailViewController: ScrollingNavigationViewController {
    var scrollView: UIScrollView!
    var person: Person!
    var image: UIImage?
    var color: UIColor?

    var hostView: UIView!
    var avatarImageView: UIImageView!
    var bio: UILabel!

    var likeButton: UIButton!
    var confettiView: ConfettiView!
    
    fileprivate struct constants {
        static let inset:CGFloat = 20
        static let imageHeigh:CGFloat = 200
        static let gap:CGFloat = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = color
        title = "\(person.firstName!) \(person.lastName!)"
        initUI()
        (navigationController as! ScrollingNavigationController).followScrollView(scrollView, delay: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         scrollView.contentSize.height = constants.inset + constants.imageHeigh + (constants.gap*3) + bio.frame.size.height
    }



    func initUI() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.bindFrameToSuperviewBounds()

        hostView = createHostView()
        avatarImageView = createProfileImageView()
        likeButton = createLikeButton()

        bio = createBioLabel()
        scrollView.contentSize = hostView.frame.size
        
        let bar = (navigationController?.navigationBar)!
        bar.titleTextAttributes =  [NSFontAttributeName: UIFont(name: "Chalkduster", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        bar.tintColor = .white
    }

    func LikeButtonDidTaped() {

      
        likeButton.isSelected = true
        likeButton.isUserInteractionEnabled = false
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = 1.0
        animation.values = [1.0,0.7,1.1,0.8,1.0]
        likeButton.layer.add(animation, forKey: "Scale")
        
        confettiView = ConfettiView()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window
        window?.addSubview(confettiView)
        confettiView.bindFrameToSuperviewBounds()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.confettiView.stopAnimating()
            self.confettiView.removeFromSuperview()
        }
 
    }
}

extension DetailViewController { //helper Function

    fileprivate func createHostView() -> UIView {
        let v = UIView()
        scrollView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: constants.imageHeigh).isActive = true
        v.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -constants.inset).isActive = true
        v.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: constants.inset).isActive = true
        v.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: constants.inset).isActive = true

        v.backgroundColor = .clear
        v.layer.shadowOffset = CGSize(width: 2, height: 4)
        v.layer.shadowOpacity = 0.6
        v.layer.masksToBounds = false
        return v
    }

    fileprivate func createProfileImageView() -> UIImageView {
        let size = UIScreen.main.bounds.size
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width - 40 , height: 200))
        iv.image = self.image
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        hostView.addSubview(iv)
 

        return iv
    }

    fileprivate func createSatckView(_ views: [UIView], axis: UILayoutConstraintAxis = .horizontal) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = 10
        return stackView
    }

    func createLikeButton() -> UIButton {
        let v = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        v.setImage(UIImage(named: "heart"), for: .normal)
        v.setImage(UIImage(named: "heart_filled"), for: .selected)
        v.addTarget(self, action: #selector(self.LikeButtonDidTaped), for: .touchUpInside)
        hostView.addSubview(v)
        hostView.isUserInteractionEnabled = true
        v.bindFrameToSuperviewBounds()
        return v
    }

    fileprivate func createLabel() -> UILabel {
        let v = UILabel()
        v.numberOfLines = 0
        v.textColor = .darkGray
        v.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return v
    }

    fileprivate func createBioLabel() -> UILabel {
        let v = createLabel()
        v.text = person.bio
        v.numberOfLines = 0
        view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.topAnchor.constraint(equalTo: hostView.bottomAnchor, constant: 20).isActive = true
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        v.sizeToFit()
        scrollView.addSubview(v)
        return v
    }
}
