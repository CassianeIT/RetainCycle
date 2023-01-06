//
//  ViewController.swift
//  RetainCycle
//
//  Created by Cassiane Freitas on 06/12/22.
//

import UIKit

class ViewControllerHome: UIViewController {

    lazy var home: UILabel = {
        let label = UILabel(frame: CGRect(x: 180, y: 40, width: 100, height: 80))
        label.text = "HOME"
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        button.setTitle("abrir tela UM", for: .normal)
        button.center = view.center
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openClassOne), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(home)
        view.addSubview(openButton)
    }

    @objc func openClassOne() {
        let controllerOne = ViewControllerOne()
        let navigation = UINavigationController(rootViewController: controllerOne)
        navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: true)
    }

}

class ViewControllerOne: UIViewController {

    let controllerTwo = ViewControllerTwo()
    
    lazy var viewOne: UILabel = {
        let label = UILabel(frame: CGRect(x: 180, y: 40, width: 100, height: 80))
        label.text = "Tela UM"
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        button.setTitle("abrir tela dois", for: .normal)
        button.center = view.center
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openClassTwo), for: .touchUpInside)
        return button
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        button.setTitle("fechar tela um", for: .normal)
        button.center.y = view.center.y + 200
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(viewOne)
        view.addSubview(openButton)
        view.addSubview(closeButton)
    }

    @objc func openClassTwo() {
        //let controllerTwo = ViewControllerTwo() ao colocar a instância dentro da func do botão evitamos que a viewOne segure a viewTwo na memoria.
        controllerTwo.didChangeBackgrounColorOfClassOne = { [weak self] in
            //adicionar o weak self torna a referencia fraca e libera ela da memoria ao fechar as views.
            self?.view.backgroundColor = .red
        }
        navigationController?.pushViewController(controllerTwo, animated: true)
    }

    @objc func close() {
        self.dismiss(animated: true)
    }

    deinit {
        print("FECHOU TELA UM")
    }

}

class ViewControllerTwo: UIViewController {

    lazy var viewTwo: UILabel = {
        let label = UILabel(frame: CGRect(x: 180, y: 40, width: 100, height: 80))
        label.text = "Tela Dois"
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        button.setTitle("fechar tela dois", for: .normal)
        button.center = view.center
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeClassTwo), for: .touchUpInside)
        return button
    }()

    var didChangeBackgrounColorOfClassOne: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(viewTwo)
        view.addSubview(closeButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didChangeBackgrounColorOfClassOne?()
    }

    deinit {
        print("FECHOU TELA DOIS")
    }

    @objc func closeClassTwo() {
        navigationController?.popViewController(animated: true)
    }

}
