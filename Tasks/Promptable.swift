//
//  Promptable.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift

typealias PromptingAlertAction = (String, UIAlertActionStyle, (UIAlertController) -> (UIAlertAction) -> ())

protocol Promptable {

    func alertController(title: String?, message: String?, actions: [PromptingAlertAction]) -> UIAlertController

    func promptTextFieldActions(inputTitle: String, inputtedAction: @escaping (String?) -> (), cancelAction: @escaping () -> ()) -> [PromptingAlertAction]

    func prompt(title: String?,
                message: String?,
                inputTitle: String) -> (AnyObserver<String?>) -> Disposable

}

extension Promptable where Self: UIViewController {

    func alertController(title: String?, message: String?, actions: [PromptingAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach {
            actionTitle, style, handler in
            alertController.addAction(UIAlertAction(title: actionTitle, style: style, handler: handler(alertController)))
        }
        return alertController
    }

    func promptTextFieldActions(inputTitle: String,
                                inputtedAction: @escaping (String?) -> (),
                                cancelAction: @escaping () -> ()) -> [PromptingAlertAction] {
        return [
                ("Cancel", .cancel, {
                    _ in {
                        _ in cancelAction()
                    }
                }),
                (inputTitle, .default, {
                    alertController in {
                        _ in inputtedAction(alertController.textFields?.first?.text)
                    }
                })
        ]
    }

    func prompt(title: String?,
                message: String?,
                inputTitle: String) -> (AnyObserver<String?>) -> Disposable {
        return {
            [weak self] observer in
            guard let `self` = self else {
                return Disposables.create()
            }

            let alert = self.alertController(title: title,
                                             message: message,
                                             actions: self.promptTextFieldActions(inputTitle: inputTitle, inputtedAction: {
                                                 string in
                                                 observer.onNext(string)
                                             }, cancelAction: {
                                                 observer.onCompleted()
                                             }))

            alert.addTextField(configurationHandler: nil)

            self.present(alert, animated: true, completion: nil)

            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }

}
