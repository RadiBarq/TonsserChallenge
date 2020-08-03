import RxSwift
import UIKit

typealias BindableViewController<View: ReusableUIView, Model> = BindableTypeController<View, Model> & BindableViewModel

protocol BindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
}

protocol BindableViewModel {
    func bindViewModel()
}

extension BindableType where Self: UIViewController, Self: BindableViewModel {
    mutating func bind(toViewModel model: Self.ViewModelType) {
        self.viewModel = model
        self.loadViewIfNeeded()
        self.bindViewModel()
    }
}

class BindableTypeController<View: UIView, Model>: ReusableUIViewController<View>, BindableType {
    var viewModel: Model!
}

class ReusableUIViewController<View: UIView>: UIViewController {
    
    lazy var disposeBag = DisposeBag()
    
    var layout: View {
        guard let view = self.view as? View else {
            #if DEBUG
            fatalError("Can't cast view as GenericUIView")
            #else
            return View()
            #endif
        }
        
        return view
    }
    
    override func loadView() {
        self.view = View()
    }
    
    deinit {
        print("Deinit: \(self)")
    }
}
