//
//  AllAuditoriumsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation
import Eureka

class AllAuditoriumsViewController: FormViewController {
  private let viewModel = AllAuditoriumsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    title = "Все аудитории"
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
      Section("По номеру")
      <<< TextRow("Название") {
        $0.value = ""
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.textFieldColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }

      +++
      Section("Корпус")
      <<< SegmentedRow<String>("Корпус") {
        $0.options = viewModel.buildingsNames
        $0.value = nil
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.textFieldColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }.onChange({ (row) in
        let secondRow = self.form.rowBy(tag: "Этаж") as? SegmentedRow<String>
        secondRow?.options = self.viewModel.floors(by: row.value ?? "")
        secondRow?.value = nil
        secondRow?.reload()
      })

      +++
      Section("Этаж")
      <<< SegmentedRow<String>("Этаж") {
        let firstRow = self.form.rowBy(tag: "Корпус") as? SegmentedRow<String>
        $0.options = viewModel.floors(by: firstRow?.value ?? "")
        $0.value = nil
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.textFieldColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }

      +++
      Section("Тип")
      <<< SegmentedRow<String>("Тип") {
        $0.options = viewModel.types
        $0.value = nil
      }.cellSetup { cell, _ in
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
      .onCellSelection { (_, _) in
        self.createButtonClicked()
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.textFieldColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
    }
  }

  @objc func createButtonClicked() {
    if form.validate().isEmpty {
      let title: TextRow! = form.rowBy(tag: "Название")
      let building: SegmentedRow<String>! = form.rowBy(tag: "Корпус") as? SegmentedRow<String>
      let floor: SegmentedRow<String>! = form.rowBy(tag: "Этаж") as? SegmentedRow<String>
      let type: SegmentedRow<String>! = form.rowBy(tag: "Тип") as? SegmentedRow<String>
      viewModel.findAuditories(name: title.value,
                               building: building.value,
                               floor: floor.value,
                               type: type.value)
    }
  }
}

extension AllAuditoriumsViewController: AllAuditoriumsViewModelDelegate {
  func found(auditoriums: [Auditorium]) {
    if auditoriums.isEmpty {
      self.showAlert(title: "Неудача", message: "По выбранным параметрам не найдено ни одной аудитории")
    } else {
      let storyBoard = UIStoryboard(name: "Auditoriums", bundle: nil)
      let auditoriumsListViewController = storyBoard.instantiateViewController(withIdentifier: "auditoriumTableVC") as! AuditoriumsListViewController
      auditoriumsListViewController.configure(with: auditoriums)
      self.show(auditoriumsListViewController, sender: self)
      let navigationBarAppearace = UINavigationBar.appearance()
      navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
      navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
    }
  }

  func searchFailed(with reason: NetworkError) {
    self.showErrorAlert(reason)
  }

  func refreshForm() {
    self.tableView.reloadData()
  }
}
