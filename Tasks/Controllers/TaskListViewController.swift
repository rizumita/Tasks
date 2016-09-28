//
//  TaskListViewController.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swiftz

class TaskListViewController: UITableViewController, Promptable {

    @IBOutlet weak var addButtonItem: UIBarButtonItem! {
        didSet {
            Observable.combineLatest(addButtonItem.rx.tap
                                     .replace(prompt(title: "Add Task",
                                                     message: "Please input task's name",
                                                     inputTitle: "Create"))
                                     .flatMap(Observable.create)
                                     .map(Validator.validate(title:)),
                                     project.asObservable().ignoreNil(), resultSelector: Task.create)
            .map( project.get • const(()) )
            .ignoreNil()
            .map(TasksManager.fetch)
            .bindTo(tasks)
            .addDisposableTo(disposeBag)
        }
    }

    let project: Variable<Project?> = Variable(nil)

    fileprivate let tasks: Variable<[Task]> = Variable([])

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        project.asObservable().ignoreNil().do(onNext: { [weak self] in self?.title = $0.name })
            .map(TasksManager.fetch).bindTo(tasks).addDisposableTo(disposeBag)
        tasks.asObservable().bindTo(tableView.rx.items(cellIdentifier: "TaskCell", cellType: TaskCell.self)) {
            (row, element, cell) in
            guard let label = cell.textLabel else { return }
            element.rx.observe(String.self, "title").bindTo(label.rx.text).addDisposableTo(cell.disposeBag)
            element.rx.observe(Bool.self, "completed").ignoreNil().map(TaskCellDesign.textColor).bindTo(label.rx.textColor).addDisposableTo(cell.disposeBag)
        }.addDisposableTo(disposeBag)

        tableView.rx.itemDeleted.map(tasks.item(at:)).map(Task.delete(task:)).map(TasksManager.fetch).bindTo(tasks).addDisposableTo(disposeBag)
        tableView.rx.itemSelected.map(tasks.item(at:))
            .subscribe(onNext: { [weak self] in self?.performSegue(withIdentifier: "ShowTaskSegue", sender: $0) }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let task = sender as? Task, let controller = segue.destination as? TaskViewController {
            controller.task.value = task
        }
    }

}
