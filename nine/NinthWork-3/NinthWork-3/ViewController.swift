//
//  ViewController.swift
//  NinthWork-3
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 2014110349. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...3 {
            let imageview = UIImageView(image: UIImage(named: "\(i)"))
            imageview.contentMode = .scaleAspectFit
            imageview.frame = CGRect(x: CGFloat(i-1) * scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(imageview)
        }
        
        
        scrollView.contentSize = CGSize(width: 3 * scrollView.bounds.width, height: scrollView.bounds.height)
        
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        let imageview = UIImageView(image: UIImage(named: "1"))
        scrollView1.addSubview(imageview)
        scrollView1.contentSize = imageview.bounds.size
        scrollView1.minimumZoomScale = 0.2
        scrollView1.maximumZoomScale = 5
        scrollView1.delegate = self
        
        
        
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView1.subviews.first
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }

    //将点击和pageControl关联起来
    @IBAction func pageControlCliked(_ sender: UIPageControl) {
        let rect = CGRect(x: CGFloat(pageControl.currentPage)*scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
}

