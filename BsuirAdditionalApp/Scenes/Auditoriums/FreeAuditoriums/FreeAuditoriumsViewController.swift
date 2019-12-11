//
//  FreeAuditoriumsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/9/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation
import Eureka

class FreeAuditoriumsViewController: FormViewController {

    private let viewModel = FreeAuditoriumsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Свободные аудитории"
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Искать", style: .plain, target: self, action: #selector(self.createButtonClicked)), animated: false)
        navigationController?.title = nil
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
        setupViewModel()
        
        self.tableView?.backgroundColor = AppColors.barsColor.uiColor()
        initializeForm()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getSavedBuildings()
        viewModel.fetchBuildings()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.gray
        }
    }
    
    private func initializeForm() {
        
        form.inlineRowHideOptions = InlineRowHideOptions.AnotherInlineRowIsShown.union(.FirstResponderChanges)
        
        form
            +++
            Section("Корпус")
            <<< SegmentedRow<String>("Корпус"){
                $0.options = viewModel.buildingsNames
                $0.value = "1"
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }.onChange({ (row) in
                let secondRow = self.form.rowBy(tag: "Этаж") as! SegmentedRow<String>
                secondRow.options = self.viewModel.floors(by: row.value ?? "")
                secondRow.value = nil
                secondRow.reload()
            })
            
            +++
            Section("Этаж")
            <<< SegmentedRow<String>("Этаж"){
                let firstRow = self.form.rowBy(tag: "Корпус") as! SegmentedRow<String>
                $0.options = viewModel.floors(by: firstRow.value ?? "")
                $0.value = nil
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

            +++
            Section("Когда ")
            <<< SwitchRow("Выбрать дату"){
                $0.title = $0.tag
                $0.value = nil
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

            <<< DateInlineRow("Дата") {
                $0.title = ""
                $0.value = Date()
                $0.hidden = .function(["Выбрать дату"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Выбрать дату")
                    return row.value ?? false == false
                })
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

            <<< SwitchRow("Выбрать время"){
                $0.title = $0.tag
                $0.value = nil
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

            <<< TimeInlineRow("Время") {
                $0.title = ""
                $0.value = Date()
                $0.hidden = .function(["Выбрать время"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Выбрать время")
                    return row.value ?? false == false
                })
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

            +++
            Section()
            <<< ButtonRow("Искать") { (row: ButtonRow) -> Void in
                row.title = "Искать"
                }
                .onCellSelection { (cell, row) in
                    self.createButtonClicked()
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }

    }

    @objc func createButtonClicked() {
        if form.validate().isEmpty {
            let building: SegmentedRow<String>! = form.rowBy(tag: "Корпус") as? SegmentedRow<String>
            let floor: SegmentedRow<String>! = form.rowBy(tag: "Этаж") as? SegmentedRow<String>
            let date: DateInlineRow! = form.rowBy(tag: "Дата")
            let time: TimeInlineRow! = form.rowBy(tag: "Время")
            viewModel.findAuditories(building: building.value,
                                     floor: floor.value,
                                     date: date.value,
                                     time: time.value)
        }
    }
}

extension FreeAuditoriumsViewController: FreeAuditoriumsViewModelDelegate {
    
    func found(auditoriums: [Auditorium]) {
        let storyBoard = UIStoryboard(name: "Auditoriums", bundle: nil)
        let auditoriumsListViewController = storyBoard.instantiateViewController(withIdentifier: "auditoriumTableVC") as! AuditoriumsListViewController
        auditoriumsListViewController.configure(with: auditoriums)
        self.show(auditoriumsListViewController, sender: self)
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
        navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
    }
    
    func searchFailed(with reason: NetworkError) {
        self.showErrorAlert(reason)
    }
    
    func refreshForm() {
        self.tableView.reloadData()
    }

}

