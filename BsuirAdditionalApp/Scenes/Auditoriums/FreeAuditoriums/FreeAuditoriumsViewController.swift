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
    title = "Свободные аудитории".localized
    self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Искать".localized, style: .plain, target: self, action: #selector(self.createButtonClicked)), animated: false)
    navigationController?.title = nil
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    setupViewModel()
    self.tableView?.backgroundColor = AppColors.backgroundColor.uiColor()
    initializeForm()
  }

  private func setupViewModel() {
    viewModel.delegate = self
    viewModel.getSavedBuildings()
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
      Section("Корпус".localized)
      <<< SegmentedRow<String>("Корпус".localized) {
        $0.options = viewModel.buildingsNames
        $0.value = "1"
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.primaryColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }.onChange({ (row) in
        let secondRow = self.form.rowBy(tag: "Этаж".localized) as? SegmentedRow<String>
        secondRow?.options = self.viewModel.floors(by: row.value ?? "")
        secondRow?.value = nil
        secondRow?.reload()
      })

      +++
      Section("Этаж".localized)
      <<< SegmentedRow<String>("Этаж".localized) {
        let firstRow = self.form.rowBy(tag: "Корпус".localized) as? SegmentedRow<String>
        $0.options = viewModel.floors(by: firstRow?.value ?? "")
        $0.value = nil
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.primaryColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }

      +++
      Section("Когда".localized)
      <<< DateRow("Дата".localized) {
        $0.title = $0.tag
        $0.value = Date()
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.primaryColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }

      <<< TimeRow("Время".localized) {
        $0.title = $0.tag
        $0.value = Date()
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.primaryColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
      }

      +++
      Section()
      <<< ButtonRow("Искать".localized) { (row: ButtonRow) -> Void in
        row.title = "Искать".localized
      }
      .onCellSelection { (_, _) in
        self.createButtonClicked()
      }.cellSetup { cell, _ in
        cell.textLabel?.textColor = .white
        cell.textLabel?.tintColor = AppColors.accentColor.uiColor()
        cell.backgroundColor = AppColors.primaryColor.uiColor()
        cell.tintColor = AppColors.accentColor.uiColor()
    }

  }

  @objc func createButtonClicked() {
    if form.validate().isEmpty {
      let building: SegmentedRow<String>! = form.rowBy(tag: "Корпус".localized) as? SegmentedRow<String>
      let floor: SegmentedRow<String>! = form.rowBy(tag: "Этаж".localized) as? SegmentedRow<String>
      let date: DateRow! = form.rowBy(tag: "Дата".localized)
      let time: TimeRow! = form.rowBy(tag: "Время".localized)
      viewModel.findAuditories(building: building.value,
                               floor: floor.value,
                               date: date.value,
                               time: time.value)
    }
  }
}

extension FreeAuditoriumsViewController: FreeAuditoriumsViewModelDelegate {
  func found(auditoriums: [Auditorium]) {
    if auditoriums.isEmpty {
      self.showAlert(title: "Неудача".localized, message: "По выбранным параметрам не найдено ни одной аудитории".localized)
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
