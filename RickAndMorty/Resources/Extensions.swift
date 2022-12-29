//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import UIKit

//Extension to modify apples default addSubView uiview
extension UIView
{
    func addSubviews(_ views: UIView...)
    {
        views.forEach({
            addSubview($0)
        })
    }
}
