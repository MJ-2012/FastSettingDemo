//
//  UITableView+MJAutomaticHeightCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/17.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

extension  UITableView  {

    public func MJ_heightForCellWithIdentifier<T:UITableViewCell>(identifier:T.Type, indexPath:NSIndexPath ,configuration :((cell: T) ->Void )?) -> CGFloat {
        let identiferStr = "\(identifier)"
        if  identiferStr.Length == 0 {
            return 0
        }
        //查询缓存
        if  self.MJ_hasCachedHeightAtIndexPath(indexPath) {
            let height : CGFloat = self.MJ_indexPathHeightCache![indexPath.section][indexPath.row]
            return height
        }
        
        let height = self.MJ_heightForCellWithIdentifier(identiferStr, configuration: configuration)
        self.MJ_indexPathHeightCache![indexPath.section][indexPath.row] = height
        return height
    }
    
    private func MJ_heightForCellWithIdentifier<T:UITableViewCell>(identifier: String ,configuration :((cell: T) ->Void )?) -> CGFloat {
        let cell = self.MJ_templateCellForResueIdentifier(identifier)
        cell.prepareForReuse()
        
        if configuration != nil {
            configuration!(cell: cell as! T)
        }
        var fittingSize = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        if self.separatorStyle  != .None {
            fittingSize.height += 1.0 / UIScreen.mainScreen().scale
        }
        return fittingSize.height
    }
    
    private func MJ_templateCellForResueIdentifier(identifier : String ) -> UITableViewCell {
        assert(identifier.Length > 0,  "Expect a valid identifier - \(identifier)")
        if self.MJ_templateCellsByIdentifiers == nil {
            self.MJ_templateCellsByIdentifiers = [:]
        }
        
        var tempCell = self.MJ_templateCellsByIdentifiers?[identifier] as? UITableViewCell
        if tempCell == nil {
            tempCell = self.dequeueReusableCellWithIdentifier(identifier)
            assert(tempCell != nil, "Cell must be registered to table view for identifier -\(identifier)")
            tempCell!.contentView.translatesAutoresizingMaskIntoConstraints = false
            self.MJ_templateCellsByIdentifiers?[identifier] = tempCell
        }
        return tempCell!
    }
    
    private struct AssociatedKey {
        static var CellsIdentifier = "me.MJ.cellsIdentifier"
        static var HeightsCacheIdentifier = "me.MJ.heightsCacheIdentifier"
        static var MJHeightCacheAbsendValue = CGFloat(-1);
    }
    
    private func MJ_hasCachedHeightAtIndexPath(indexPath:NSIndexPath) -> Bool {
        self.MJ_buildHeightCachesAtIndexPathsIfNeeded([indexPath])
        let height = self.MJ_indexPathHeightCache![indexPath.section][indexPath.row]
        return height >= 0
    }
    
    private func MJ_buildHeightCachesAtIndexPathsIfNeeded(indexPaths:Array<NSIndexPath>) -> Void {
        if indexPaths.count <=  0 {
            return
        }
        
        if self.MJ_indexPathHeightCache == nil  {
            self.MJ_indexPathHeightCache = []
        }
        
        for indexPath in indexPaths {
            let cacheSectionCount = self.MJ_indexPathHeightCache!.count
            if indexPath.section >= cacheSectionCount  {
                for i in cacheSectionCount...indexPath.section {
                    if i >= self.MJ_indexPathHeightCache!.count {
                        self.MJ_indexPathHeightCache!.append([])
                    }
                }
            }
            
            let cacheCount = self.MJ_indexPathHeightCache![indexPath.section].count
            
            if indexPath.row >= cacheCount {
                for i in cacheCount...indexPath.row {
                    if  i >= self.MJ_indexPathHeightCache![indexPath.section].count {
                        self.MJ_indexPathHeightCache![indexPath.section].append(AssociatedKey.MJHeightCacheAbsendValue)
                    }
                }
            }
        }
    }
    
    //临时私有变量存储cells
    private var MJ_templateCellsByIdentifiers : [String : AnyObject]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.CellsIdentifier) as? [String : AnyObject]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.CellsIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //临时私有变量存储每个cell的高度
    private var MJ_indexPathHeightCache:[ [CGFloat] ]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.HeightsCacheIdentifier) as? [[CGFloat]]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.HeightsCacheIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
