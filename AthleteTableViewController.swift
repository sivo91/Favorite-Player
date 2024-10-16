import UIKit

class AthleteTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let athleteCell = "AthleteCell"
    }

    var athletes: [Athlete] = []

    @IBSegueAction func AddAthlete(_ coder: NSCoder) -> AthleteFormViewController? {
        return AthleteFormViewController(coder: coder)
    }
    
    @IBSegueAction func EditAthlete(_ coder: NSCoder, sender: Any?) -> AthleteFormViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let athleteToEdit = athletes[indexPath.row]
            let viewController = AthleteFormViewController(coder: coder)
            viewController?.athlete = athleteToEdit
            return viewController
        }
        return AthleteFormViewController(coder: coder)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let athleteFormViewController = segue.source as? AthleteFormViewController,
              let athlete = athleteFormViewController.athlete else {
            return
        }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Update existing athlete
            athletes[selectedIndexPath.row] = athlete
        } else {
            // Add new athlete
            athletes.append(athlete)
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.athleteCell, for: indexPath)
        
        let athlete = athletes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = athlete.name
        content.secondaryText = athlete.description
        cell.contentConfiguration = content
        
        return cell
    }
}

