/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

private let cellIdentifier = "newsFeedCell"

class NewsFeedViewController: UITableViewController {
  
  var viewModel = NewsFeedListViewModel()
  var newsSourceViewModel: Box<NewsSourceViewModel>!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupBindings()
  }
  
  func setupBindings() {
    // 1
    newsSourceViewModel.bind { (model) in
      // 2
      self.title = model.sourceTitle
      // 3
      self.viewModel.newsSourceID = model.id
      // 4
      self.viewModel.fetchNewsFeeds()
    }
    
    // Adds a listener to the data source
    // 1
    viewModel.newsFeedViewModels.bind { [weak self] _ in
      // 2
      guard let self = self else {
        return
      }
      // 3
      DispatchQueue.main.async {
        // 4
        self.tableView.reloadData()
      }
    }
  }
  
}

extension NewsFeedViewController {

  // MARK: - Table view data source
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.newsFeedViewModels.value.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath
    ) as? NewsFeedCell else { return UITableViewCell() }
    
    // 1
    let newsFeedViewModel = viewModel.newsFeedViewModels.value[indexPath.row]
    // 2
    cell.newsFeedViewModel = newsFeedViewModel
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

}
