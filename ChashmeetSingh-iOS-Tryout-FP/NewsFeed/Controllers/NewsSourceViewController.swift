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

private let cellIdentifier = "newsSourceCell"

class NewsSourceViewController: UITableViewController {
  
  var viewModel = NewsSourceListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "News Sources"
    setupBindings()
  }
  
  // Adds a listener to the data source
  func setupBindings() {
    // 1
    viewModel.newsSourceViewModels.bind { [weak self] _ in
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
  
  // MARK: - Table view data source
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.newsSourceViewModels.value.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath
    ) as? NewsSourceCell else { return UITableViewCell() }
    // 1
    let newsSourceViewModel = viewModel.newsSourceViewModels.value[indexPath.row]
    // 2
    cell.newsSourceViewModel = newsSourceViewModel
    // 3
    cell.tag = indexPath.row
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? NewsFeedViewController,
      let sender = sender as? UITableViewCell,
      segue.identifier == "showFeed" {
      
      let index = sender.tag
      destination.newsSourceViewModel = Box(viewModel.newsSourceViewModels.value[index])
    }
  }
  
}
