import SwiftUI
import UIKit

struct MyPageView: View {
    var body: some View {
        MyPageViewControllerWrapper()
    }
}

struct MyPageViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyPageViewController {
        return MyPageViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyPageViewController, context: Context) {}
}

class MyPageViewController: UIViewController {
    private var tableView: UITableView!
    private let items = ["시청내역", "찜목록", "내 정보 설정", "고객센터"]
    private let icons = ["clock", "heart", "person.circle", "phone"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Set initial focus to the first item
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.tableView.delegate?.tableView?(self.tableView, didSelectRowAt: indexPath)
        }
    }
}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row]
        content.image = UIImage(systemName: icons[indexPath.row])
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle selection if needed
        print("Selected item: \(items[indexPath.row])")
    }
}

