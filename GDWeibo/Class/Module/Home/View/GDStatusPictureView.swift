//
//  GDStatusPictureView.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import SDWebImage

class GDStatusPictureView: UICollectionView {

    //设置重定义标识
private let StatusPictureViewIdentifier = "StatusPictureViewIdentifier"
    
    //MARK: - 属性
    //微博数据
    var status: GDStatus? {
        didSet {
            //自动适配，会调用sizeThatFits
            sizeToFit()
            //重新刷新数据
            reloadData()
        }
        
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize
    {
        //重写计算item的尺寸
        return calcViewSize()
    }
    
    
    //MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //设置流水布局
    var pictureLayout = UICollectionViewFlowLayout()
    
   override  init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    
        super.init(frame: frame, collectionViewLayout: pictureLayout)
    
        //注册cell
        registerClass(GDStatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureViewIdentifier)
    
        //设置自己为自己的数据源
        dataSource = self
    
        //设置背景颜色
        backgroundColor = UIColor.clearColor()
    
    }

    //设置返回图片View的尺寸
    func calcViewSize() -> CGSize {
        
        //设置每个item的默认尺寸
        let itemSize = CGSize(width: 90, height: 90)
        
        //设置布局的itemSize
        pictureLayout.itemSize = itemSize
        pictureLayout.minimumInteritemSpacing = 0
        pictureLayout.minimumLineSpacing = 0
        
        //设置item之间的间距
        let margin: CGFloat = 10
        
        //设置最大行
        let column = 3
        
        //获取配图的数量
        let count = status?.pictureURLs?.count ?? 0
        
        //根据配图来甲酸配图尺寸
        if  count == 0
        {
            return CGSizeZero
        }
        
        
        // 1张图片
        if count == 1 {
            
            var size = CGSize(width: 150, height: 120)

            //获取单张图片的url
            let url = status?.pictureURLs?.first?.absoluteString
            
            //从硬盘中获得存储图片,存在硬盘中没有缓存的情况，所有需要加判断
            if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url) {
                
                pictureLayout.itemSize = image.size
                size = image.size
                
            }
            //如果图片太小
            if size.width < 40 {
                //默认
                size.width = 40
            }
            
            
            return size
        }
        
        // 超过一张图片设置间距
        pictureLayout.minimumInteritemSpacing = margin
        pictureLayout.minimumLineSpacing = margin
        
        // 4张图片
        if count == 4 {
            let width = 2 * itemSize.width + margin
            return CGSize(width: width, height: width)
        }
        
        // 其他图片: 2, 3, 5, 6, 7, 8, 9
        // 公式: 行数 = (图片数量 + 列数 - 1) / 列数
        let row = (count + column - 1) / column
        
        // 计算宽度
        let width = (CGFloat(column) * itemSize.width) + (CGFloat(column) - 1) * margin
        
        // 计算高度
        let height = (CGFloat(row) * itemSize.height) + (CGFloat(row) - 1) * margin
        
        return CGSize(width: width, height: height)
        
        
    }
    

}
//MARK: - 扩展GDStatusPictureView的数据源方法
extension GDStatusPictureView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusPictureViewIdentifier, forIndexPath: indexPath) as! GDStatusPictureViewCell
        
//        cell.backgroundColor = UIColor.redColor()
        //为cell赋值
        cell.imageURL = status?.pictureURLs?[indexPath.row]
        
        return cell
    }
    
    
    
}


//MARK: - 自定义Cell
class GDStatusPictureViewCell: UICollectionViewCell {
    
    
    //MARK: - 构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        prepareUI()
    }
    
    func prepareUI() {
        
        //添加子控件
        addSubview(iconView)
        
        //填充整个父控件
        iconView.ff_Fill(contentView)
        
    }
    
    //MARK: - 懒加载控件
    private lazy var iconView: UIImageView = {
       
        let imageView = UIImageView()
        //设置图片的填充模式
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        //裁剪超出控件区域的图片
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    //显示图片
    var imageURL: NSURL? {
        didSet {
            
            //加载图片
            iconView.sd_setImageWithURL(imageURL)
            
        }
        
    }
    
}


