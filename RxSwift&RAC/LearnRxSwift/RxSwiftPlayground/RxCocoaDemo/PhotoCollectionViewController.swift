//
//  PhotoCollectionViewController.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/8/24.
//

import UIKit
import RxCocoa
import RxSwift
import Photos
import RxDataSources

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var disposeBag = DisposeBag()

    fileprivate var photos_example1 = Variable<[PHAsset]>([])
    fileprivate var photos_example2 = Variable<[SectionModel<String, PHAsset>]>([])

    fileprivate lazy var imageManager = PHCachingImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 使用RxCocoa管理UICollectionView之前必须要让出dataSource的位置
        self.collectionView!.dataSource = nil

        // self.collectionView!.delegate = nil  // delegate的话，并不是处理数据的代理，所以可以自己持有，用来处理View层的逻辑

        // 创建方法一，创建Observable数据源，并绑定到collectionView.rx.items，详见UICollectionView+Rx.swift
        //        self.photos_example1
        //            .asObservable()
        //            .bind(to: self.collectionView!.rx.items) { [weak self] collectionView, row, element in
        //                let indexPath = IndexPath(row: row, section: 0)
        //                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        //
        //                cell.representedAssetIdentifier = element.localIdentifier
        //
        //                self?.imageManager.requestImage(for: element,
        //                                                targetSize: CGSize(width: 100, height: 100),
        //                                                contentMode: .aspectFill,
        //                                                options: nil,
        //                                                resultHandler: { image, _ in
        //
        //                                                    guard let image = image else { return }
        //
        //                                                    if cell.representedAssetIdentifier == element.localIdentifier {
        //                                                        cell.imageView.image = image
        //                                                    }
        //                })
        //
        //                return cell
        //            }
        //            .addDisposableTo(disposeBag)

        // 创建方法二，先创建RxCollectionViewSectionedReloadDataSource作为数据源和工厂对象
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, PHAsset>>()

        // configureCell是RxCollectionViewSectionedReloadDataSource定义的，类似于工厂方法的，产生Cell对象
        // 另外如果要定义SectionView，可以用supplementaryViewFactory
        dataSource.configureCell = { [weak self] _, collectionView, indexPath, element in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell

            cell.representedAssetIdentifier = element.localIdentifier

            self?.imageManager.requestImage(for: element,
                                            targetSize: CGSize(width: 100, height: 100),
                                            contentMode: .aspectFill,
                                            options: nil,
                                            resultHandler: { image, _ in

                                                guard let image = image else { return }

                                                if cell.representedAssetIdentifier == element.localIdentifier {
                                                    cell.imageView.image = image
                                                }
            })

            return cell
        }

        // 然后将Variable和RxCollectionViewSectionedReloadDataSource绑定起来
        self.photos_example2
            .asObservable()
            .bind(to: collectionView!.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        _ = self.collectionView!.rx.itemSelected.subscribe { print("item clicked \($0)") } // 订阅点击事件
        _ = self.collectionView!.rx.didScroll.subscribe { print("did scroll \($0)") } // 订阅滚动事件，其他事件雷同

        checkAuthorized()
    }

    func checkAuthorized() {

        // 这是PHPhotoLibrary的extension对象
        let isAuthorized = PHPhotoLibrary.isAuthorized.share()

        // 摘自泊学（https://www.boxueio.com/series/rxswift-101/ebook/244）
        // 1.如果用户已授权，事件序列就是：.next(true)，.completed()；
        // 2.如果用户未授权，序列的第一个事件就一定是.next(false)。
        // 2.1.如果用户拒绝授权，序列中的事件就是：.next(false)和.completed。
        // 2.2.如果用户接受授权，就是.next(true)和.completed；

        // 第一个订阅，订阅用户确认授权和已经授权的情况
        isAuthorized
            .skipWhile { $0 == false } // 如果.next为false，则跳过
            .take(1) // 只取第一个true
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.reloadPhotos()
                }
            })
            .addDisposableTo(disposeBag)

        // 第二个订阅，订阅用户没有授权或者拒绝授权的情况
        isAuthorized
            // .distinctUntilChanged()  //没有授权或者拒绝授权的情况，第一个必然为false。PS.原例子有这个，其实可以不用
            .takeLast(1)
            .filter({ $0 == false })
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.flash(title: "无法访问你的照片库", message: "通过设置打开权限", callback: { _ in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }

            })
            .addDisposableTo(disposeBag)
    }

    func reloadPhotos() {
        let result = PhotoCollectionViewController.loadPhotos()
        let phassetArray = result.objects(at: IndexSet(0..<result.count))

        self.photos_example1.value = phassetArray

        let sectionModel = SectionModel<String, PHAsset>(model: "title", items: phassetArray)
        self.photos_example2.value = [sectionModel]

    }

    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("delegate selected \(indexPath)")
    }
}

class PhotoCell: UICollectionViewCell {

    var representedAssetIdentifier: String?

    lazy var imageView: UIImageView = {
        let v = UIImageView()
        self.contentView.addSubview(v)
        return v
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.contentView.frame
    }
}

extension PhotoCollectionViewController {

    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        return PHAsset.fetchAssets(with: options)
    }
}

extension PHPhotoLibrary {

    // 先创建一个Observable对象
    static var isAuthorized: Observable<Bool> {
        return Observable<Bool>.create { (observer) -> Disposable in

            // 当被订阅的时候，就执行下列代码
            DispatchQueue.main.async {

                // 如果已授权，直接发送true
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    // 如果未授权或者拒绝授权，就发送false
                    PHPhotoLibrary.requestAuthorization {
                        observer.onNext($0 == .authorized)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}
