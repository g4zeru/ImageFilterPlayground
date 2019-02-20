//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    private var context: CIContext?
    
    private let filterName = "CIPhotoEffectProcess"
    private let image = UIImage(named: "User.jpg")
    
    private let imageView = UIImageView()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    override func viewDidLoad() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.context = CIContext(options: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        applyFilterImage()
    }
    private func applyFilterImage() {
        DispatchQueue.global().async {
            let sourceImage = CIImage(image: self.image!)
            guard let filter = CIFilter(name: self.filterName) else {
                return
            }
            filter.setDefaults()
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            let outputCGImage = self.context?.createCGImage(filter.outputImage!, from: (filter.outputImage?.extent)!)
            let filteredImage = UIImage(cgImage: outputCGImage!)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                self.imageView.image = filteredImage
            })
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
