//
//  PageScrollViewController.swift
//  DAM-TD2
//
//  Created by Nicolas Orlandini on 09/01/2017.
//  Copyright © 2017 Nicolas Orlandini. All rights reserved.
//

import UIKit

class PageScrollViewController: UIViewController, UIScrollViewDelegate {

    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.gray, UIColor.purple, UIColor.orange, UIColor.magenta ]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x: 100, y: 600, width: 200, height: 50))
    
    @IBOutlet weak var titleScroll: UILabel!
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var label = UILabel()
    
    @IBOutlet weak var colorScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //variables de la taille de la scrollview
        let largeur = self.view.frame.width
        let longueur = self.view.frame.height - 100
        configurePageControl()
        
        colorScrollView.delegate = self
        colorScrollView.frame.size.width = largeur
        colorScrollView.frame.size.height = longueur
        
        for index in 0..<8 {
            colorScrollView.contentSize = CGSize(width: largeur, height: longueur)
            frame.origin.x = CGFloat(largeur) * CGFloat(index)
            frame.size = colorScrollView.frame.size
            
            //créatoin des UIView et de leur affichage
            let subView = UIView(frame: frame)
            subView.layer.borderWidth = 1
            subView.backgroundColor = colors[index]
            colorScrollView.addSubview(subView)
            
            //déclaration et affichage du label
            label = UILabel(frame: frame)
            label.text = "Page \(index)"
            label.textAlignment = .center
            colorScrollView.addSubview(label)
        }
        colorScrollView.isPagingEnabled = true //activation du paging
        
        colorScrollView.contentSize = CGSize(width: colorScrollView.frame.size.width * CGFloat(colors.count), height: colorScrollView.frame.size.height)
        
    }
    
    //fonction permettant de l'affichage du page control qui scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = colorScrollView.contentOffset.x / colorScrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
    
    //création du page control programmatically
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        //self.pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        self.view.addSubview(pageControl)
        
    }
    
    // changer la page en cliquant, à finir
    func changePage(sender: AnyObject) -> () {
        let page = CGFloat(sender.currentPage) * colorScrollView.frame.size.width
        colorScrollView.setContentOffset(CGPoint(x: page, y: 0), animated: true)
        
    }
    
    //flush de la mémoire
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
