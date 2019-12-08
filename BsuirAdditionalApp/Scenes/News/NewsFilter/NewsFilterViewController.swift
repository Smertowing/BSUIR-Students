//
//  NewsFilterViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation
import Eureka

class NewsFilterViewController: FormViewController {

    private let viewModel = NewsFilterViewModel()
    
    private let selectableSection = SelectableSection<ListCheckRow<String>>("Источники публикаций", selectionType: .multipleSelection)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Фильтр"
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Применить", style: .plain, target: self, action: #selector(self.createButtonClicked)), animated: false)
        navigationController?.title = nil
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
        setupViewModel()
        
        self.tableView?.backgroundColor = AppColors.barsColor.uiColor()
        initializeForm()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getSavedFilter()
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
            Section("Название")
            <<< TextRow("Название") {
                $0.value = viewModel.selectedTitle
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }
            
            +++
            Section("Содержание")
            <<< TextAreaRow("Содержание") {
                $0.value = viewModel.selectedContent
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }
            
            +++
            selectableSection

            let types = NewsSourceType.allValues
            for type in types {
                form.last! <<< ListCheckRow<String>(type.rawValue){ listRow in
                    listRow.title = type.rawValue
                    listRow.selectableValue = type.rawValue
                    listRow.value = viewModel.selectedSources.contains(type) ? "selected" : nil
                }.cellSetup{ cell, row in
                    cell.textLabel?.textColor = .white
                    cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                    cell.backgroundColor = AppColors.textFieldColor.uiColor()
                    cell.tintColor = AppColors.accentColor.uiColor()
                }
            }
        
            form
            +++
            Section("Даты публикаций")
            <<< SwitchRow("Ограничение начальной даты"){
                $0.title = $0.tag
                $0.value = viewModel.first != nil
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }
            
            <<< DateTimeInlineRow("Начальная") {
                $0.title = "От:"
                $0.value = viewModel.first ?? Date()
                $0.hidden = .function(["Ограничение начальной даты"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Ограничение начальной даты")
                    return row.value ?? false == false
                })
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }
            
            <<< SwitchRow("Ограничение конечной даты"){
                $0.title = $0.tag
                $0.value = viewModel.second != nil
            }.cellSetup{ cell, row in
                cell.textLabel?.textColor = .white
                cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
                cell.backgroundColor = AppColors.textFieldColor.uiColor()
                cell.tintColor = AppColors.accentColor.uiColor()
            }
            
            <<< DateTimeInlineRow("Конечная") {
                $0.title = "До:"
                $0.value = viewModel.second ?? Date()
                $0.hidden = .function(["Ограничение конечной даты"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Ограничение конечной даты")
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
            <<< ButtonRow("Применить") { (row: ButtonRow) -> Void in
                row.title = "Применить"
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
            let title: TextRow! = form.rowBy(tag: "Название")
            let content: TextAreaRow! = form.rowBy(tag: "Содержание")
            let sources: SelectableSection<ListCheckRow>! = selectableSection
            let firstDate: DateTimeInlineRow! = form.rowBy(tag: "Начальная")
            let secondDate: DateTimeInlineRow! = form.rowBy(tag: "Конечная")
            var types: [NewsSourceType] = []
            for source in sources.selectedRows() {
                types.append(NewsSourceType(rawValue: source.selectableValue!)!)
            }
            viewModel.updateFilter(title: title.value,
                                   content: content.value,
                                   sources: types,
                                   startDate: firstDate.isHidden ? nil : firstDate.value!,
                                   endDate: secondDate.isHidden ? nil : secondDate.value!)
        }
    }
}

extension NewsFilterViewController: NewsFilterViewModelDelegate {
    
    func onSavingFailed(with reason: NetworkError) {
        self.showErrorAlert(reason)
    }
    
    func filterSaved() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshForm() {
        tableView.reloadData()
    }

}
