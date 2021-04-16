//
//  SearchView.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import UIKit

enum SearchViewEvents {
    case dismis
}

class SearchView: View {
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
    }

}

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCity(at: indexPath.row)
        self.delegate?.view(view: self, didPerformAction: SearchViewEvents.dismis, userInfo: nil)
    }
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return SearchCell() }
        cell.setData(city: viewModel.cityAt(index:indexPath.row))
        return cell
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let ci = viewModel.filter(with: searchText)
        tableView?.reloadData()
        print(ci.count)
    }

}
