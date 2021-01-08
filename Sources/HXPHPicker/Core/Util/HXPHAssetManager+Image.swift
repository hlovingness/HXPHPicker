//
//  HXPHAssetManager+Image.swift
//  HXPHPicker
//
//  Created by Slience on 2021/1/8.
//

import UIKit
import Photos

public typealias ImageResultHandler = (UIImage?, [AnyHashable : Any]?) -> Void

public extension HXPHAssetManager {
    
    /// 请求获取缩略图
    /// - Parameters:
    ///   - asset: 资源对象
    ///   - targetWidth: 获取的图片大小
    ///   - completion: 完成
    /// - Returns: 请求ID
    class func requestThumbnailImage(for asset: PHAsset, targetWidth: CGFloat, completion: ImageResultHandler?) -> PHImageRequestID {
        let options = PHImageRequestOptions.init()
        options.resizeMode = .fast
        return requestImage(for: asset, targetSize: HXPHTools.transformTargetWidthToSize(targetWidth: targetWidth, asset: asset), options: options) { (image, info) in
            if completion != nil {
                DispatchQueue.main.async {
                    completion!(image, info)
                }
            }
        }
    }
    
    /// 请求image
    /// - Parameters:
    ///   - asset: 资源对象
    ///   - targetSize: 指定大小
    ///   - options: 可选项
    ///   - resultHandler: 回调
    /// - Returns: 请求ID
    class func requestImage(for asset: PHAsset, targetSize: CGSize, options: PHImageRequestOptions, resultHandler: @escaping ImageResultHandler) -> PHImageRequestID {
        return PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options, resultHandler: resultHandler)
    }
}
