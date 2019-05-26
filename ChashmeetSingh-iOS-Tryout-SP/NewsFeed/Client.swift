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

import Foundation

class Client {
  
  static let shared = Client()
  var session: URLSession
  
  private init() {
    session = URLSession.shared
  }
  
  func getSources(_ completion: @escaping (_ result: [NewsSource]?, _ error: String?) -> Void) {
    let params = [Keys.APIKey : Values.NewsAPIKey, Keys.Country : Values.Country, Keys.Language : Values.Language]
    let url = URL(string: getApiUrl(apiMethod: Methods.Sources, apiParams: params))
    
    URLSession.shared.dataTask(with: url!) { data, _, _ in
      guard let data = data else { return }
      
      do {
        let websiteData = try JSONDecoder().decode(WebsiteDataWithSources.self, from: data)
        completion(websiteData.sources, nil)
      } catch {
        completion(nil, "Error serialising json")
      }
      
    }.resume()
  }
  
  func getTopHeadlines(_ source: String, _ completion: @escaping (_ result: [Article]?, _ error: String?) -> Void) {
    let params = [Keys.APIKey : Values.NewsAPIKey, Keys.Sources : source]
    let url = URL(string: getApiUrl(apiMethod: Methods.TopHeadlines, apiParams: params))
    
    URLSession.shared.dataTask(with: url!) { data, _, _ in
      guard let data = data else { return }
      
      do {
        let websiteData = try JSONDecoder().decode(WebsiteDataWithArticles.self, from: data)
        completion(websiteData.articles, nil)
      } catch {
        completion(nil, "Error serialising json")
      }
      
      }.resume()
  }
  
  // create a URL
  func getApiUrl(_ apiUrl: String = APIURLs.NewsAPI, apiMethod method: String, apiParams parameters: [String : String]) -> String {
    var baseURL = "\(apiUrl)\(method)?"
    for (key, value) in parameters {
      baseURL += "\(key)=\(value)&"
    }
    baseURL.removeLast()
    return baseURL
  }
  
}
