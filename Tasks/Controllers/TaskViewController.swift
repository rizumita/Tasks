//
//  TaskViewController.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swiftz

class TaskViewController: UIViewController, Navigatable {

    @IBOutlet weak var saveButtonItem: UIBarButtonItem! {
        didSet {
            Observable.combineLatest(taskObservable,
                                     editingTask.asObservable().sample(saveButtonItem.rx.tap),
                                     resultSelector: EditingTask.update(task:by:))
            .takeUntil(cancelSubject)
//            .ignoreValue() // ignoreValueもしくはconstを利用する
            .subscribe(onNext: pop(animated: true) • const(())).addDisposableTo(disposeBag)
        }
    }

    @IBOutlet weak var cancelButtonItem: UIBarButtonItem! {
        didSet {
            cancelButtonItem.rx.tap.do(onNext: cancelSubject.onNext).subscribe(onNext: pop(animated: true)).addDisposableTo(disposeBag)
        }
    }

    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            taskObservable.map({ $0.title }).bindTo(titleTextField.rx.text).addDisposableTo(disposeBag)
            Observable.combineLatest(titleTextField.rx.textInput.text.skip(1).map(Validator.validate(title:)),
                                     editingTask.asObservable().distinctUntilChanged({ $0 == $1 }),
                                     resultSelector: EditingTask.set(title:to:))
                .bindTo(editingTask).addDisposableTo(disposeBag)
        }
    }
    @IBOutlet weak var completedSwitch: UISwitch! {
        didSet {
            taskObservable.map({ $0.completed }).bindTo(completedSwitch.rx.value).addDisposableTo(disposeBag)
            Observable.combineLatest(completedSwitch.rx.value,
                                     editingTask.asObservable().distinctUntilChanged({ $0 == $1 }),
                                     resultSelector: EditingTask.set(completed:to:))
                .bindTo(editingTask).addDisposableTo(disposeBag)
        }
    }

    let task: Variable<Task?> = Variable(nil)
    fileprivate let editingTask: Variable<EditingTask> = Variable(EditingTask(title: "", completed: false))

    fileprivate lazy var taskObservable: Observable<Task> = {
        return self.task.asObservable().ignoreNil().shareReplay(1)
    }()
    
    fileprivate let cancelSubject = ReplaySubject<()>.create(bufferSize: 1)

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        taskObservable.map(TaskTranslator.translate).bindTo(editingTask).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
