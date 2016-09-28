//
//  ProjectListViewController.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swiftz

class ProjectListViewController: UITableViewController, AlertDisplayable, Promptable {

    @IBOutlet weak var addButtonItem: UIBarButtonItem! {
        didSet {
            addButtonItem.rx.tap
            .replace(prompt(title: "Add Project",
                                message: "Please input project's name",
                                inputTitle: "Create"))
            .flatMap(Observable.create)
            .map(Validator.validate(name:))
            .do(onError: showMessage • TasksError.toMessage)
            .map(Project.create)
            .ignoreValue()
            .map(ProjectsManager.fetch)
            .retry()
            .bindTo(projects)
            .addDisposableTo(disposeBag)
        }
    }
    
    fileprivate let projects: Variable<[Project]> = Variable([])

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        projects.value = (try? ProjectsManager.fetch()) ?? []

        projects.asObservable().bindTo(tableView.rx.items(cellIdentifier: "ProjectCell", cellType: UITableViewCell.self)) {
            (row, element, cell) in
            cell.textLabel?.text = element.name
        }.addDisposableTo(disposeBag)

        tableView.rx.itemSelected.map(projects.item(at:))
            .subscribe(onNext: { [weak self] in self?.performSegue(withIdentifier: "ShowTasksSegue", sender: $0) }).addDisposableTo(disposeBag)
        tableView.rx.itemDeleted.map(projects.item(at:)).map(Project.delete).ignoreValue()
            .map(ProjectsManager.fetch).bindTo(projects).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let project = sender as? Project, let controller = segue.destination as? TaskListViewController {
            controller.project.value = project
        }
    }

}
