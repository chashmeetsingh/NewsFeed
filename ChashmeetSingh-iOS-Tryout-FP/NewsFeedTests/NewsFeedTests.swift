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

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  // Test if the news source has a language of "en"
  func testNewsSourceViewModelWithENLanguage() {
    let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news description", url: "https://abcnews.go.com", language: "en")
    let newsSourceViewModel = NewsSourceViewModel(newsSource: newsSource)
    
    XCTAssertEqual(newsSource.name, newsSourceViewModel.sourceTitle)
    XCTAssertEqual(newsSource.id, newsSourceViewModel.id)
    XCTAssertEqual(newsSource.description, newsSourceViewModel.newsDescription)
    XCTAssertEqual(newsSource.url, newsSourceViewModel.newsUrl)
    XCTAssertEqual(newsSource.language, newsSourceViewModel.language)
    XCTAssertEqual(.disclosureIndicator, newsSourceViewModel.accessoryType)
  }
  
  // Test if the news source doesn't have a language of "en"
  func testNewsSourceViewModelWithoutENLanguage() {
    let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news description", url: "https://abcnews.go.com", language: "au")
    let newsSourceViewModel = NewsSourceViewModel(newsSource: newsSource)
    
    XCTAssertEqual(.none, newsSourceViewModel.accessoryType)
  }
  
  // Test the values in the feed model
  func testNewsFeedModel() {
    let article = Article(title: "BJP victory in India", description: "BJP won Indian elections with 303 seats", author: "Chashmeet Singh")
    let newsFeedViewModel = NewsFeedViewModel(article: article)
    
    XCTAssertEqual(article.title, newsFeedViewModel.newsTitle)
    XCTAssertEqual(article.description, newsFeedViewModel.newsDescription)
    XCTAssertEqual(article.author, newsFeedViewModel.newsAuthor)
  }

}
