//
//  ViewController.swift
//  Test
//
//  Created by Alex on 1/19/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

enum CellMode {
    case full
    case short
}


class MainViewController: UITableViewController,RefreshViewDelegate {
    var persons = [Person]()
    var cellMode: CellMode = .full
    var tutorView:UIImageView!

    let kRefreshViewHeight: CGFloat = 110.0
      var refreshView: RefreshView!


    let cellColors: [UIColor] = [ UIColor(rgb: 0xf5dc6f), UIColor(rgb: 0xf5be4b), UIColor(rgb: 0xfec99b), UIColor(rgb: 0xffa5b4), UIColor(rgb: 0xfec99b), UIColor(rgb: 0xe9bcd8), UIColor(rgb: 0xcfd9e6)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmentToNaviTitle()
        setNavigationItems()
        LoadData()
        setupTutor()
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 260
        tableView.separatorStyle = .none

        setupPullRefresh()
        (navigationController as! ScrollingNavigationController).followScrollView(tableView, delay: 0.0)
    }
    
    func setupTutor()  {
        let screenSzie = UIScreen.main.bounds.size
        tutorView = UIImageView(frame:CGRect(x: 0, y: 0, width: screenSzie.width, height: screenSzie.height))
        tutorView.image = UIImage(named:"tutor")
        tutorView.backgroundColor = UIColor(red:0.1,  green:0.1,  blue:0.1, alpha:0.8)
        tutorView.isUserInteractionEnabled = true
        tutorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissTutor) ))
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window
        window?.addSubview(tutorView)
    }
    
    func dismissTutor() {
        tutorView.removeFromSuperview()
    }
    
    func setupPullRefresh() {
        view.backgroundColor = UIColor(rgb:0x039ce0)
        let refreshRect = CGRect(x: 0.0, y: -kRefreshViewHeight, width: view.frame.size.width, height: kRefreshViewHeight)
        refreshView = RefreshView(frame: refreshRect, scrollView: self.tableView)
        refreshView.delegate = self
        view.addSubview(refreshView)
    }


    func LoadData() {
        CoffeeService.getPeople { persons in
            self.persons = persons
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.color = cellColors[indexPath.row % cellColors.count]
        cell.displayItem(persons[indexPath.row], mode: cellMode)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! Cell
        let vc = DetailViewController(nibName: nil, bundle: nil)
        vc.person = persons[indexPath.row]
        vc.image = cell.avatarImageView.image
        vc.color = cell.color
        show(vc, sender: nil)
    }

    func addSegmentToNaviTitle() {
        title = ""
        let items = [UIImage(named: "avatarMode"), UIImage(named: "listMode")]
        let segment: UISegmentedControl = UISegmentedControl(items: items)
        segment.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        segment.selectedSegmentIndex = 0;
        segment.tintColor = .white
        segment.addTarget(self, action: #selector(self.segmentedValueChanged(segment:)), for: .valueChanged)
        navigationItem.titleView = segment
    }

    func segmentedValueChanged(segment: UISegmentedControl) {
        cellMode = segment.selectedSegmentIndex == 0 ? .full : .short
        tableView.rowHeight = segment.selectedSegmentIndex == 0 ? 260 : 120
        tableView.reloadData()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as! ScrollingNavigationController).showNavbar()
    }
    

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (navigationController as! ScrollingNavigationController).stopFollowingScrollView()
    }
    

    open override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        
        (navigationController as! ScrollingNavigationController).showNavbar(animated: true)
        return true
    }

    
    // MARK: Refresh control methods
    func refreshViewDidRefresh(_ refreshView: RefreshView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            refreshView.endRefreshing()
        }
    }
    
    // MARK: Scroll view methods
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func setNavigationItems () {

        let btn = UIButton(type: .infoLight)
        btn.addTarget(self, action: #selector(self.setupTutor), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btn)
        navigationItem.setRightBarButtonItems([item], animated: true)
        navigationController?.navigationBar.tintColor = .white
    }
}










