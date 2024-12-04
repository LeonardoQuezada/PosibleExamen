import UIKit

class ListadoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtSueldo: UITextField!
    @IBOutlet weak var tbvLista: UITableView!

    // Modelo: Supervisor
    struct Supervisor {
        let nombre: String
        let sueldo: Double
    }

    var supervisores: [Supervisor] = [] // Lista de supervisores
    var supervisoresFiltrados: [Supervisor] = [] // Supervisores filtrados por sueldo

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarTableView()
        cargarSupervisores() // Carga datos iniciales
    }

    // MARK: - Configuración
    private func configurarTableView() {
        tbvLista.delegate = self
        tbvLista.dataSource = self

        // Registra una celda predeterminada (Subtitle) si no usas una celda personalizada
        tbvLista.register(UITableViewCell.self, forCellReuseIdentifier: "SupervisorCell")
    }

    private func cargarSupervisores() {
        // Simulación de datos iniciales
        supervisores = [
            Supervisor(nombre: "Juan Pérez", sueldo: 2500.0),
            Supervisor(nombre: "Ana Gómez", sueldo: 3200.0),
            Supervisor(nombre: "Carlos Sánchez", sueldo: 1800.0),
            Supervisor(nombre: "Luisa Fernández", sueldo: 4000.0)
        ]
        supervisoresFiltrados = supervisores // Inicialmente muestra todos
        tbvLista.reloadData()
    }

    // MARK: - Acciones de los Botones
    @IBAction func btnNuevo(_ sender: Any) {
        print("Navegar a la pantalla para agregar un nuevo supervisor")
    }

    @IBAction func btnConsultar(_ sender: Any) {
        filtrarSupervisoresPorSueldo()
    }

    private func filtrarSupervisoresPorSueldo() {
        guard let textoSueldo = txtSueldo.text, !textoSueldo.isEmpty, let sueldo = Double(textoSueldo) else {
            // Si no hay un sueldo válido, muestra todos los supervisores
            supervisoresFiltrados = supervisores
            tbvLista.reloadData()
            return
        }

        // Filtra los supervisores cuyo sueldo es mayor o igual al ingresado
        supervisoresFiltrados = supervisores.filter { $0.sueldo >= sueldo }
        tbvLista.reloadData()
    }

    // MARK: - Métodos del UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supervisoresFiltrados.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupervisorCell", for: indexPath)
        let supervisor = supervisoresFiltrados[indexPath.row]

        // Configura la celda
        cell.textLabel?.text = supervisor.nombre
        cell.detailTextLabel?.text = "Sueldo: S/ \(String(format: "%.2f", supervisor.sueldo))"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        return cell
    }

    // MARK: - Métodos del UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let supervisorSeleccionado = supervisoresFiltrados[indexPath.row]
        print("Supervisor seleccionado: \(supervisorSeleccionado.nombre)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
